import 'package:flutter/material.dart';
import 'package:geburtstags_app/repositories/birthday.repo.dart';
import 'package:geburtstags_app/screens/birthday/detail/birthday_detail.screen.dart';
import 'package:geburtstags_app/screens/birthday/widgets/birthday_form.dart';
import 'package:intl/intl.dart';

class BirthdaysScreen extends StatefulWidget {
  const BirthdaysScreen({Key? key}) : super(key: key);

  @override
  State<BirthdaysScreen> createState() => _BirthdaysScreenState();
}

class _BirthdaysScreenState extends State<BirthdaysScreen> {
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
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.of(context)
              .push(
                MaterialPageRoute(
                  fullscreenDialog: true,
                  builder: (BuildContext context) {
                    return const BirthdayForm();
                  },
                ),
              )
              .then(
                (value) => setState(() {
                  // refresh birthday list
                }),
              );
        },
        child: const Icon(
          Icons.add,
        ),
      ),
    );
  }
}
