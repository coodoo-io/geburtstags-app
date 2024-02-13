import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:geburtstags_app/common/constants.dart';
import 'package:geburtstags_app/models/birthday.model.dart';
import 'package:geburtstags_app/repositories/birthday.repository.dart';
import 'package:geburtstags_app/common/widgets/form_spacer_l.dart';

class BirthdayForm extends StatefulWidget {
  const BirthdayForm({super.key});

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
    return PopScope(
      canPop: dataInputAvailable == false,
      onPopInvoked: (didPop) {
        if (kDebugMode) {
          print('onPopInvoked');
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

class BirthdayDateYearInput extends StatelessWidget {
  const BirthdayDateYearInput({
    super.key,
    required this.jahrController,
  });

  final TextEditingController jahrController;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: TextFormField(
        controller: jahrController,
        keyboardType: TextInputType.number,
        decoration: const InputDecoration(
          labelText: 'Jahr',
        ),
        validator: (value) {
          if (value == null || value.isEmpty) {
            return 'Pflichtfeld';
          }
          if (value.length > 4) {
            return 'Ungültig';
          }
          return null;
        },
      ),
    );
  }
}

class BirthdayDateMonthInput extends StatelessWidget {
  const BirthdayDateMonthInput({
    super.key,
    required this.monatController,
  });

  final TextEditingController monatController;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: TextFormField(
        controller: monatController,
        keyboardType: TextInputType.number,
        decoration: const InputDecoration(
          labelText: 'Monat',
        ),
        validator: (value) {
          if (value == null || value.isEmpty) {
            return 'Pflichtfeld';
          }
          if (value.length > 2) {
            return 'Ungültig';
          }
          return null;
        },
      ),
    );
  }
}

class BirthdayDataDayInput extends StatelessWidget {
  const BirthdayDataDayInput({
    super.key,
    required this.tagController,
  });

  final TextEditingController tagController;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: TextFormField(
        controller: tagController,
        keyboardType: TextInputType.number,
        decoration: const InputDecoration(
          labelText: 'Tag',
        ),
        validator: (value) {
          if (value == null || value.isEmpty) {
            return 'Pflichtfeld';
          }
          if (value.length > 2) {
            return 'Ungültig';
          }
          return null;
        },
      ),
    );
  }
}

class BirthdayNameInput extends StatelessWidget {
  const BirthdayNameInput({
    super.key,
    required this.nameController,
  });

  final TextEditingController nameController;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: TextFormField(
        controller: nameController,
        keyboardType: TextInputType.name,
        maxLength: 20,
        // onChanged: (value) => setState(() {
        //   dataInputAvailable = value.isNotEmpty;
        // }),
        decoration: InputDecoration(
          suffixIcon: IconButton(
            onPressed: () {
              nameController.text = '';
            },
            icon: const Icon(Icons.close),
          ),
          labelText: 'Name',
          counterText: 'tmp',
          border: const OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(30)),
          ),
        ),
        validator: (value) {
          if (value == null || value.isEmpty) {
            return 'Bitte Text eingeben';
          }
          return null;
        },
      ),
    );
  }
}
