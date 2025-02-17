// ignore_for_file: file_names

import 'package:flutter/material.dart';
import 'package:flutter_application_2/alert_reg.dart';
import 'package:flutter_application_2/auth/user_data.dart';

class AlertAdressAddition extends StatelessWidget {
  const AlertAdressAddition({super.key, required this.userData});
  final UserData userData;

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      backgroundColor: const Color.fromARGB(255, 234, 121, 158),
      content: const Text(
        'Добавте адресс (без запятых)',
        style: TextStyle(fontSize: 30, color: Colors.white),
      ),
      actions: [
        TextField(
          controller: userData.adress,
          maxLength: 30,
          style: const TextStyle(color: Colors.white),
          decoration: const InputDecoration(
            hintText: 'Адресс доставки (город дом квартира)',
            hintStyle: TextStyle(fontFamily: 'Nekst', color: Colors.white),
          ),
        ),
        TextButton(
            onPressed: () {
              if (userData.adress.text.isEmpty || userData.adress.text == ' ') {
                Navigator.pop(context);
                showDialog(
                    context: context,
                    builder: (context) => const AlertReg(
                          alertText: 'Адресс недобавлен!',
                        ));
              } else {
                userData.addAdress(userData.adress.text);
                userData.adress.clear();
                Navigator.pop(context);
                showDialog(
                    context: context,
                    builder: (context) => const AlertReg(
                          alertText: 'Адресс успешно добавлен!',
                        ));
              }
            },
            child: const Text(
              'Добавить',
              style: TextStyle(fontSize: 20, color: Colors.white),
            ))
      ],
    );
  }
}
