import 'dart:collection';

import 'package:flutter/material.dart';
import 'package:geburtstags_app/models/birthday.dart';
import 'package:geburtstags_app/util/datetime.util.dart';

class BirthdayRepo extends ChangeNotifier {
  static final BirthdayRepo _birthdayRepo = BirthdayRepo._internal();

  factory BirthdayRepo() {
    return _birthdayRepo;
  }

  BirthdayRepo._internal();

  final List<Birthday> _birthdays = [];

  /// An unmodifiable view of the items in the cart.
  UnmodifiableListView<Birthday> get birthdays => UnmodifiableListView(_birthdays);

  List<Birthday> getNextFiveBirthdays() {
    final dateTimeUtil = DateTimeUtil();
    List<Birthday> nextFiveBirthdays = List.from(_birthdays);

    nextFiveBirthdays.sort((a, b) =>
        dateTimeUtil.remainingDaysUntilBirthday(a.date).compareTo(dateTimeUtil.remainingDaysUntilBirthday(b.date)));

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

  Birthday update(Birthday birthday) {
    throw UnimplementedError();
  }

  void delete(Birthday birthday) {
    _birthdays.remove(birthday);
    notifyListeners();
  }
}
