import 'package:flutter/material.dart';
import 'package:geburtstags_app/models/birthday.dart';
import 'package:geburtstags_app/repositories/birthday.repo.dart';

class BirthdayForm extends StatefulWidget {
  const BirthdayForm({Key? key}) : super(key: key);

  @override
  State<BirthdayForm> createState() => _BirthdayFormState();
}

class _BirthdayFormState extends State<BirthdayForm> {
  final _formKey = GlobalKey<FormState>();
  final nameController = TextEditingController();
  final dateControllerDay = TextEditingController();
  final dateControllerMonth = TextEditingController();
  final dateControllerYear = TextEditingController();
  final monthFocusNode = FocusNode();
  final yearFocusNode = FocusNode();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Geburtstag'),
        actions: [
          TextButton(
            onPressed: () {
              if (_formKey.currentState!.validate()) {
                BirthdayRepo().insert(
                  Birthday(
                    name: nameController.text,
                    date: DateTime(
                      int.parse(dateControllerYear.text),
                      int.parse(dateControllerMonth.text),
                      int.parse(dateControllerDay.text),
                    ),
                  ),
                );
                Navigator.pop(context);
              }
            },
            child: const Text(
              'Speichern',
              style: TextStyle(color: Colors.white),
            ),
          ),
        ],
      ),
      body: Form(
        key: _formKey,
        child: Padding(
          padding: const EdgeInsets.all(30.0),
          child: Column(
            children: [
              Row(
                children: [
                  Expanded(
                    child: TextFormField(
                      controller: nameController,
                      keyboardType: TextInputType.text,
                      decoration: const InputDecoration(labelText: 'Name'),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Bitte Name eintragen';
                        }
                        return null;
                      },
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 30),
              Row(
                children: [
                  Expanded(
                    child: TextFormField(
                      controller: dateControllerDay,
                      keyboardType: TextInputType.number,
                      onChanged: (value) {
                        if (dateControllerDay.text.length == 2) {
                          FocusScope.of(context).requestFocus(monthFocusNode);
                        }
                      },
                      decoration: InputDecoration(
                        labelText: 'Tag',
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(15),
                        ),
                      ),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Bitte Tag eintragen';
                        } else if (value.length > 2) {
                          return 'Zu lang';
                        }
                        return null;
                      },
                    ),
                  ),
                  const SizedBox(width: 10),
                  Expanded(
                    child: TextFormField(
                      controller: dateControllerMonth,
                      keyboardType: TextInputType.number,
                      focusNode: monthFocusNode,
                      onChanged: (value) {
                        if (dateControllerMonth.text.length == 2) {
                          FocusScope.of(context).requestFocus(yearFocusNode);
                        }
                      },
                      decoration: InputDecoration(
                        labelText: 'Monat',
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(15),
                        ),
                      ),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Bitte Monat eintragen';
                        } else if (value.length > 2) {
                          return 'Zu lang';
                        }
                        return null;
                      },
                    ),
                  ),
                  const SizedBox(width: 10),
                  Expanded(
                    child: TextFormField(
                      controller: dateControllerYear,
                      keyboardType: TextInputType.number,
                      focusNode: yearFocusNode,
                      decoration: InputDecoration(
                        labelText: 'Jahr',
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(15),
                        ),
                      ),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Bitte Jahr eintragen';
                        } else if (value.length > 4) {
                          return 'Zu lang';
                        }
                        return null;
                      },
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
