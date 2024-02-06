import 'package:flutter/material.dart';
import 'package:geburtstags_app/models/birthday.model.dart';
import 'package:geburtstags_app/repositories/birthday.repository.dart';
import 'package:geburtstags_app/screens/birthday/birthday_detail.screen.dart';
import 'package:intl/intl.dart';
import 'package:searchable_listview/searchable_listview.dart';

class GeburtstagsScreen extends StatelessWidget {
  const GeburtstagsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    DateFormat formater = DateFormat('dd.MM.yyyy');

    final birthdayRepository = BirthdayRepository();
    final secondBirthdayRepository = BirthdayRepository();
    secondBirthdayRepository.insert(
        FreezedBirthday(birthday: DateTime(1990, 01, 01), name: 'test'));

    final birthdays = birthdayRepository.getBirthdays();

    return Scaffold(
      appBar: AppBar(
        title: const Text('GeburtstagsScreen'),
      ),
      body: SearchableList<FreezedBirthday>(
        displaySortWidget: true,
        sortPredicate: (a, b) => a.name.compareTo(b.name),
        builder: (list, index, item) {
          return Column(
            children: [
              ListTile(
                subtitle: Text(item.name),
                trailing: Text(formater.format(item.birthday)),
                leading: Text(item.notes!),
                onTap: () {
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (_) => BirthdayDetail(
                        birthday: item,
                      ),
                    ),
                  );
                },
              ),
            ],
          );
        },
        initialList: birthdays,
        filter: (p0) {
          return birthdays
              .where((element) => element.name.contains(p0))
              .toList();
        },
        inputDecoration: InputDecoration(
          labelText: "Search Birthday",
          fillColor: Colors.white,
          focusedBorder: OutlineInputBorder(
            borderSide: const BorderSide(
              color: Colors.blue,
              width: 1.0,
            ),
            borderRadius: BorderRadius.circular(10.0),
          ),
        ),
      ),
    );
  }
}
