import 'package:flutter/material.dart';
import 'package:geburtstags_app/models/birthday.dart';
import 'package:geburtstags_app/repositories/birthday.repo.dart';
import 'package:geburtstags_app/screens/birthday/widgets/date_picker.dart';
import 'package:geburtstags_app/screens/birthday/widgets/name_field.dart';
import 'package:intl/intl.dart';

class BirthdayForm extends StatefulWidget {
  const BirthdayForm({super.key});

  @override
  State<BirthdayForm> createState() => _BirthdayFormState();
}

class _BirthdayFormState extends State<BirthdayForm> {
  TextEditingController dateController = TextEditingController();
  TextEditingController nameController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Geburtstag'),
        actions: [
          TextButton(
            onPressed: () {
              BirthdayRepo().insert(
                Birthday(
                  name: nameController.text,
                  date: DateFormat("dd.MM.yyyy").parse(dateController.text),
                ),
              );
              Navigator.pop(context);
            },
            child: const Text(
              'Speichern',
              style: TextStyle(color: Colors.white),
            ),
          ),
        ],
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(30.0),
          child: Column(
            children: [
              NameField(controller: nameController),
              const SizedBox(height: 10),
              DatePicker(controller: dateController),
            ],
          ),
        ),
      ),
    );
  }
}
