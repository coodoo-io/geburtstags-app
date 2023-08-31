import 'package:flutter/material.dart';
import 'package:geburtstags_app/repositories/birthday.repo.dart';
import 'package:geburtstags_app/screens/birthday/detail/birthday_detail.screen.dart';
import 'package:intl/intl.dart';

class BirthdaysScreen extends StatelessWidget {
  const BirthdaysScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final birthdays = BirthdayRepo().getBirthdays();
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Geburtstage',
        ),
      ),
      body: ListView.builder(
        itemCount: birthdays.length,
        itemBuilder: (context, index) {
          final birthday = birthdays[index];
          return ListTile(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => BirthdayDetailScreen(
                    birthday: birthday,
                  ),
                ),
              );
            },
            title: Text(
              birthday.name,
            ),
            trailing: Text(
              DateFormat('dd.MM.yyyy').format(
                birthday.date,
              ),
            ),
          );
        },
      ),
    );
  }
}
