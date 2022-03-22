import 'dart:convert';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:geburtstags_app/main.dart';
import 'package:geburtstags_app/models/birthday.dart';

final birthdayStoreProvider = Provider<BirthdayStore>((ref) {
  return BirthdayStore(read: ref.read);
});

class BirthdayStore {
  const BirthdayStore({required this.read});

  final Reader read;

  void persist({required List<Birthday> birthdays}) {
    List<String> birthdaysEncoded = birthdays.map((birthday) => jsonEncode(birthday.toJson())).toList();
    read(sharedPrefs).setStringList("birthdays", birthdaysEncoded);
  }

  List<Birthday> fetchAll() {
    final jsonList = read(sharedPrefs).getStringList("birthdays");
    final decodedList = jsonList?.map((json) => Birthday.fromJson(jsonDecode(json))).toList();
    return decodedList ?? [];
  }
}
