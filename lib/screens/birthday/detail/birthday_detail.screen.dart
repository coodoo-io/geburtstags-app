import 'package:flutter/material.dart';
import 'package:geburtstags_app/models/birthday.dart';
import 'package:intl/intl.dart';

class BirthdayDetailScreen extends StatelessWidget {
  const BirthdayDetailScreen({
    required this.birthday,
    Key? key,
  }) : super(key: key);

  final Birthday birthday;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(birthday.name),
      ),
      body: Padding(
        padding: const EdgeInsets.all(30),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Name
            const Text(
              'Name:',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 5),
            Text(birthday.name),
            // Datum
            const SizedBox(height: 20),
            const Text(
              'Geburtsdatum:',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 5),
            Text(DateFormat('dd.MM.yyyy').format(birthday.date)),
            const SizedBox(height: 20),
            // Zurück
            ElevatedButton(
              onPressed: () => Navigator.pop(context),
              child: const Text("Zurück"),
            )
          ],
        ),
      ),
    );
  }
}
