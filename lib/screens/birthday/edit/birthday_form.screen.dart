import 'package:flutter/material.dart';
import 'package:geburtstags_app/common/constants.dart';
import 'package:geburtstags_app/common/widgets/form_spacer_l.dart';
import 'package:geburtstags_app/models/birthday.model.dart';
import 'package:geburtstags_app/repositories/birthday.repository.dart';
import 'package:geburtstags_app/screens/birthday/edit/widgets/birthday_form.screen.dart';

class BirthdayForm extends StatefulWidget {
  final Birthday? birthday;

  const BirthdayForm({super.key, this.birthday});

  @override
  State<BirthdayForm> createState() => _BirthdayFormState();
}

class _BirthdayFormState extends State<BirthdayForm> {
  final formKey = GlobalKey<FormState>();
  late TextEditingController nameController;
  final tagController = TextEditingController();
  final monatController = TextEditingController();
  final jahrController = TextEditingController();

  bool dataInputAvailable = false;

  @override
  Widget build(BuildContext context) {
    nameController = TextEditingController(text: widget.birthday != null ? widget.birthday!.name : '');

    return PopScope(
      canPop: dataInputAvailable == false,
      onPopInvoked: (didPop) {
        // Es muss geprüft werden ob der pop bereits durchgeführt wurde, dann benötigt man
        // keinen weiteren Dialog und die Navigation würde in einer AssertException enden.
        if (didPop) {
          return;
        }
        _showNotSavedDialog(context);
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
    repo.insert(
      Birthday(
        birthday: DateTime(
          int.parse(jahrController.text),
          int.parse(monatController.text),
          int.parse(tagController.text),
        ),
        name: nameController.text,
      ),
    );
    Navigator.of(context).pop();
  }

  Future<void> _showNotSavedDialog(BuildContext context) {
    return showDialog<void>(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog.adaptive(
          title: const Text('Abbrechen'),
          content: const Text('Es sind noch ungespeicherte Eingaben vorhanden.'),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(false),
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
