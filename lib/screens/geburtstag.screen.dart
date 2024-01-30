import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:searchable_listview/searchable_listview.dart';

class GeburtstagsScreen extends StatelessWidget {
  const GeburtstagsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    DateFormat formater = DateFormat('dd.MM.yyyy');
    DateFormat secondFormater = DateFormat('M.yy');
    DateFormat fromDateFormat = DateFormat('yyyy-MM-dd');

    List<Map<String, String>> birthdays = [
      {'marcel': '1984-01-09'},
      {'markus': '1984-02-09'},
      {'julian': '1984.03-09'},
      {'marcel': '1984-04-09'},
    ];

    return Scaffold(
      appBar: AppBar(
        title: const Text('GeburtstagsScreen'),
      ),
      body: SearchableList<Map<String, String>>(
        displaySortWidget: true,
        sortPredicate: (a, b) => a.keys.first.compareTo(b.keys.first),
        builder: (list, index, item) {
          return ListTile(
            leading: Text(item.keys.first),
            trailing: Text(item.values.last),
          );
        },
        initialList: birthdays,
        filter: (p0) {
          return birthdays
              .where((element) => element.keys.first.contains(p0))
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
