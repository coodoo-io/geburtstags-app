import 'package:flutter/material.dart';

class NameField extends StatefulWidget {
  const NameField({
    required this.controller,
    Key? key,
  }) : super(key: key);

  final TextEditingController controller;

  @override
  State<NameField> createState() => _NameFieldState();
}

class _NameFieldState extends State<NameField> {
  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: widget.controller,
      decoration: const InputDecoration(label: Text("Name")),
      autofocus: true,
    );
  }
}
