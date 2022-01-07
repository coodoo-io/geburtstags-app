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
  DateTime selectedDate = DateTime.now();
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
              TextField(
                controller: nameController,
                decoration: const InputDecoration(label: Text("Name")),
                autofocus: true,
              ),
              const SizedBox(height: 10),
              TextField(
                controller: dateController,
                decoration: const InputDecoration(label: Text("Datum")),
                onTap: () => _selectDate(context),
                readOnly: true,
              ),
              const SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: selectedDate,
      firstDate: DateTime(1900),
      lastDate: DateTime(2100),
    );
    if (picked != null && picked != selectedDate) {
      setState(() => selectedDate = picked);
      dateController.text = DateFormat('dd.MM.yyyy').format(picked);
    }
  }
}
