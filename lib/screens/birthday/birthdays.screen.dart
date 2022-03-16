import 'package:flutter/material.dart';
import 'package:geburtstags_app/models/birthday.dart';
import 'package:geburtstags_app/repositories/birthday.repo.dart';
import 'package:geburtstags_app/screens/birthday/detail/birthday_detail.screen.dart';
import 'package:geburtstags_app/screens/birthday/widgets/birthday_form.dart';
import 'package:grouped_list/grouped_list.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

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
              padding: const EdgeInsets.fromLTRB(20, 0, 20, 20),
              child: GroupedListView<Birthday, int>(
                elements: birthdays2,
                groupBy: (element) => element.date.month,
                groupSeparatorBuilder: (int groupByValue) {
                  String month = "";
                  switch (groupByValue) {
                    case 1:
                      month = "Januar";
                      break;
                    case 2:
                      month = "Februar";
                      break;
                    case 3:
                      month = "März";
                      break;
                    case 4:
                      month = "April";
                      break;
                    case 5:
                      month = "Mai";
                      break;
                    case 6:
                      month = "Juni";
                      break;
                    case 7:
                      month = "Juli";
                      break;
                    case 8:
                      month = "August";
                      break;
                    case 9:
                      month = "September";
                      break;
                    case 10:
                      month = "Oktober";
                      break;
                    case 11:
                      month = "November";
                      break;
                    case 12:
                      month = "Dezember";
                      break;
                    default:
                      month = "";
                      break;
                  }
                  return Padding(
                      padding: const EdgeInsets.only(top: 15, bottom: 5),
                      child: Text(month, style: const TextStyle(fontSize: 20)));
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
                    child: Card(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15),
                      ),
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
