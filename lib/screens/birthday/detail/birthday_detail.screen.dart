import 'package:flutter/material.dart';
import 'package:geburtstags_app/models/birthday.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:share_plus/share_plus.dart';

import '../../../repositories/birthday.repo.dart';

class BirthdayDetailScreen extends StatelessWidget {
  const BirthdayDetailScreen({required this.birthday, Key? key}) : super(key: key);

  final Birthday birthday;

  @override
  Widget build(BuildContext context) {
    void _showAlertDialog() {
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text("${birthday.name} wirklich löschen?"),
            actions: <Widget>[
              TextButton(
                child: const Text("Abbrechen"),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
              TextButton(
                child: const Text("Löschen"),
                onPressed: () {
                  context.read<BirthdayRepo>().delete(birthday);
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text('${birthday.name} gelöscht.')),
                  );
                  Navigator.of(context).pop();
                  Navigator.pop(context);
                },
              ),
            ],
          );
        },
      );
    }

    return Scaffold(
      appBar: AppBar(
        title: Text(birthday.name),
        actions: [
          IconButton(
            onPressed: () {
              Share.share('${birthday.name} hat am ${DateFormat("dd.MM.yyyy").format(birthday.date)} Geburtstag🎉');
            },
            icon: const Icon(Icons.share),
          ),
          IconButton(
            onPressed: () {
              _showAlertDialog();
            },
            icon: const Icon(Icons.delete),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(30),
        child: Column(
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
