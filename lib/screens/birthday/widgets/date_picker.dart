import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class DatePicker extends StatefulWidget {
  const DatePicker({
    required this.controller,
    super.key,
  });

  final TextEditingController controller;

  @override
  State<DatePicker> createState() => _DatePickerState();
}

class _DatePickerState extends State<DatePicker> {
  DateTime selectedDate = DateTime.now();

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: widget.controller,
      decoration: const InputDecoration(label: Text("Datum")),
      onTap: () => _selectDate(context),
      readOnly: true,
    );
  }

  Future<void> _selectDate(BuildContext context) async {
    /// Special Case for web
    if (kIsWeb) {
      return _selectDateAndroid(context);
    }
    if (Platform.isIOS) {
      return _selectDateIos(context);
    }
    return _selectDateAndroid(context);
  }

  Future<void> _selectDateIos(BuildContext context) async {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: const Text(
              'Datum wählen',
              style: TextStyle(color: Colors.blue),
            ),
            actions: [
              TextButton(
                onPressed: () => Navigator.pop(context),
                child: const Text('CANCEL'),
              ),
              TextButton(
                onPressed: () => Navigator.pop(context),
                child: const Text('OK'),
              ),
            ],
            content: SizedBox(
              height: MediaQuery.of(context).size.width - 30,
              width: MediaQuery.of(context).size.width - 10,
              child: CupertinoDatePicker(
                mode: CupertinoDatePickerMode.date,
                minimumYear: 1900,
                maximumYear: 2100,
                initialDateTime: selectedDate,
                onDateTimeChanged: (picked) {
                  if (picked != selectedDate) {
                    setState(() => selectedDate = picked);
                    widget.controller.text =
                        DateFormat('dd.MM.yyyy').format(picked);
                  }
                },
              ),
            ),
          );
        });
  }

  Future<void> _selectDateAndroid(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: selectedDate,
      firstDate: DateTime(1900),
      lastDate: DateTime(2100),
    );
    if (picked != null && picked != selectedDate) {
      setState(() => selectedDate = picked);
      widget.controller.text = DateFormat('dd.MM.yyyy').format(picked);
    }
  }
}
