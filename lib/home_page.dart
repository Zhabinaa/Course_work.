import 'package:flutter/material.dart';
import 'package:flutter_application_2/auth/user_data.dart';
import 'package:flutter_application_2/cart/cart.dart';
import 'package:flutter_application_2/izb.dart';
import 'package:flutter_application_2/korzina.dart';
import 'package:flutter_application_2/whaitlist/whaitlist.dart';
import 'package:go_router/go_router.dart';

class HomePage extends StatelessWidget {
  final UserData userData;
  final Cart cart;
  final Whaitlist whaitlist;

  const HomePage(
      {super.key,
      required this.userData,
      required this.cart,
      required this.whaitlist});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Интернет-магазин тортов'),
        actions: [
          IconButton(
            icon: Icon(Icons.shopping_cart),
            onPressed: () {
              userData.getCart();
              context.go('/cart');
            },
          ),
          IconButton(
            icon: Icon(Icons.favorite),
            onPressed: () {
              context.go('/whaitlist');
            },
          ),
          IconButton(
              icon: Icon(Icons.man_2_rounded),
              onPressed: () {
                if (userData.user != null) {
                  context.go('/user_page');
                } else {
                  context.go('/auth');
                }
              })
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            // Баннер
            Container(
              height: 200,
              color: const Color.fromARGB(255, 234, 121, 158),
              child: Center(
                child: Text(
                  'Добро пожаловать в  магазин тортов!',
                  style: TextStyle(fontSize: 24, color: Colors.white),
                ),
              ),
            ),
            // Список товаров
            GridView.builder(
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 3, mainAxisSpacing: 7),
              itemCount: products.length,
              itemBuilder: (context, index) {
                return Container(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Image.asset(
                        products[index].imageUrl,
                        fit: BoxFit.cover,
                        height: 450,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          Text(products[index].name,
                              style: TextStyle(fontSize: 20)),
                          Text('${products[index].price} руб.'),
                          IconButton(
                            icon: Icon(Icons.shopping_cart),
                            onPressed: () async {
                              if (userData.user != null) {
                                final isInCart = await cart.addToCart(
                                  userData.user?.id,
                                  products[index].imageUrl,
                                  products[index].name,
                                  products[index].price.toString(),
                                );
                                if (isInCart) {
                                  // ignore: use_build_context_synchronously
                                  ScaffoldMessenger.of(context).showSnackBar(
                                      const SnackBar(
                                          content: Text(
                                              'Товар добавлен в корзину')));
                                } else {
                                  // ignore: use_build_context_synchronously
                                  ScaffoldMessenger.of(context).showSnackBar(
                                      const SnackBar(
                                          content: Text(
                                              'Товар уже есть в корзине')));
                                }
                                userData.getCart();
                              } else {
                                // ignore: use_build_context_synchronously
                                ScaffoldMessenger.of(context).showSnackBar(
                                    const SnackBar(
                                        content: Text('Войдите в аккаунт')));
                              }
                            },
                          ),
                          IconButton(
                            icon: Icon(Icons.favorite),
                            onPressed: () async {
                              if (userData.user != null) {
                                final isInWhaitlist =
                                    await whaitlist.addToWhaitlist(
                                  userData.user?.id,
                                  products[index].imageUrl,
                                  products[index].name,
                                  products[index].price.toString(),
                                );
                                if (isInWhaitlist) {
                                  // ignore: use_build_context_synchronously
                                  ScaffoldMessenger.of(context).showSnackBar(
                                      const SnackBar(
                                          content: Text(
                                              'Товар добавлен в желаемое')));
                                } else {
                                  // ignore: use_build_context_synchronously
                                  ScaffoldMessenger.of(context).showSnackBar(
                                      const SnackBar(
                                          content: Text(
                                              'Товар уже есть в желаемом')));
                                }
                                userData.getWhaitlist();
                              } else {
                                // ignore: use_build_context_synchronously
                                ScaffoldMessenger.of(context).showSnackBar(
                                    const SnackBar(
                                        content: Text('Войдите в аккаунт')));
                              }
                            },
                          ),
                        ],
                      )
                    ],
                  ),
                );
              },
              shrinkWrap: true,
              physics: NeverScrollableScrollPhysics(),
            ),
          ],
        ),
      ),
    );
  }
}

class Product {
  final String name;
  final String imageUrl;
  final double price;

  int quantity = 0;

  Product({
    required this.name,
    required this.imageUrl,
    required this.price,
  });
}

List<Product> products = [
  Product(
    name: 'Торт наполеон',
    imageUrl: 'napoleon.png',
    price: 2500.0,
  ),
  Product(
    name: 'Шоколадный торт',
    imageUrl: 'shok.png',
    price: 3000.0,
  ),
  Product(
    name: 'Ягодный торт',
    imageUrl: 'yagoda.png',
    price: 3500.0,
  ),
  Product(
    name: 'Медовик',
    imageUrl: 'med.png',
    price: 2000.0,
  ),
  Product(
    name: 'Муссовый торт с клубникой',
    imageUrl: 'muss.png',
    price: 1500.0,
  ),
  Product(
    name: 'Чизкейк классический',
    imageUrl: 'chiz.png',
    price: 2200.0,
  ),
];
