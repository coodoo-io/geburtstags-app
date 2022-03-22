import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:geburtstags_app/repositories/birthday.repo.dart';
import 'package:geburtstags_app/screens/birthday/detail/birthday_detail.screen.dart';
import 'package:geburtstags_app/screens/birthday/widgets/birthday_form.dart';
import 'package:intl/intl.dart';

class BirthdaysScreen extends ConsumerWidget {
  const BirthdaysScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final birthdays = ref.watch(birthdayRepoProvider);
    return Scaffold(
      appBar: AppBar(
        title: const Text("Geburtstage"),
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
              ref.read(birthdayRepoProvider.notifier).delete(birthday);
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text("${birthday.name} gelöscht.")),
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
          Navigator.of(context).push(
            MaterialPageRoute(
              fullscreenDialog: true,
              builder: (BuildContext context) {
                return const BirthdayForm();
              },
            ),
          );
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
