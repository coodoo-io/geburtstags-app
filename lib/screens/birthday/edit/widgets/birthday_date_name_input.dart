import 'package:flutter/material.dart';

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
