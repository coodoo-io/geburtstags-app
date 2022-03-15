import 'package:geburtstags_app/models/birthday.dart';
import 'package:geburtstags_app/util/datetime.util.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';

class BirthdayRepo {
  static final BirthdayRepo _birthdayRepo = BirthdayRepo._internal();

  factory BirthdayRepo() {
    return _birthdayRepo;
  }

  BirthdayRepo._internal() {
    loadBirthdaysToSP();
  }

  final List<Birthday> birthdays = [];

  List<Birthday> getBirthdays() {
    return birthdays;
  }

  List<Birthday> getNextFiveBirthdays() {
    final dateTimeUtil = DateTimeUtil();
    List<Birthday> nextFiveBirthdays = birthdays;

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

    for (var i = 0; i < birthdays.length; i++) {
      if (birthdays[i].date.day == DateTime.now().day &&
          birthdays[i].date.month == DateTime.now().month) {
        list.add(birthdays[i]);
      }
    }

    return list;
  }

  Birthday insert(Birthday birthday) {
    birthdays.add(birthday);
    saveBirthdaysToSP();
    return birthday;
  }

  Birthday update(Birthday birthday) {
    throw UnimplementedError();
  }

  void delete(Birthday birthday) {
    birthdays.remove(birthday);
  }

  Future<void> saveBirthdaysToSP() async {
    final prefs = await SharedPreferences.getInstance();
    List<String> birthdaysEncoded =
        birthdays.map((birthday) => jsonEncode(birthday.toJson())).toList();
    prefs.setStringList("birthdays", birthdaysEncoded);
  }

  Future<void> loadBirthdaysToSP() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    final jsonList = sharedPreferences.getStringList("birthdays");
    final decodedList =
        jsonList?.map((json) => Birthday.fromJson(jsonDecode(json))).toList();
    birthdays.addAll(decodedList ?? []);
  }
}
