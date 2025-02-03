import 'package:flutter/material.dart';
import 'package:flutter_application_2/addition/alert_clear_cart.dart';
import 'package:flutter_application_2/auth/user_data.dart';
import 'package:flutter_application_2/cart/cart.dart';
import 'package:flutter_application_2/order_form.dart';
import 'package:flutter_application_2/order_form/order_form_store.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:go_router/go_router.dart';

import 'home_page.dart';

class CartScreen extends StatelessWidget {
  final UserData userData;
  final Cart cart;

  const CartScreen({super.key, required this.userData, required this.cart});

  @override
  Widget build(BuildContext context) {
    final orderFormStore = OrderFormStore();

    return Scaffold(
        body: Column(
      children: [
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          color: const Color.fromARGB(255, 234, 121, 158),
          height: 70,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  elevation: 0,
                  backgroundColor: Colors.transparent,
                  shadowColor: Colors.transparent,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(0),
                    side: const BorderSide(color: Colors.transparent),
                  ),
                ),
                onPressed: () => context.go('/'),
                child: const Text(
                  'Корзина',
                  style: TextStyle(
                    fontFamily: 'Nekst',
                    fontSize: 40,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Observer(
                    builder: (_) => Text(
                      'Всего товара на: ${userData.totalprice}\$',
                      style: const TextStyle(
                          fontFamily: 'Nekst',
                          fontSize: 25,
                          color: Colors.white),
                    ),
                  ),
                  IconButton(
                      onPressed: () {
                        showDialog(
                            context: context,
                            builder: (context) => AlertClearCart(
                                  alertText:
                                      'Ты уверен. что хочешь очистить корзину?',
                                  onClick: () async {
                                    await cart.clearCart(
                                        userData.user!.id.toString());
                                    // ignore: use_build_context_synchronously
                                    Navigator.pop(context);
                                    // ignore: use_build_context_synchronously
                                    ScaffoldMessenger.of(context).showSnackBar(
                                        const SnackBar(
                                            content: Text('Корзина очищена')));
                                    userData.getCart();
                                  },
                                ));
                      },
                      icon: const Icon(
                        size: 40,
                        Icons.close_rounded,
                        color: Colors.white,
                      )),
                  TextButton(
                      onPressed: () {
                        if (userData.user != null) {
                          context.go('/user_page');
                        } else {
                          context.go('/auth');
                        }
                      },
                      child: const Text(
                        'Аккаунт',
                        style: TextStyle(
                          fontSize: 25,
                          color: Colors.white,
                          fontFamily: 'Nekst',
                        ),
                      ))
                ],
              )
            ],
          ),
        ),
        Expanded(
            child: Observer(
                builder: (_) => ListView.builder(
                    itemCount: userData.cartItems.length,
                    itemBuilder: (context, index) {
                      final item = userData.cartItems[index];
                      return Container(
                        padding: EdgeInsets.only(left: 300, right: 300),
                        width: 100,
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Image.asset(
                              item['path'].toString(),
                              fit: BoxFit.cover,
                              height: 450,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: [
                                Text(item['name'].toString(),
                                    style: TextStyle(fontSize: 20)),
                                Text('${item['price'].toString()} руб.'),
                                IconButton(
                                  icon: Icon(Icons.remove_rounded),
                                  onPressed: () async {
                                    final minus = await cart.minusItem(
                                        item['name'], item['count']);
                                    if (minus) {
                                      // ignore: use_build_context_synchronously
                                      ScaffoldMessenger.of(context)
                                          .showSnackBar(const SnackBar(
                                              content: Text(
                                                  'Количество товара уменьшено на 1')));
                                      userData.getCart();
                                    }
                                  },
                                ),
                                Container(
                                  margin: const EdgeInsets.only(
                                      right: 15, left: 15),
                                  child: Text(
                                    item['count'].toString(),
                                    style: const TextStyle(
                                      fontSize: 25,
                                      fontFamily: 'Nekst',
                                    ),
                                  ),
                                ),
                                IconButton(
                                  icon: Icon(Icons.add_rounded),
                                  onPressed: () async {
                                    await cart.plusItem(
                                        item['name'], item['count']);
                                    // ignore: use_build_context_synchronously
                                    ScaffoldMessenger.of(context).showSnackBar(
                                        const SnackBar(
                                            content: Text(
                                                'Количество товара увеличено на 1')));
                                    userData.getCart();
                                  },
                                ),
                                IconButton(
                                    onPressed: () async {
                                      await cart.deleteCartItem(
                                          item['name'].toString());
                                      // ignore: use_build_context_synchronously
                                      ScaffoldMessenger.of(context)
                                          .showSnackBar(const SnackBar(
                                              content: Text(
                                                  'Товар удален из корзины')));
                                      userData.getCart();
                                    },
                                    icon: Icon(Icons.cancel_rounded))
                              ],
                            )
                          ],
                        ),
                      );
                    }))),
        Container(
            color: const Color.fromARGB(255, 255, 255, 255),
            height: 70,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                TextButton(
                    onPressed: () {
                      if (userData.user == null) {
                        ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(content: Text('Войдите в аккаунт')));
                      } else if (userData.cartItems.isEmpty) {
                        ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(content: Text('Корзина пуста')));
                      } else {
                        showDialog(
                          context: context,
                          builder: (context) => OrderForm(
                            userData: userData,
                            orderFormStore: orderFormStore,
                          ),
                        );
                      }
                    },
                    child: const Text(
                      'Оформить заказ',
                      style: TextStyle(
                        fontFamily: 'Nekst',
                        fontSize: 30,
                        fontWeight: FontWeight.w700,
                        color: Color.fromARGB(255, 240, 49, 94),
                      ),
                    )),
                TextButton(
                    onPressed: () {},
                    child: const Text(
                      '',
                      style: TextStyle(
                        fontSize: 25,
                        fontWeight: FontWeight.w700,
                        color: const Color.fromARGB(255, 234, 121, 158),
                      ),
                    ))
              ],
            ))
      ],
    ));
  }
}
