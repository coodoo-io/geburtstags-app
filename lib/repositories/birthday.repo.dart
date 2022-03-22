import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:geburtstags_app/main.dart';
import 'package:geburtstags_app/models/birthday.dart';
import 'package:geburtstags_app/utils/datetime.util.dart';

@immutable
class BirthdayState {
  const BirthdayState({
    required this.birthdays,
    required this.next5Birthdays,
    required this.todaysBirthdays,
  });

  BirthdayState copyWith({
    List<Birthday>? birthdays,
    List<Birthday>? next5Birthdays,
    List<Birthday>? todaysBirthdays,
  }) {
    return BirthdayState(
        birthdays: birthdays ?? this.birthdays,
        next5Birthdays: next5Birthdays ?? this.next5Birthdays,
        todaysBirthdays: todaysBirthdays ?? this.todaysBirthdays);
  }

  final List<Birthday> birthdays;
  final List<Birthday> next5Birthdays;
  final List<Birthday> todaysBirthdays;
}

final birthdayRepoProvider = StateNotifierProvider<BirthdayRepo, BirthdayState>((ref) {
  const initialState = BirthdayState(birthdays: [], next5Birthdays: [], todaysBirthdays: []);
  return BirthdayRepo(read: ref.read, initialState: initialState);
});

class BirthdayRepo extends StateNotifier<BirthdayState> {
  BirthdayRepo({required this.read, required BirthdayState initialState}) : super(initialState) {
    loadBirthdays();
  }

  final Reader read;

  List<Birthday> _calcNextFiveBirthdays(List<Birthday> birthdays) {
    final dateTimeUtil = DateTimeUtil();

    List<Birthday> nextFiveBirthdays = List.from(birthdays);

    nextFiveBirthdays.sort((a, b) =>
        dateTimeUtil.remainingDaysUntilBirthday(a.date).compareTo(dateTimeUtil.remainingDaysUntilBirthday(b.date)));

    if (nextFiveBirthdays.length > 5) {
      return nextFiveBirthdays.sublist(0, 5);
    }
    return nextFiveBirthdays;
  }

  List<Birthday> _calcTodaysBirthdays(List<Birthday> birthdays) {
    List<Birthday> list = [];

    birthdays.map((birthday) {
      if (birthday.date.day == DateTime.now().day && birthday.date.month == DateTime.now().month) {
        list.add(birthday);
      }
    });

    return list;
  }

  Birthday insert(Birthday birthday) {
    final newBirthdayList = [...state.birthdays, birthday];
    state = state.copyWith(birthdays: newBirthdayList,next5Birthdays: _calcNextFiveBirthdays(newBirthdayList),
        todaysBirthdays: _calcTodaysBirthdays(newBirthdayList));
    saveBirthdaysToSP();
    return birthday;
  }

  void update(Birthday oldData, Birthday newData) {
    delete(oldData);
    insert(newData);
    saveBirthdaysToSP();
  }

  void delete(Birthday birthday) {
    final newBirthdayList = [
      for (final b in state.birthdays)
        if (b != birthday) b,
    ];

    state = state.copyWith(birthdays: newBirthdayList, next5Birthdays: _calcNextFiveBirthdays(newBirthdayList), todaysBirthdays: _calcTodaysBirthdays(newBirthdayList));
    saveBirthdaysToSP();
  }

  Future<void> saveBirthdaysToSP() async {
    List<String> birthdaysEncoded = state.birthdays.map((birthday) => jsonEncode(birthday.toJson())).toList();
    read(sharedPrefs).setStringList("birthdays", birthdaysEncoded);
  }

  Future<void> loadBirthdays() async {
    final jsonList = read(sharedPrefs).getStringList("birthdays");
    final birthdayList = jsonList?.map((json) => Birthday.fromJson(jsonDecode(json))).toList() ?? [];
    state = state.copyWith(
        birthdays: birthdayList,
        next5Birthdays: _calcNextFiveBirthdays(birthdayList),
        todaysBirthdays: _calcTodaysBirthdays(birthdayList));
  }
}
