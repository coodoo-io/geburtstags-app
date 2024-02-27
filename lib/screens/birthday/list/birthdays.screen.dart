import 'package:flutter/material.dart';
import 'package:geburtstags_app/common/constants.dart';
import 'package:geburtstags_app/models/birthday.model.dart';
import 'package:geburtstags_app/repositories/birthday.repository.dart';
import 'package:geburtstags_app/screens/birthday/detail/birthday_detail.screen.dart';
import 'package:geburtstags_app/screens/birthday/edit/birthday_form.screen.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:searchable_listview/searchable_listview.dart';

class GeburtstagsScreen extends StatelessWidget {
  final formater = DateFormat('dd.MM.yyyy');

  GeburtstagsScreen({super.key});
  @override
  Widget build(BuildContext context) {
    /// Lauschen hier auf die Änderungen an den Geburtstagen
    final birthdays = context.watch<BirthdayRepository>().birthdays;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Geburtstage'),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          await Navigator.of(context).push(
            MaterialPageRoute(
              builder: (_) => BirthdayForm(
                birthday:
                    Birthday(birthday: DateTime(2000, 1, 2), name: 'Markus'),
              ),
              fullscreenDialog: true,
            ),
          );
        },
        child: const Icon(Icons.add),
      ),
      body: Padding(
        padding: const EdgeInsets.all(kScreenPadding),
        child: SearchableList<Birthday>(
          displaySortWidget: true,
          sortPredicate: (a, b) => a.name.compareTo(b.name),
          builder: (list, index, item) {
            return Column(
              children: [
                ListTile(
                  title: Text(item.name),
                  trailing: Text(formater.format(item.birthday)),
                  onTap: () async {
                    await Navigator.of(context)
                        .pushNamed(BirthdayDetail.routeName, arguments: item);
                  },
                ),
              ],
            );
          },
          initialList: birthdays,
          filter: (p0) {
            return birthdays
                .where((element) =>
                    element.name.toLowerCase().contains(p0.toLowerCase()))
                .toList();
          },
          inputDecoration: InputDecoration(
            labelText: 'Search Birthday',
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
      ),
    );
  }
}
