// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_data.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic, no_leading_underscores_for_local_identifiers

mixin _$UserData on UserDataStore, Store {
  late final _$totalpriceAtom =
      Atom(name: 'UserDataStore.totalprice', context: context);

  @override
  int get totalprice {
    _$totalpriceAtom.reportRead();
    return super.totalprice;
  }

  @override
  set totalprice(int value) {
    _$totalpriceAtom.reportWrite(value, super.totalprice, () {
      super.totalprice = value;
    });
  }

  late final _$userDataAtom =
      Atom(name: 'UserDataStore.userData', context: context);

  @override
  dynamic get userData {
    _$userDataAtom.reportRead();
    return super.userData;
  }

  @override
  set userData(dynamic value) {
    _$userDataAtom.reportWrite(value, super.userData, () {
      super.userData = value;
    });
  }

  late final _$newEmailAtom =
      Atom(name: 'UserDataStore.newEmail', context: context);

  @override
  TextEditingController get newEmail {
    _$newEmailAtom.reportRead();
    return super.newEmail;
  }

  @override
  set newEmail(TextEditingController value) {
    _$newEmailAtom.reportWrite(value, super.newEmail, () {
      super.newEmail = value;
    });
  }

  late final _$oldPasswordAtom =
      Atom(name: 'UserDataStore.oldPassword', context: context);

  @override
  TextEditingController get oldPassword {
    _$oldPasswordAtom.reportRead();
    return super.oldPassword;
  }

  @override
  set oldPassword(TextEditingController value) {
    _$oldPasswordAtom.reportWrite(value, super.oldPassword, () {
      super.oldPassword = value;
    });
  }

  late final _$newPasswordAtom =
      Atom(name: 'UserDataStore.newPassword', context: context);

  @override
  TextEditingController get newPassword {
    _$newPasswordAtom.reportRead();
    return super.newPassword;
  }

  @override
  set newPassword(TextEditingController value) {
    _$newPasswordAtom.reportWrite(value, super.newPassword, () {
      super.newPassword = value;
    });
  }

  late final _$addressListAtom =
      Atom(name: 'UserDataStore.addressList', context: context);

  @override
  ObservableList<String> get addressList {
    _$addressListAtom.reportRead();
    return super.addressList;
  }

  @override
  set addressList(ObservableList<String> value) {
    _$addressListAtom.reportWrite(value, super.addressList, () {
      super.addressList = value;
    });
  }

  late final _$cardListAtom =
      Atom(name: 'UserDataStore.cardList', context: context);

  @override
  ObservableList<String> get cardList {
    _$cardListAtom.reportRead();
    return super.cardList;
  }

  @override
  set cardList(ObservableList<String> value) {
    _$cardListAtom.reportWrite(value, super.cardList, () {
      super.cardList = value;
    });
  }

  late final _$ordersAtom =
      Atom(name: 'UserDataStore.orders', context: context);

  @override
  ObservableList<Map<String, dynamic>> get orders {
    _$ordersAtom.reportRead();
    return super.orders;
  }

  @override
  set orders(ObservableList<Map<String, dynamic>> value) {
    _$ordersAtom.reportWrite(value, super.orders, () {
      super.orders = value;
    });
  }

  late final _$cartItemsAtom =
      Atom(name: 'UserDataStore.cartItems', context: context);

  @override
  ObservableList<Map<String, dynamic>> get cartItems {
    _$cartItemsAtom.reportRead();
    return super.cartItems;
  }

  @override
  set cartItems(ObservableList<Map<String, dynamic>> value) {
    _$cartItemsAtom.reportWrite(value, super.cartItems, () {
      super.cartItems = value;
    });
  }

  late final _$whaitlistItemsAtom =
      Atom(name: 'UserDataStore.whaitlistItems', context: context);

  @override
  ObservableList<Map<String, dynamic>> get whaitlistItems {
    _$whaitlistItemsAtom.reportRead();
    return super.whaitlistItems;
  }

  @override
  set whaitlistItems(ObservableList<Map<String, dynamic>> value) {
    _$whaitlistItemsAtom.reportWrite(value, super.whaitlistItems, () {
      super.whaitlistItems = value;
    });
  }

  late final _$adressAtom =
      Atom(name: 'UserDataStore.adress', context: context);

  @override
  TextEditingController get adress {
    _$adressAtom.reportRead();
    return super.adress;
  }

  @override
  set adress(TextEditingController value) {
    _$adressAtom.reportWrite(value, super.adress, () {
      super.adress = value;
    });
  }

  late final _$cardAtom = Atom(name: 'UserDataStore.card', context: context);

  @override
  TextEditingController get card {
    _$cardAtom.reportRead();
    return super.card;
  }

  @override
  set card(TextEditingController value) {
    _$cardAtom.reportWrite(value, super.card, () {
      super.card = value;
    });
  }

  @override
  String toString() {
    return '''
totalprice: ${totalprice},
userData: ${userData},
newEmail: ${newEmail},
oldPassword: ${oldPassword},
newPassword: ${newPassword},
addressList: ${addressList},
cardList: ${cardList},
orders: ${orders},
cartItems: ${cartItems},
whaitlistItems: ${whaitlistItems},
adress: ${adress},
card: ${card}
    ''';
  }
}
