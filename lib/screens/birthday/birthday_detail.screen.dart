import 'package:flutter/material.dart';
import 'package:geburtstags_app/app.dart';
import 'package:geburtstags_app/models/birthday.model.dart';
import 'package:intl/intl.dart';

class BirthdayDetail extends StatelessWidget {
  final FreezedBirthday birthday;
  final DateFormat formater = DateFormat('dd.MM.yyyy');

  BirthdayDetail({required this.birthday});

  @override
  Widget build(BuildContext context) {
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
                child: const Text('zurück'))
          ],
        ),
      ),
    );
  }
}
