import 'package:flutter/material.dart';
import 'package:geburtstags_app/models/birthday.dart';
import 'package:geburtstags_app/repositories/birthday.repo.dart';

class BirthdayForm extends StatefulWidget {
  const BirthdayForm({super.key});

  @override
  State<BirthdayForm> createState() => _BirthdayFormState();
}

class _BirthdayFormState extends State<BirthdayForm> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Geburtstag'),
        actions: [
          TextButton(
            child: const Text(
              'Speichern',
              style: TextStyle(color: Colors.black),
            ),
            onPressed: () {
              BirthdayRepo().insert(
                Birthday(
                  name: "Max Mustermann",
                  date: DateTime(1996, 06, 09),
                ),
              );
              Navigator.pop(context);
            },
          ),
        ],
      ),
      body: const Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text("Max Mustermann"),
            Text("09.06.1996"),
          ],
        ),
      ),
    );
  }
}
