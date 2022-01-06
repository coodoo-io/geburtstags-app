import 'package:flutter/material.dart';
import 'package:geburtstags_app/models/birthday.dart';
import 'package:geburtstags_app/repositories/birthday.repo.dart';
import 'package:intl/intl.dart';

class BirthdayForm extends StatefulWidget {
  const BirthdayForm({Key? key}) : super(key: key);

  @override
  State<BirthdayForm> createState() => _BirthdayFormState();
}

class _BirthdayFormState extends State<BirthdayForm> {
  TextEditingController nameController = TextEditingController();
  TextEditingController dateController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Geburtstag hinzufügen')),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(30.0),
          child: Column(
            children: [
              TextField(
                controller: nameController,
                autofocus: true,
                decoration: const InputDecoration(label: Text("Name")),
              ),
              const SizedBox(height: 10),
              TextField(
                controller: dateController,
                autofocus: true,
                decoration: const InputDecoration(label: Text("Datum"), hintText: "Tag.Monat.Jahr"),
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {
                  BirthdayRepo().insert(
                    Birthday(
                      name: nameController.text,
                      date: DateFormat("dd.MM.yyyy").parse(dateController.text),
                    ),
                  );
                  Navigator.pop(context);
                },
                child: const Text("Hinzufügen"),
              )
            ],
          ),
        ),
      ),
    );
  }
}
