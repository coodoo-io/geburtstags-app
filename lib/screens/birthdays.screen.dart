import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

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
      body: ListView(
        children: [
          ListTile(
            title: const Text(
              'Julia',
            ),
            trailing: Text(
              DateFormat('dd.MM.yyyy').format(
                DateTime(1993, 4, 16),
              ),
            ),
          ),
          ListTile(
            title: const Text(
              'Flo',
            ),
            trailing: Text(
              DateFormat('dd.MM.yyyy').format(
                DateTime(2003, 5, 7),
              ),
            ),
          ),
          ListTile(
            title: const Text(
              'Marcel',
            ),
            trailing: Text(
              DateFormat('dd.MM.yyyy').format(
                DateTime(1984, 3, 9),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
