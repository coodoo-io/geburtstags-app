import 'package:flutter/material.dart';
import 'package:geburtstags_app/models/birthday.dart';
import 'package:geburtstags_app/repositories/birthday.repo.dart';
import 'package:geburtstags_app/screens/birthday/widgets/birthday_form_field.dart';
import 'package:geburtstags_app/utils/snack_bar.util.dart';
import 'package:ms_undraw/ms_undraw.dart';

class BirthdayForm extends StatelessWidget {
  const BirthdayForm({super.key, this.birthday, this.isEdit = false});
  final Birthday? birthday;
  final bool isEdit;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final formKey = GlobalKey<FormState>();
    final monthFocusNode = FocusNode();
    final yearFocusNode = FocusNode();
    var nameController = TextEditingController();
    var dateControllerDay = TextEditingController();
    var dateControllerMonth = TextEditingController();
    var dateControllerYear = TextEditingController();

    if (isEdit) {
      nameController = TextEditingController(text: birthday!.name);
      dateControllerDay = TextEditingController(text: birthday!.date.day.toString());
      dateControllerMonth = TextEditingController(text: birthday!.date.month.toString());
      dateControllerYear = TextEditingController(text: birthday!.date.year.toString());
    }
    return Scaffold(
      appBar: AppBar(title: const Text('Geburtstag')),
      body: Form(
        key: formKey,
        child: Padding(
          padding: const EdgeInsets.all(30.0),
          child: Column(
            children: [
              UnDraw(
                color: theme.primaryColor,
                illustration: UnDrawIllustration.happy_feeling,
                height: 200.0,
                placeholder: const CircularProgressIndicator(),
                errorWidget: Container(),
              ),
              const SizedBox(height: 30),
              Row(
                children: [
                  Expanded(
                    child: TextFormField(
                      controller: nameController,
                      keyboardType: TextInputType.text,
                      decoration: const InputDecoration(labelText: 'Name'),
                      validator: (value) => (value == null || value.isEmpty) ? 'Bitte Name eintragen' : null,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 30),
              Row(
                children: [
                  BirthdayFormField(
                    label: 'Tag',
                    controller: dateControllerDay,
                    invalidValue: 31,
                    maxLength: 2,
                    onChanged: (value) {
                      if (dateControllerDay.text.length == 2) {
                        FocusScope.of(context).requestFocus(monthFocusNode);
                      }
                    },
                  ),
                  const SizedBox(width: 10),
                  BirthdayFormField(
                    label: 'Monat',
                    controller: dateControllerMonth,
                    focusNode: monthFocusNode,
                    invalidValue: 12,
                    maxLength: 2,
                    onChanged: (value) {
                      if (dateControllerMonth.text.length == 2) {
                        FocusScope.of(context).requestFocus(yearFocusNode);
                      }
                    },
                  ),
                  const SizedBox(width: 10),
                  BirthdayFormField(
                    label: 'Jahr',
                    controller: dateControllerYear,
                    focusNode: yearFocusNode,
                    invalidValue: DateTime.now().year,
                    maxLength: 4,
                  ),
                ],
              ),
              const SizedBox(height: 40),
              SizedBox(
                width: double.infinity,
                height: 50,
                child: ElevatedButton.icon(
                  icon: Icon(isEdit ? Icons.save_outlined : Icons.add_outlined),
                  label: Text(isEdit ? 'Speichern' : 'Hizufügen'),
                  onPressed: () {
                    if (formKey.currentState!.validate()) {
                      Birthday newBirthday = Birthday(
                        name: nameController.text,
                        date: DateTime(
                          int.parse(dateControllerYear.text),
                          int.parse(dateControllerMonth.text),
                          int.parse(dateControllerDay.text),
                        ),
                      );
                      if (isEdit) {
                        BirthdayRepo().update(birthday!, newBirthday);
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBarUtil.info(content: 'Änderung gespeichert'),
                        );
                      } else {
                        BirthdayRepo().insert(newBirthday);
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBarUtil.info(
                            content: '${nameController.text} hinzugefügt.',
                          ),
                        );
                      }
                      Navigator.pop(context, newBirthday);
                    }
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
