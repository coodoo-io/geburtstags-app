import 'dart:convert';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:geburtstags_app/main.dart';
import 'package:geburtstags_app/models/birthday.dart';
import 'package:geburtstags_app/utils/datetime.util.dart';

final birthdayRepoProvider = StateNotifierProvider<BirthdayRepo, List<Birthday>>((ref) => BirthdayRepo(read: ref.read));

class BirthdayRepo extends StateNotifier<List<Birthday>> {
  BirthdayRepo({required this.read}) : super([]) {
    loadBirthdays();
  }

  final Reader read;

  List<Birthday> getNextFiveBirthdays(List<Birthday> birthdays) {
    final dateTimeUtil = DateTimeUtil();

    List<Birthday> nextFiveBirthdays = List.from(birthdays);

    nextFiveBirthdays.sort((a, b) =>
        dateTimeUtil.remainingDaysUntilBirthday(a.date).compareTo(dateTimeUtil.remainingDaysUntilBirthday(b.date)));

    if (nextFiveBirthdays.length > 5) {
      return nextFiveBirthdays.sublist(0, 5);
    }
    return nextFiveBirthdays;
  }

  List<Birthday> getTodaysBirthdays(List<Birthday> birthdays) {
    List<Birthday> list = [];

    for (var i = 0; i < birthdays.length; i++) {
      if (state[i].date.day == DateTime.now().day && state[i].date.month == DateTime.now().month) {
        list.add(state[i]);
      }
    }

    return list;
  }

  Birthday insert(Birthday birthday) {
    state=state = [...state, birthday];
    saveBirthdaysToSP();
    return birthday;
  }

  void update(Birthday oldData, Birthday newData) {
    state.remove(oldData);
    state=state = [...state, newData];
    saveBirthdaysToSP();
  }

  void delete(Birthday birthday) {
    state = [
      for (final b in state)
        if (b != birthday) b,
    ];
    saveBirthdaysToSP();
  }

  Future<void> saveBirthdaysToSP() async {
    List<String> birthdaysEncoded = state.map((birthday) => jsonEncode(birthday.toJson())).toList();
    read(sharedPrefs).setStringList("birthdays", birthdaysEncoded);
  }

  Future<void> loadBirthdays() async {
    final jsonList = read(sharedPrefs).getStringList("birthdays");
    final decodedList = jsonList?.map((json) => Birthday.fromJson(jsonDecode(json))).toList();
    state.addAll(decodedList ?? []);
  }
}
