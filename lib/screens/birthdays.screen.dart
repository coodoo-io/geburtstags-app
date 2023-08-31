import 'package:flutter/material.dart';

class BirthdaysScreen extends StatelessWidget {
  const BirthdaysScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Geburtstage',
        ),
      ),
      body: const Center(
        child: Text(
          '...',
        ),
      ),
    );
  }
}
