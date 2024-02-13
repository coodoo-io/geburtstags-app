import 'package:flutter/material.dart';

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
