import 'dart:collection';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:geburtstags_app/main.dart';
import 'package:geburtstags_app/models/birthday.dart';
import 'package:geburtstags_app/utils/datetime.util.dart';

final birthdayRepoProvider = ChangeNotifierProvider<BirthdayRepo>((ref) => BirthdayRepo(read: ref.read));

class BirthdayRepo extends ChangeNotifier {
  BirthdayRepo({required this.read}) {
    loadBirthdays();
  }

  final Reader read;
  final List<Birthday> _birthdays = [];

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
    saveBirthdaysToSP();
    notifyListeners();
    return birthday;
  }

  void update(Birthday oldData, Birthday newData) {
    _birthdays.remove(oldData);
    _birthdays.add(newData);
    saveBirthdaysToSP();
    notifyListeners();
  }

  void delete(Birthday birthday) {
    _birthdays.remove(birthday);
    saveBirthdaysToSP();
    notifyListeners();
  }

  Future<void> saveBirthdaysToSP() async {
    List<String> birthdaysEncoded = _birthdays.map((birthday) => jsonEncode(birthday.toJson())).toList();
    read(sharedPrefs).setStringList("birthdays", birthdaysEncoded);
  }

  Future<void> loadBirthdays() async {
    final jsonList = read(sharedPrefs).getStringList("birthdays");
    final decodedList = jsonList?.map((json) => Birthday.fromJson(jsonDecode(json))).toList();
    _birthdays.addAll(decodedList ?? []);
    notifyListeners();
  }
}
