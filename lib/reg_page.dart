import 'package:flutter/material.dart';
import 'package:flutter_application_2/alert_reg.dart';
import 'package:flutter_application_2/auth/user_data.dart';
import 'package:go_router/go_router.dart';

import 'home_page.dart';

class RegPage extends StatelessWidget {
  const RegPage({super.key, required this.userData});

  final UserData userData;

  @override
  Widget build(BuildContext context) {
    final TextEditingController emailController = TextEditingController();
    final TextEditingController passwordController = TextEditingController();

    return Scaffold(
      appBar: AppBar(
        title: Text('Регистрация'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: <Widget>[
            TextField(
              controller: emailController,
              decoration: InputDecoration(labelText: 'Email'),
            ),
            TextField(
              controller: passwordController,
              decoration: InputDecoration(labelText: 'Пароль'),
              obscureText: true,
            ),
            ElevatedButton(
              onPressed: () async {
                if (passwordController.text.length < 6) {
                  showDialog(
                      context: context,
                      builder: (context) => const AlertReg(
                            alertText:
                                'Пароль должен быть больше шести символов!',
                          ));
                } else if (emailController.text.isEmpty ||
                    passwordController.text.isEmpty) {
                  showDialog(
                      context: context,
                      builder: (context) => const AlertReg(
                            alertText: 'Заполни все поля!',
                          ));
                } else {
                  try {
                    await userData.signUp(
                        emailController.text, passwordController.text);
                    context.go('/');
                    if (userData.user == null) {
                      // ignore: use_build_context_synchronously
                      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                          content: Text('Пользователь существует')));
                    } else {
                      // ignore: use_build_context_synchronously
                      context.go('/');
                    }
                  } catch (error) {
                    // Show error message to user
                    // ignore: use_build_context_synchronously
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text('Пользователь существует'),
                        backgroundColor: Colors.red,
                      ),
                    );
                  }
                }
              },
              child: Text('Зарегистрироваться'),
            ),
          ],
        ),
      ),
    );
  }
}
