import 'package:flutter/material.dart';
import 'package:geburtstags_app/models/birthday.dart';
import 'package:geburtstags_app/repositories/birthday.repo.dart';
import 'package:geburtstags_app/screens/birthday/widgets/birthday_form.dart';
import 'package:intl/intl.dart';

class BirthdayDetailScreen extends StatefulWidget {
  const BirthdayDetailScreen({
    super.key,
  });
  static final routeName = (BirthdayDetailScreen).toString();

  @override
  State<BirthdayDetailScreen> createState() => _BirthdayDetailScreenState();
}

class _BirthdayDetailScreenState extends State<BirthdayDetailScreen> {
  late Birthday birthday;
  bool isEdited = false;

  @override
  Widget build(BuildContext context) {
    if (!isEdited) {
      birthday = ModalRoute.of(context)!.settings.arguments as Birthday;
    }

    void showAlertDialog() {
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text(
              '${birthday.name} wirklich löschen?',
            ),
            actions: <Widget>[
              TextButton(
                child: const Text(
                  'Abbrechen',
                ),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
              TextButton(
                child: const Text(
                  'Löschen',
                ),
                onPressed: () {
                  BirthdayRepo().delete(birthday);
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text(
                        '${birthday.name} gelöscht.',
                      ),
                    ),
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
        title: Text(
          birthday.name,
        ),
        actions: <Widget>[
          PopupMenuButton(itemBuilder: (context) {
            return [
              const PopupMenuItem<int>(
                value: 0,
                child: Text(
                  'Bearbeiten',
                ),
              ),
              const PopupMenuItem<int>(
                value: 1,
                child: Text(
                  'Löschen',
                ),
              ),
            ];
          }, onSelected: (value) async {
            if (value == 0) {
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
                isEdited = true;
                birthday = response;
              });
            }
            if (value == 1) {
              showAlertDialog();
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
              style: TextStyle(
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(
              height: 5,
            ),
            Text(
              birthday.name,
            ),
            // Datum
            const SizedBox(
              height: 20,
            ),
            const Text(
              'Geburtsdatum:',
              style: TextStyle(
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(
              height: 5,
            ),
            Text(
              DateFormat('dd.MM.yyyy').format(
                birthday.date,
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            // Zurück
            ElevatedButton(
              onPressed: () => Navigator.pop(context),
              child: const Text(
                'Zurück',
              ),
            )
          ],
        ),
      ),
    );
  }
}
