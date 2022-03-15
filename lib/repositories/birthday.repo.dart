import 'package:flutter/material.dart';
import 'package:geburtstags_app/models/birthday.dart';
import 'package:geburtstags_app/util/datetime.util.dart';

class BirthdayRepo extends ChangeNotifier {
  final List<Birthday> birthdays = [];

  List<Birthday> get getBirthdays => birthdays;

  List<Birthday> getNextFiveBirthdays() {
    final dateTimeUtil = DateTimeUtil();
    List<Birthday> nextFiveBirthdays = birthdays;

    nextFiveBirthdays.sort((a, b) =>
        dateTimeUtil.remainingDaysUntilBirthday(a.date).compareTo(dateTimeUtil.remainingDaysUntilBirthday(b.date)));

    if (nextFiveBirthdays.length > 5) {
      return nextFiveBirthdays.sublist(0, 5);
    }
    return nextFiveBirthdays;
  }

  List<Birthday> getTodaysBirthdays() {
    List<Birthday> list = [];

    for (var i = 0; i < birthdays.length; i++) {
      if (birthdays[i].date.day == DateTime.now().day && birthdays[i].date.month == DateTime.now().month) list.add(birthdays[i]);
    }

    return list;
  }

  Birthday insert(Birthday birthday) {
    birthdays.add(birthday);
    notifyListeners();
    return birthday;
  }

  Birthday update(Birthday birthday) {
    throw UnimplementedError();
  }

  void delete(Birthday birthday) {
    birthdays.remove(birthday);
    notifyListeners();
  }
}
