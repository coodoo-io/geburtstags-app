import 'package:flutter/material.dart';
// ignore: unused_import
import 'package:geburtstags_app/app.dart';
import 'package:geburtstags_app/models/birthday.model.dart';
import 'package:intl/intl.dart';

class BirthdayDetail extends StatelessWidget {
  final DateFormat formater = DateFormat('dd.MM.yyyy');

  static String routeName = (BirthdayDetail).toString();

  BirthdayDetail({super.key});

  @override
  Widget build(BuildContext context) {
    final birthday = ModalRoute.of(context)!.settings.arguments as Birthday;

    return Scaffold(
      appBar: AppBar(
        title: Text(birthday.name),
      ),
      body: Padding(
        padding: const EdgeInsets.only(left: 8.0, top: 16),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Text(birthday.name),
            const SizedBox(
              height: 16,
            ),
            Text(formater.format(birthday.birthday)),
            const SizedBox(
              height: 16,
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text('zurück'),
            ),
          ],
        ),
      ),
    );
  }
}
