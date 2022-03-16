import 'package:flutter/material.dart';
import 'package:geburtstags_app/models/birthday.dart';
import 'package:geburtstags_app/repositories/birthday.repo.dart';
import 'package:geburtstags_app/screens/birthday/widgets/birthday_form.dart';
import 'package:grouped_list/grouped_list.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

import 'detail/birthday_detail.screen.dart';

class BirthdaysScreen extends StatelessWidget {
  const BirthdaysScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final birthdays = context.watch<BirthdayRepo>().birthdays;
    List<Birthday> birthdays2 = List.from(birthdays);

    return Scaffold(
      appBar: AppBar(
        title: const Text("Geburtstage"),
      ),
      body: birthdays.isEmpty
          ? const Center(
              child: Text("Es stehen keine Geburtstage an"),
            )
          : Padding(
              padding: const EdgeInsets.all(20.0),
              child: GroupedListView<Birthday, int>(
                elements: birthdays2,
                groupBy: (element) => element.date.month,
                groupSeparatorBuilder: (int groupByValue) {
                  switch (groupByValue) {
                    case 1:
                      return const Text("Januar",
                          style: TextStyle(fontSize: 20));
                    case 2:
                      return const Text("Februar",
                          style: TextStyle(fontSize: 20));
                    case 3:
                      return const Text("März", style: TextStyle(fontSize: 20));
                    case 4:
                      return const Text("April",
                          style: TextStyle(fontSize: 20));
                    case 5:
                      return const Text("Mai", style: TextStyle(fontSize: 20));
                    case 6:
                      return const Text("Juni", style: TextStyle(fontSize: 20));
                    case 7:
                      return const Text("Juli", style: TextStyle(fontSize: 20));
                    case 8:
                      return const Text("August",
                          style: TextStyle(fontSize: 20));
                    case 9:
                      return const Text("September",
                          style: TextStyle(fontSize: 20));
                    case 10:
                      return const Text("Oktober",
                          style: TextStyle(fontSize: 20));
                    case 11:
                      return const Text("November",
                          style: TextStyle(fontSize: 20));
                    case 12:
                      return const Text("Dezember",
                          style: TextStyle(fontSize: 20));
                    default:
                      return const Text("Was geht ab",
                          style: TextStyle(fontSize: 20));
                  }
                },
                itemBuilder: (context, Birthday element) {
                  final birthday = element;
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
