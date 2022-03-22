import 'package:flutter/material.dart';

class BirthdayFormField extends StatelessWidget {
  const BirthdayFormField({
    Key? key,
    required this.label,
    required this.controller,
    this.focusNode,
    this.invalidValue = 31,
    this.maxLength = 2,
    this.onChanged,
  }) : super(key: key);

  final String label;
  final TextEditingController controller;
  final FocusNode? focusNode;
  final int maxLength;
  final dynamic invalidValue;
  final Function(String)? onChanged;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: TextFormField(
        controller: controller,
        focusNode: focusNode,
        keyboardType: TextInputType.number,
        maxLength: maxLength,
        onChanged: onChanged,
        decoration: InputDecoration(counterText: '', labelText: label),
        validator: (value) {
          if (value == null || value.isEmpty) {
            return '$label fehlt';
          } else if (value.length > maxLength) {
            return 'Zu lang';
          } else if (int.parse(value) > invalidValue) {
            return 'ungültig';
          }
          return null;
        },
      ),
    );
  }
}
