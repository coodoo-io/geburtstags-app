import 'dart:convert';

import 'package:geburtstags_app/core/models/birthday.model.dart';
import 'package:geburtstags_app/locator.dart';
import 'package:shared_preferences/shared_preferences.dart';

class BirthdayStore {
  final SharedPreferences sharedPrefs = locator<SharedPreferences>();

  void persist({required List<Birthday> birthdays}) {
    List<String> birthdaysEncoded = birthdays.map((birthday) => jsonEncode(birthday.toJson())).toList();
    sharedPrefs.setStringList("birthdays", birthdaysEncoded);
  }

  List<Birthday> fetchAll() {
    final jsonList = sharedPrefs.getStringList("birthdays");
    final decodedList = jsonList?.map((json) => Birthday.fromJson(jsonDecode(json))).toList();
    return decodedList ?? [];
  }
}
