import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:geburtstags_app/controllers/birthday.controller.dart';
import 'package:geburtstags_app/models/birthday.dart';

class BirthdayForm extends ConsumerWidget {
  const BirthdayForm({Key? key, this.birthday, this.isEdit = false})
      : super(key: key);

  final Birthday? birthday;
  final bool isEdit;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final formKey = GlobalKey<FormState>();
    final monthFocusNode = FocusNode();
    final yearFocusNode = FocusNode();
    var nameController = TextEditingController();
    var dateControllerDay = TextEditingController();
    var dateControllerMonth = TextEditingController();
    var dateControllerYear = TextEditingController();

    if (isEdit) {
      nameController = TextEditingController(text: birthday!.name);
      dateControllerDay =
          TextEditingController(text: birthday!.date.day.toString());
      dateControllerMonth =
          TextEditingController(text: birthday!.date.month.toString());
      dateControllerYear =
          TextEditingController(text: birthday!.date.year.toString());
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text('Geburtstag'),
        actions: [
          TextButton(
            onPressed: () {
              if (formKey.currentState!.validate()) {
                Birthday birthday = Birthday(
                  name: nameController.text,
                  date: DateTime(
                    int.parse(dateControllerYear.text),
                    int.parse(dateControllerMonth.text),
                    int.parse(dateControllerDay.text),
                  ),
                );

                if (isEdit) {
                  ref
                      .read(birthdayControllerProvider.notifier)
                      .updateBirthday(birthday, birthday);
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('Änderung gespeichert')),
                  );
                } else {
                  ref
                      .read(birthdayControllerProvider.notifier)
                      .addBirthday(birthday);
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                        content: Text('${nameController.text} hinzugefügt.')),
                  );
                }
                Navigator.pop(context, birthday);
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
        key: formKey,
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
                      maxLength: 2,
                      decoration: InputDecoration(
                        counterText: '',
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
                        } else if (int.parse(value) > 31) {
                          return 'ungültig';
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
                      maxLength: 2,
                      focusNode: monthFocusNode,
                      decoration: InputDecoration(
                        counterText: '',
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
                        } else if (int.parse(value) > 12) {
                          return 'ungültig';
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
                      maxLength: 4,
                      focusNode: yearFocusNode,
                      decoration: InputDecoration(
                        counterText: '',
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
                        } else if (int.parse(value) > DateTime.now().year) {
                          return 'ungültig';
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
