import 'dart:developer';

import 'package:flutter/material.dart';
// ignore: unused_import
import 'package:geburtstags_app/app.dart';
import 'package:geburtstags_app/models/birthday.model.dart';
import 'package:geburtstags_app/repositories/birthday.repository.dart';
import 'package:geburtstags_app/screens/birthday/edit/birthday_form.screen.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class BirthdayDetail extends StatefulWidget {
  static String routeName = (BirthdayDetail).toString();

  BirthdayDetail({super.key});

  @override
  State<BirthdayDetail> createState() => _BirthdayDetailState();
}

class _BirthdayDetailState extends State<BirthdayDetail> {
  final DateFormat formater = DateFormat('dd.MM.yyyy');
  Birthday? birthday;
  @override
  Widget build(BuildContext context) {
    birthday ??= ModalRoute.of(context)!.settings.arguments as Birthday;

    return Scaffold(
      appBar: AppBar(
        title: Text(birthday!.name),
        actions: [
          PopupMenuButton(
            itemBuilder: (BuildContext context) {
              return [
                const PopupMenuItem(
                  value: 0,
                  child: Text('Bearbeiten'),
                ),
                const PopupMenuItem(
                  value: 1,
                  child: Text('Löschen'),
                ),
              ];
            },
            onSelected: (value) async {
              /// Bearbeiten
              if (value == 0) {
                log('Bearbeiten');
                birthday = await Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (_) {
                      return BirthdayForm(
                        birthday: birthday,
                        edit: true,
                      );
                    },
                  ),
                );
                setState(() {});
                if (context.mounted) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text('Geburtstag gespeichert'),
                      duration: Duration(seconds: 1),
                    ),
                  );
                }
              } else if (value == 1) {
                log('Löschen');
                final repo = context.read<BirthdayRepository>();
                repo.delete(birthday!);
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text('Geburtstag gelöscht'),
                    duration: Duration(seconds: 3),
                  ),
                );
                Navigator.of(context).pop();
              }
            },
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.only(left: 8.0, top: 16),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Text(birthday!.name),
            const SizedBox(
              height: 16,
            ),
            Text(formater.format(birthday!.birthday)),
            const SizedBox(
              height: 16,
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text('zurück'),
            ),
          ],
        ),
      ),
    );
  }
}
