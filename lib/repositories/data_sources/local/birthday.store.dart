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

  Future<void> persist({required List<Birthday> birthdays}) async {
    List<String> birthdaysEncoded = birthdays.map((birthday) => jsonEncode(birthday.toJson())).toList();
    read(sharedPrefs).setStringList("birthdays", birthdaysEncoded);
  }

  Future<List<Birthday>> fetchAll() async {
    final jsonList = read(sharedPrefs).getStringList("birthdays");
    return jsonList?.map((json) => Birthday.fromJson(jsonDecode(json))).toList() ?? [];
  }
}
