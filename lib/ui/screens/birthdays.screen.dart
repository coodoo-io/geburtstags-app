import 'package:flutter/material.dart';
import 'package:geburtstags_app/core/viewmodels/birthday.viewmodel.dart';
import 'package:geburtstags_app/locator.dart';
import 'package:geburtstags_app/ui/screens/birthday_detail.screen.dart';
import 'package:geburtstags_app/ui/widgets/birthday_form.dart';
import 'package:intl/intl.dart';

class BirthdaysScreen extends StatelessWidget {
  const BirthdaysScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final BirthdayViewModel model = locator<BirthdayViewModel>();
    model.getBirthdayList();
    return Scaffold(
      appBar: AppBar(
        title: const Text("Geburtstage"),
      ),
      body: ListView.builder(
        itemCount: model.birthdays.length,
        itemBuilder: (context, index) {
          final birthday = model.birthdays[index];
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
              model.removeBirthday(birthday);
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
