import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:geburtstags_app/domain/birthday/model/birthday.dart';
import 'package:geburtstags_app/domain/birthday/service/birthday.service.dart';
import 'package:uuid/uuid.dart';

class BirthdayForm extends ConsumerStatefulWidget {
  const BirthdayForm({super.key, this.birthday, this.isEdit = false});

  final Birthday? birthday;
  final bool isEdit;

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _BirthdayFormState();
}

class _BirthdayFormState extends ConsumerState<BirthdayForm> {
  @override
  Widget build(BuildContext context) {
    final formKey = GlobalKey<FormState>();
    final monthFocusNode = FocusNode();
    final yearFocusNode = FocusNode();
    var nameController = TextEditingController();
    var dateControllerDay = TextEditingController();
    var dateControllerMonth = TextEditingController();
    var dateControllerYear = TextEditingController();

    if (widget.isEdit) {
      nameController = TextEditingController(text: widget.birthday!.name);
      dateControllerDay = TextEditingController(text: widget.birthday!.date.day.toString());
      dateControllerMonth = TextEditingController(text: widget.birthday!.date.month.toString());
      dateControllerYear = TextEditingController(text: widget.birthday!.date.year.toString());
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text('Geburtstag'),
        actions: [
          TextButton(
            onPressed: () async {
              if (formKey.currentState!.validate()) {
                var id = widget.isEdit ? widget.birthday!.id : const Uuid().v1();
                Birthday newBirthday = Birthday(
                  id: id,
                  name: nameController.text,
                  date: DateTime(
                    int.parse(dateControllerYear.text),
                    int.parse(dateControllerMonth.text),
                    int.parse(dateControllerDay.text),
                  ),
                );

                if (widget.isEdit) {
                  await ref.read(updateBirthdayServiceProvider(
                    birthday: newBirthday,
                  ).future);
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('Änderung gespeichert')),
                  );
                } else {
                  await ref.read(addBirthdayServiceProvider(birthday: newBirthday).future);
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text('${nameController.text} hinzugefügt.')),
                  );
                }
                Navigator.pop(context, newBirthday);
              }
            },
            child: const Text(
              'Speichern',
              style: TextStyle(color: Colors.black),
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
                      onChanged: (value) {
                        if (dateControllerDay.text.length == 2) {
                          FocusScope.of(context).requestFocus(monthFocusNode);
                        }
                      },
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
                      onChanged: (value) {
                        if (dateControllerMonth.text.length == 2) {
                          FocusScope.of(context).requestFocus(yearFocusNode);
                        }
                      },
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
