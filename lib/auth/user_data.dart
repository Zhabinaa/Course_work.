import 'package:flutter/material.dart';
import 'package:flutter_application_2/cart/cart.dart';
import 'package:flutter_application_2/whaitlist/whaitlist.dart';
import 'package:mobx/mobx.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

part 'user_data.g.dart';

// This is the class used by rest of your codebase
class UserData = UserDataStore with _$UserData;

// The store-class
abstract class UserDataStore with Store {
  @observable
  int totalprice = 0;

  var supabase = Supabase.instance.client;

  User? user = null;

  @observable
  // ignore: avoid_init_to_null
  var userData = null;

  @observable
  var newEmail = TextEditingController();

  @observable
  var oldPassword = TextEditingController();

  @observable
  var newPassword = TextEditingController();

  @observable
  ObservableList<String> addressList = ObservableList<String>();

  @observable
  ObservableList<String> cardList = ObservableList<String>();

  @observable
  ObservableList<Map<String, dynamic>> orders =
      ObservableList<Map<String, dynamic>>();

  @observable
  ObservableList<Map<String, dynamic>> cartItems =
      ObservableList<Map<String, dynamic>>();

  @observable
  ObservableList<Map<String, dynamic>> whaitlistItems =
      ObservableList<Map<String, dynamic>>();

  @observable
  var adress = TextEditingController();

  @observable
  var card = TextEditingController();

  void userCheck() {
    user = supabase.auth.currentUser;
  }

  Future<void> signIn(String email, String password) async {
    try {
      final AuthResponse res = await supabase.auth.signInWithPassword(
        email: email,
        password: password,
      );
      print(res);
      print(res.user);
      if (res.user != null) {
        user = res.user;
        getUserData();
        getCart();
        loadAdresses();
        fetchOrderHistory(user!.id);
        getWhaitlist();
      } else {
        throw Exception('Пользователь не найден');
      }
    } catch (error) {
      print(error);
      rethrow;
    }
  }

  Future<void> signUp(String email, String password) async {
    try {
      final AuthResponse res = await supabase.auth.signUp(
        email: email,
        password: password,
      );
      print(res);
      if (res.user != null) {
        await signIn(email, password);
        await supabase.from('userdata').insert({
          'uid': res.user!.id,
        });
      } else {
        throw Exception('Failed to create user');
      }
    } catch (error) {
      print(error);
      rethrow;
    }
  }

  Future<void> changeEmail(String newEmail) async {
    try {
      final user = supabase.auth.currentUser;
      if (user != null) {
        await supabase.auth.updateUser(
          UserAttributes(
            email: newEmail,
            data: {'email_change_suppress_notification': true},
          ),
        );
      } else {
        throw Exception('User not authenticated');
      }
      // ignore: empty_catches
    } catch (error) {}
  }

  Future<void> signOut() async {
    await supabase.auth.signOut();
    user = null;
    userData = null;
    cartItems.clear();
    whaitlistItems.clear();
  }

  Future<void> changePassword(String newP) async {
    try {
      final user = supabase.auth.currentUser;
      if (user != null) {
        await supabase.auth.updateUser(
          UserAttributes(
            password: newP,
          ),
        );
      } else {
        throw Exception('User not authenticated');
      }
      // ignore: empty_catches
    } catch (error) {}
    oldPassword.clear();
    newPassword.clear();
  }

  Future<void> addAdress(String address) async {
    addressList.add(address);
    await updateAdressesInDatabase();
  }

  Future<void> modifyAddress(int index, String newAddress) async {
    if (index >= 0 && index < addressList.length) {
      addressList[index] = newAddress;
      await updateAdressesInDatabase();
    } else {}
  }

  Future<void> deleteAddress(int index) async {
    if (index >= 0 && index < addressList.length) {
      addressList.removeAt(index);
      await updateAdressesInDatabase();
    } else {}
  }

  Future<void> loadAdresses() async {
    addressList.clear();
    final response =
        await supabase.from('userdata').select().eq('uid', user!.id).single();
    final userData = response;
    if (userData['adresses'] != null) {
      addressList.addAll(userData['adresses'].split(',').toList());
    }
  }

  Future<void> updateAdressesInDatabase() async {
    String adresses = addressList.join(',');
    await supabase
        .from('userdata')
        .update({'adresses': adresses}).eq('uid', user!.id);
  }

  Future<void> addCard(String card) async {
    cardList.add(card);
    await updateCardsInDatabase();
  }

  Future<void> modifyCard(int index, String newCard) async {
    if (index >= 0 && index < cardList.length) {
      cardList[index] = newCard;
      await updateCardsInDatabase();
    } else {}
  }

  Future<void> deleteCard(int index) async {
    if (index >= 0 && index < cardList.length) {
      cardList.removeAt(index);
      await updateCardsInDatabase();
    } else {}
  }

  Future<void> loadCards() async {
    cardList.clear();
    final response =
        await supabase.from('userdata').select().eq('uid', user!.id).single();
    final userData = response;
    if (userData['cards'] != null) {
      cardList.addAll(userData['cards'].split(',').toList());
    }
    print(cardList);
  }

  Future<void> updateCardsInDatabase() async {
    String cards = cardList.join(',');
    await supabase
        .from('userdata')
        .update({'cards': cards}).eq('uid', user!.id);
  }

  Future<void> getCart() async {
    cartItems.clear();
    cartItems.addAll(await Cart().fetchCartItems(user!.id));
    print(cartItems);
    countPrice();
  }

  void countPrice() {
    totalprice = 0;
    for (int i = 0; i < cartItems.length; i++) {
      final item = cartItems[i];
      totalprice += int.parse(item['price'].toString()) *
          int.parse(item['count'].toString());
    }
  }

  Future<void> getUserData() async {
    userData =
        await supabase.from('userdata').select().eq('uid', user!.id).single();
  }

  Future<void> placeOrder(String paymentMethod, String? address) async {
    if (address == null || address.isEmpty) {
      throw Exception('Address cannot be null or empty');
    }

    if (cartItems.isEmpty) {
    } else {
      final orderDetails = {
        'user_id': user!.id,
        'items': cartItems.map((item) => item['name']).toList(),
        'total_price': totalprice,
        'payment_method': paymentMethod,
        'address': address,
        'order_date': DateTime.now().toIso8601String(),
      };

      await supabase.from('orders').insert(orderDetails);
      final cart = Cart();
      await cart.clearCart(user!.id.toString());
      cartItems.clear();
      countPrice();
      fetchOrderHistory(user!.id.toString());
    }
  }

  Future<void> fetchOrderHistory(String userId) async {
    final response =
        await supabase.from('orders').select('*').eq('user_id', userId);
    orders.addAll(List<Map<String, dynamic>>.from(response));
    print(orders);
  }

  Future<void> getWhaitlist() async {
    whaitlistItems.clear();
    whaitlistItems.addAll(await Whaitlist().fetchWhaitlistItems(user!.id));
  }
}
