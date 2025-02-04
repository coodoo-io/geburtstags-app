import 'package:flutter/material.dart';
import 'package:geburtstags_app/repositories/birthday.repo.dart';
import 'package:geburtstags_app/screens/birthday/detail/birthday_detail.controller.dart';
import 'package:geburtstags_app/screens/birthday/detail/birthday_detail.screen.dart';
import 'package:geburtstags_app/screens/birthday/widgets/birthday_form.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class BirthdaysScreen extends StatelessWidget {
  const BirthdaysScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final birthdays = context.watch<BirthdayRepo>().getBirthdays();
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Geburtstage",
        ),
        actions: [
          IconButton(
            onPressed: () => null,
            icon: const Icon(
              Icons.refresh,
            ),
          ),
        ],
      ),
      body: ListView.builder(
        itemCount: birthdays.length,
        itemBuilder: (context, index) {
          final birthday = birthdays[index];
          return Dismissible(
            key: UniqueKey(),
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
              context.read<BirthdayRepo>().delete(birthday);
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  margin: const EdgeInsets.only(
                      bottom: kBottomNavigationBarHeight +
                          kFloatingActionButtonMargin +
                          10,
                      left: 10,
                      right: 10),
                  behavior: SnackBarBehavior.floating,
                  content: Text(
                    '${birthday.name} gelöscht.',
                  ),
                ),
              );
            },
            child: ListTile(
              onTap: () async {
                context.read<BirthdayDetailController>().setBirthday(birthday);
                await Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) {
                      return BirthdayDetailScreen();
                    },
                  ),
                );
              },
              title: Text(
                birthday.name,
              ),
              trailing: Text(
                DateFormat('dd.MM.yyyy').format(birthday.date),
              ),
            ),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          await Navigator.of(context).push(
            MaterialPageRoute(
              fullscreenDialog: true,
              builder: (BuildContext context) {
                return const BirthdayForm();
              },
            ),
          );
          ;
        },
        child: const Icon(
          Icons.add,
        ),
      ),
    );
  }
}
