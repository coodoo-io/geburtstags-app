import 'package:flutter/material.dart';
import 'package:geburtstags_app/repositories/birthday.repo.dart';
import 'package:geburtstags_app/screens/birthday/detail/birthday_detail.screen.dart';
import 'package:geburtstags_app/screens/birthday/detail/widgets/birthday_form.dart';
import 'package:intl/intl.dart';

class BirthdaysScreen extends StatefulWidget {
  const BirthdaysScreen({Key? key}) : super(key: key);

  @override
  State<BirthdaysScreen> createState() => _BirthdaysScreenState();
}

class _BirthdaysScreenState extends State<BirthdaysScreen> {
  @override
  Widget build(BuildContext context) {
    final repo = BirthdayRepo();
    final birthdays = repo.getBirthdays();
    return Scaffold(
      appBar: AppBar(title: const Text("Geburtstage")),
      body: ListView.builder(
        itemCount: birthdays.length,
        itemBuilder: (context, index) {
          final birthday = birthdays[index];
          return Dismissible(
            key: Key(index.toString()),
            direction: DismissDirection.endToStart,
            background: Container(
              color: Colors.red,
              child: const Padding(
                padding: EdgeInsets.only(right: 10.0),
                child: Align(
                  alignment: Alignment.centerRight,
                  child: Icon(
                    Icons.delete,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
            onDismissed: (direction) {
              setState(() {
                repo.delete(birthday);
              });
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text('${birthday.name} gelöscht.')),
              );
            },
            child: ListTile(
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
              title: Text(birthday.name),
              trailing: Text(
                DateFormat('dd.MM.yyyy').format(birthday.date),
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
              .then((value) => setState(() {}));
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
