import 'package:flutter/material.dart';
import 'package:flutter_application_2/auth/user_data.dart';
import 'package:go_router/go_router.dart';

class LoginPage extends StatelessWidget {
  final UserData userData;

  const LoginPage({super.key, required this.userData});

  @override
  Widget build(BuildContext context) {
    final TextEditingController emailController = TextEditingController();
    final TextEditingController passwordController = TextEditingController();
    return Scaffold(
      appBar: AppBar(
        title: Text('Вход'),
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
                try {
                  await userData.signIn(
                      emailController.text, passwordController.text);
                  if (userData.user == null) {
                    // ignore: use_build_context_synchronously
                    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                        content: Text('Неверный логин или пароль')));
                  } else {
                    // ignore: use_build_context_synchronously
                    context.go('/');
                  }
                } catch (error) {
                  // Show error message to user
                  // ignore: use_build_context_synchronously
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content:
                          Text('Ошибка входа не правильный логин или пароль'),
                      backgroundColor: Colors.red,
                    ),
                  );
                }
              },
              child: Text('Войти'),
            ),
          ],
        ),
      ),
    );
  }
}
