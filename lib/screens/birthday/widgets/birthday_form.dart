import 'package:flutter/material.dart';
import 'package:geburtstags_app/models/birthday.dart';
import 'package:geburtstags_app/repositories/birthday.repo.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';

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
  XFile? image;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Geburtstag'),
        actions: [
          TextButton(
            onPressed: () {
              if (_formKey.currentState!.validate()) {
                context.read<BirthdayRepo>().insert(
                      Birthday(
                        name: nameController.text,
                        date: DateTime(
                          int.parse(dateControllerYear.text),
                          int.parse(dateControllerMonth.text),
                          int.parse(dateControllerDay.text),
                        ),
                        profileImage: image?.path,
                      ),
                    );
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                      content: Text('${nameController.text} hinzugefügt.')),
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
              const SizedBox(height: 30),
              ElevatedButton(
                onPressed: () async {
                  final ImagePicker _picker = ImagePicker();
                  image = await _picker.pickImage(source: ImageSource.gallery);
                },
                child: const Text("Bild auswählen"),
              ),
              ElevatedButton(
                onPressed: () async {
                  final ImagePicker _picker = ImagePicker();
                  try {
                    image = await _picker.pickImage(source: ImageSource.camera);
                  } catch (e) {
                    // camera permission denied
                    debugPrint("Error: $e");
                  }
                },
                child: const Text("Bild erstellen"),
              )
            ],
          ),
        ),
      ),
    );
  }
}
