import 'package:flutter/material.dart';
import 'package:flutter_application_2/auth/user_data.dart';
import 'package:go_router/go_router.dart';
import 'login_page.dart';
import 'reg_page.dart';

class AuthPage extends StatelessWidget {
  final UserData userData;

  const AuthPage({super.key, required this.userData});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            ElevatedButton(
              onPressed: () {
                context.go('/login');
              },
              child: Text('Войти'),
            ),
            ElevatedButton(
              onPressed: () {
                context.go('/regist');
              },
              child: Text('Зарегистрироваться'),
            ),
          ],
        ),
      ),
    );
  }
}
