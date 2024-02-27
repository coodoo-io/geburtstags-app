import 'dart:collection';

import 'package:flutter/material.dart';
import 'package:geburtstags_app/common/util/datetime.uitl.dart';
import 'package:geburtstags_app/models/birthday.model.dart';

class BirthdayRepository extends ChangeNotifier {
  BirthdayRepository() {
    birthdays.add(Birthday(birthday: DateTime(1984, 3, 9), name: 'Marcel 1'));
    birthdays.add(Birthday(birthday: DateTime(1994, 1, 20), name: 'Marcel 2'));
    birthdays.add(Birthday(birthday: DateTime(1924, 4, 12), name: 'Marcel 3'));
    birthdays.add(Birthday(birthday: DateTime(2011, 6, 3), name: 'Marcel 4'));
    birthdays.add(Birthday(birthday: DateTime(2000, 12, 31), name: 'Marcel 5'));
    birthdays.add(Birthday(birthday: DateTime(1900, 1, 1), name: 'Marcel 6'));
  }

  final List<Birthday> birthdays = [];
  bool isLoading = false;

  get getBirthdays {
    return UnmodifiableListView(birthdays);
  }

  List<Birthday> getNextFiveBirthdays() {
    final dateTimeUtil = DateTimeUtil();
    List<Birthday> birthdaysCopy = List.from(birthdays);

    final now = DateTime.now();

    birthdaysCopy.sort((a, b) => dateTimeUtil
        .remainingDaysUntilBirthday(a.birthday, now)
        .compareTo(dateTimeUtil.remainingDaysUntilBirthday(b.birthday, now)));

    if (birthdaysCopy.length > 5) {
      return UnmodifiableListView(birthdaysCopy.sublist(0, 5));
    }

    return UnmodifiableListView(birthdaysCopy);
  }

  void insert(Birthday birthday) async {
    isLoading = true;
    notifyListeners();
    await Future.delayed(Duration(seconds: 10));
    birthdays.add(birthday);
    isLoading = false;
    notifyListeners();
  }

  Birthday update(Birthday oldBirthday, Birthday newBirthday) {
    birthdays.remove(oldBirthday);
    birthdays.add(newBirthday);
    notifyListeners();
    return newBirthday;
  }

  void delete(Birthday birthday) {
    birthdays.remove(birthday);
    notifyListeners();
  }
}
