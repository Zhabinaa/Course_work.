import 'package:flutter/material.dart';
import 'package:flutter_application_2/addition/alert_clear_cart.dart';
import 'package:flutter_application_2/auth/user_data.dart';
import 'package:flutter_application_2/whaitlist/whaitlist.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:go_router/go_router.dart';

class FavoritesScreen extends StatelessWidget {
  final UserData userData;
  final Whaitlist whaitlist;

  const FavoritesScreen(
      {super.key, required this.userData, required this.whaitlist});
  @override
  Widget build(BuildContext context) {
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
                  'Желаемое',
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
                  IconButton(
                      onPressed: () {
                        showDialog(
                            context: context,
                            builder: (context) => AlertClearCart(
                                  alertText:
                                      'Ты уверен, что хочешь очистить желаемое?',
                                  onClick: () async {
                                    await whaitlist.clearWhaitlist(
                                        userData.user!.id.toString());
                                    // ignore: use_build_context_synchronously
                                    Navigator.pop(context);
                                    // ignore: use_build_context_synchronously
                                    ScaffoldMessenger.of(context).showSnackBar(
                                        const SnackBar(
                                            content: Text('Корзина очищена')));
                                    userData.getWhaitlist();
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
                    itemCount: userData.whaitlistItems.length,
                    itemBuilder: (context, index) {
                      final item = userData.whaitlistItems[index];
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
                                    onPressed: () async {
                                      await whaitlist.deleteWhaitlistItem(
                                          item['name'].toString());
                                      // ignore: use_build_context_synchronously
                                      ScaffoldMessenger.of(context)
                                          .showSnackBar(const SnackBar(
                                              content: Text(
                                                  'Товар удален из желаемого')));
                                      userData.getWhaitlist();
                                    },
                                    icon: Icon(Icons.cancel_rounded))
                              ],
                            )
                          ],
                        ),
                      );
                    }))),
      ],
    ));
  }
}
