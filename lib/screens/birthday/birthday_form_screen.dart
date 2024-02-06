import 'package:flutter/material.dart';
import 'package:geburtstags_app/models/birthday.model.dart';
import 'package:geburtstags_app/repositories/birthday.repository.dart';

class BirthdayForm extends StatelessWidget {
  const BirthdayForm({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Geburtstag hinzufügen'),
        actions: [
          TextButton(
              onPressed: () {
                final repo = BirthdayRepository();
                repo.insert(FreezedBirthday(
                    birthday: DateTime(1900, 01, 01),
                    name: 'gespeicherter Geburtstag'));
                Navigator.of(context).pop();
              },
              child: Text('speichern'))
        ],
      ),
      body: Center(child: Text('neuer Geburtstag')),
    );
  }
}
