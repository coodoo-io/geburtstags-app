import 'package:flutter/material.dart';
import 'package:geburtstags_app/models/birthday.dart';
import 'package:intl/intl.dart';

import '../../../repositories/birthday.repo.dart';
import '../widgets/birthday_form.dart';

class BirthdayDetailScreen extends StatefulWidget {
  BirthdayDetailScreen({
    required this.birthday,
    Key? key,
  }) : super(key: key);

  Birthday birthday;

  @override
  State<BirthdayDetailScreen> createState() => _BirthdayDetailScreenState();
}

class _BirthdayDetailScreenState extends State<BirthdayDetailScreen> {
  void _showAlertDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text("${widget.birthday.name} wirklich löschen?"),
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
                BirthdayRepo().delete(widget.birthday);
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text('${widget.birthday.name} gelöscht.')),
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.birthday.name),
        actions: <Widget>[
          PopupMenuButton(
              // add icon, by default "3 dot" icon
              // icon: Icon(Icons.book)
              itemBuilder: (context) {
            return [
              PopupMenuItem<int>(
                value: 0,
                child: Text("${widget.birthday.name} bearbeiten"),
              ),
              PopupMenuItem<int>(
                value: 1,
                child: Text("${widget.birthday.name} löschen"),
              ),
            ];
          }, onSelected: (value) async {
            if (value == 0) {
              final response = await Navigator.of(context).push(
                MaterialPageRoute(
                  fullscreenDialog: true,
                  builder: (BuildContext context) {
                    return BirthdayForm(
                      birthday: widget.birthday,
                      isEdit: true,
                    );
                  },
                ),
              );

              setState(() {
                widget.birthday = response;
              });
            }
            if (value == 1) {
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
            Text(widget.birthday.name),
            // Datum
            const SizedBox(height: 20),
            const Text(
              'Geburtsdatum:',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 5),
            Text(DateFormat('dd.MM.yyyy').format(widget.birthday.date)),
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
