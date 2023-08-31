import 'dart:collection';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:geburtstags_app/models/birthday.dart';
import 'package:geburtstags_app/utils/datetime.util.dart';
import 'package:http/http.dart' as http;

extension StringCapitalizeExtension on String {
  /// Makes the first letter of a string uppercase.
  String get toCapitalized => length > 0 ? '${this[0].toUpperCase()}${substring(1).toLowerCase()}' : '';

  /// Makes every word's first letter uppercase.
  String get capitalizeFirstofEach => split(" ").map((str) => str.toCapitalized).join(" ");
}

class BirthdayRepo extends ChangeNotifier {
  static final BirthdayRepo _birthdayRepo = BirthdayRepo._internal();

  factory BirthdayRepo() {
    return _birthdayRepo;
  }

  BirthdayRepo._internal() {
    getCelebrityBirthdays();
  }

  final List<Birthday> _birthdays = [];
  List<Birthday> _celebrityBirthdays = [];

  UnmodifiableListView<Birthday> get birthdays => UnmodifiableListView(_birthdays);
  UnmodifiableListView<Birthday> get celebrityBirthdays => UnmodifiableListView(_celebrityBirthdays);

  List<Birthday> getNextFiveBirthdays() {
    final dateTimeUtil = DateTimeUtil();
    List<Birthday> nextFiveBirthdays = List.from(_birthdays);

    nextFiveBirthdays.sort(
      (a, b) => dateTimeUtil.remainingDaysUntilBirthday(a.date).compareTo(
            dateTimeUtil.remainingDaysUntilBirthday(b.date),
          ),
    );

    if (nextFiveBirthdays.length > 5) {
      return nextFiveBirthdays.sublist(0, 5);
    }
    return nextFiveBirthdays;
  }

  List<Birthday> getTodaysBirthdays() {
    List<Birthday> list = [];

    for (var i = 0; i < _birthdays.length; i++) {
      if (_birthdays[i].date.day == DateTime.now().day && _birthdays[i].date.month == DateTime.now().month) {
        list.add(_birthdays[i]);
      }
    }

    return list;
  }

  Birthday insert(Birthday birthday) {
    _birthdays.add(birthday);
    notifyListeners();
    return birthday;
  }

  void update(Birthday oldData, Birthday newData) {
    _birthdays.remove(oldData);
    _birthdays.add(newData);
    notifyListeners();
  }

  void delete(Birthday birthday) {
    _birthdays.remove(birthday);
    notifyListeners();
  }

  Future<void> getCelebrityBirthdays() async {
    final dateTimeUtil = DateTimeUtil();
    List<Birthday> celebrityList = [];

    http.Response response = await http.get(
      Uri.parse("https://api.api-ninjas.com/v1/celebrity?nationality=de"),
      headers: {"X-Api-Key": "f1Tw9ffI9KwvpkGjDu+72w==ZbJwp82UJeixx23J"},
    );

    if (response.statusCode == 200) {
      final List decodedList = jsonDecode(response.body);
      for (var element in decodedList) {
        Birthday birthday;

        // Ignore if birthday is null

        if (element["birthday"] == null) {
        }
        // If only the birth year is given
        else if (element["birthday"].length == 4) {
          birthday = Birthday(
            name: element["name"].toString().capitalizeFirstofEach,
            date: DateTime(int.parse(element["birthday"])),
          );
          celebrityList.add(birthday);
        } else {
          birthday = Birthday(
            name: element["name"].toString().capitalizeFirstofEach,
            date: DateTime.parse(element["birthday"]),
          );

          celebrityList.add(birthday);
        }
      }

      celebrityList.sort(
        (a, b) => dateTimeUtil.remainingDaysUntilBirthday(a.date).compareTo(
              dateTimeUtil.remainingDaysUntilBirthday(b.date),
            ),
      );
    }

    _celebrityBirthdays = celebrityList.sublist(0, 5);

    notifyListeners();
  }
}
