import 'dart:collection';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:geburtstags_app/models/birthday.dart';
import 'package:geburtstags_app/utils/datetime.util.dart';
import 'package:shared_preferences/shared_preferences.dart';

class BirthdayRepo extends ChangeNotifier {
  static final BirthdayRepo _birthdayRepo = BirthdayRepo._internal();

  factory BirthdayRepo() {
    return _birthdayRepo;
  }

  BirthdayRepo._internal() {
    loadBirthdaysToSP();
  }

  final List<Birthday> _birthdays = [];

  UnmodifiableListView<Birthday> get birthdays =>
      UnmodifiableListView(_birthdays);

  List<Birthday> getNextFiveBirthdays() {
    final dateTimeUtil = DateTimeUtil();

    List<Birthday> nextFiveBirthdays = List.from(_birthdays);

    nextFiveBirthdays.sort((a, b) => dateTimeUtil
        .remainingDaysUntilBirthday(a.date)
        .compareTo(dateTimeUtil.remainingDaysUntilBirthday(b.date)));

    if (nextFiveBirthdays.length > 5) {
      return nextFiveBirthdays.sublist(0, 5);
    }
    return nextFiveBirthdays;
  }

  List<Birthday> getTodaysBirthdays() {
    List<Birthday> list = [];

    for (var i = 0; i < _birthdays.length; i++) {
      if (_birthdays[i].date.day == DateTime.now().day &&
          _birthdays[i].date.month == DateTime.now().month) {
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
    final prefs = await SharedPreferences.getInstance();
    List<String> birthdaysEncoded =
        _birthdays.map((birthday) => jsonEncode(birthday.toJson())).toList();
    prefs.setStringList("birthdays", birthdaysEncoded);
  }

  Future<void> loadBirthdaysToSP() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    final jsonList = sharedPreferences.getStringList("birthdays");
    final decodedList =
        jsonList?.map((json) => Birthday.fromJson(jsonDecode(json))).toList();
    _birthdays.addAll(decodedList ?? []);
    notifyListeners();
  }
}
