import 'package:flutter/material.dart';
import 'package:geburtstags_app/models/birthday.dart';
import 'package:geburtstags_app/screens/birthday/widgets/birthday_form.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:share_plus/share_plus.dart';

import '../../../repositories/birthday.repo.dart';

class BirthdayDetailScreen extends StatefulWidget {
  const BirthdayDetailScreen({
    required this.birthday,
    Key? key,
  }) : super(key: key);

  final Birthday birthday;

  @override
  State<BirthdayDetailScreen> createState() => _BirthdayDetailScreenState();
}

class _BirthdayDetailScreenState extends State<BirthdayDetailScreen> {
  Birthday? birthday;
  @override
  Widget build(BuildContext context) {
    // Wenn die Detail Seite aufgerufen wid, ist birthday null. Dann wollen wir die übergebenen Daten verwenden.
    // Wenn wir updaten wollen, z.B. den Namen ändern wollen wir nicht nochmal die übergebenen Daten verwenden sondern die aktualisierten Daten.
    birthday ??= widget.birthday;

    void _showAlertDialog() {
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text("${birthday!.name} wirklich löschen?"),
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
                  context.read<BirthdayRepo>().delete(birthday!);
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text('${birthday!.name} gelöscht.')),
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
        title: Text(birthday!.name),
        actions: <Widget>[
          PopupMenuButton(
              // add icon, by default "3 dot" icon
              // icon: Icon(Icons.book)
              itemBuilder: (context) {
            return [
              const PopupMenuItem<int>(
                value: 0,
                child: Text("Teilen"),
              ),
              const PopupMenuItem<int>(
                value: 1,
                child: Text("Bearbeiten"),
              ),
              const PopupMenuItem<int>(
                value: 2,
                child: Text("Löschen"),
              ),
            ];
          }, onSelected: (value) async {
            if (value == 0) {
              Share.share(
                  '${birthday!.name} hat am ${DateFormat("dd.MM.yyyy").format(birthday!.date)} Geburtstag🎉');
            }
            if (value == 1) {
              final response = await Navigator.of(context).push(
                MaterialPageRoute(
                  fullscreenDialog: true,
                  builder: (BuildContext context) {
                    return BirthdayForm(
                      birthday: birthday,
                      isEdit: true,
                    );
                  },
                ),
              );

              setState(() {
                birthday = response;
              });
            }
            if (value == 2) {
              _showAlertDialog();
            }
          }),
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
            Text(birthday!.name),
            // Datum
            const SizedBox(height: 20),
            const Text(
              'Geburtsdatum:',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 5),
            Text(DateFormat('dd.MM.yyyy').format(birthday!.date)),
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
