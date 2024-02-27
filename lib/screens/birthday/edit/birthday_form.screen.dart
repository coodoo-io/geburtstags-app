import 'package:flutter/material.dart';
import 'package:geburtstags_app/common/constants.dart';
import 'package:geburtstags_app/common/widgets/form_spacer_l.dart';
import 'package:geburtstags_app/models/birthday.model.dart';
import 'package:geburtstags_app/repositories/birthday.repository.dart';
import 'package:geburtstags_app/screens/birthday/edit/widgets/birthday_date_inputs.dart';
import 'package:geburtstags_app/screens/birthday/edit/widgets/birthday_name_input.dart';

class BirthdayForm extends StatefulWidget {
  final Birthday? birthday;
  final bool? edit;

  const BirthdayForm({super.key, this.birthday, this.edit = false});

  @override
  State<BirthdayForm> createState() => _BirthdayFormState();
}

class _BirthdayFormState extends State<BirthdayForm> {
  final formKey = GlobalKey<FormState>();
  final nameController = TextEditingController();
  final tagController = TextEditingController();
  final monatController = TextEditingController();
  final jahrController = TextEditingController();

  bool dataInputAvailable = false;

  @override
  Widget build(BuildContext context) {
    if (widget.edit!) {
      ///Vorausfüllen des Formulares mit bestehendem Geburtstag
      nameController.text = widget.birthday!.name;
      tagController.text = '${widget.birthday!.birthday.day}';
      monatController.text = '${widget.birthday!.birthday.month}';
      jahrController.text = '${widget.birthday!.birthday.year}';
    }

    return PopScope(
      canPop: dataInputAvailable == true,
      onPopInvoked: (didPop) async {
        // Es muss geprüft werden ob der pop bereits durchgeführt wurde, dann benötigt man
        // keinen weiteren Dialog und die Navigation würde in einer AssertException enden.
        if (didPop) {
          return;
        }
        final result = await _showNotSavedDialog(context);
        return result;
      },
      child: Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: const Text('Geburtstag hinzufügen'),
          actions: [
            TextButton(
              onPressed: () {
                _submitForm();
              },
              child: const Icon(Icons.save),
            ),
          ],
        ),
        body: Padding(
          padding: const EdgeInsets.all(kScreenPadding),
          child: Form(
            key: formKey,
            child: Column(
              children: [
                Row(
                  children: [
                    const FormSpacerL(),
                    BirthdayNameInput(nameController: nameController),
                  ],
                ),
                const FormSpacerL(),
                Row(
                  children: [
                    BirthdayDataDayInput(tagController: tagController),
                    const SizedBox(
                      width: 20,
                    ),
                    BirthdayDateMonthInput(monatController: monatController),
                    const SizedBox(
                      width: 20,
                    ),
                    BirthdayDateYearInput(jahrController: jahrController),
                  ],
                ),
                const FormSpacerL(),
                const FormSpacerL(),
                Row(
                  children: [
                    Expanded(
                      child: ElevatedButton(
                        onPressed: _submitForm,
                        child: const Text('Speichern'),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void _submitForm() {
    final isValid = formKey.currentState!.validate();
    if (isValid == false) {
      return;
    }
    final repo = BirthdayRepository();
    final newBirthday = Birthday(
      birthday: DateTime(
        int.parse(jahrController.text),
        int.parse(monatController.text),
        int.parse(tagController.text),
      ),
      name: nameController.text,
    );

    /// Prüfen ob ich editiere oder hinzufüge
    if (widget.edit!) {
      repo.update(widget.birthday!, newBirthday);
    } else {
      repo.insert(newBirthday);
    }
    Navigator.of(context).pop(newBirthday);
  }

  Future<void> _showNotSavedDialog(BuildContext context) {
    return showDialog<void>(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog.adaptive(
          title: const Text('Abbrechen'),
          content:
              const Text('Es sind noch ungespeicherte Eingaben vorhanden.'),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(true),
              child: const Text('Abbrechen'),
            ),
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(true);
                Navigator.of(context).pop(true);
              },
              child: const Text('OK'),
            ),
          ],
        );
      },
    );
  }
}
