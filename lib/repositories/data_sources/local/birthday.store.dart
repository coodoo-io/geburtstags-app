import 'dart:convert';

import 'package:geburtstags_app/models/birthday.dart';
import 'package:shared_preferences/shared_preferences.dart';

/// Managed die Birthdays in den Shared Preferences
class BirthdayStore {
  const BirthdayStore({required this.sharedPreferences});

  final SharedPreferences sharedPreferences;

  void persist({required List<Birthday> birthdays}) {
    List<String> birthdaysEncoded = birthdays.map((birthday) => jsonEncode(birthday.toJson())).toList();
    sharedPreferences.setStringList("birthdays", birthdaysEncoded);
  }

  List<Birthday> fetchAll() {
    final jsonList = sharedPreferences.getStringList("birthdays");
    final decodedList = jsonList?.map((json) => Birthday.fromJson(jsonDecode(json))).toList();
    return decodedList ?? [];
  }
}
