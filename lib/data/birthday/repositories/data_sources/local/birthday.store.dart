import 'dart:convert';

import 'package:geburtstags_app/domain/birthday/model/birthday.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import 'package:uuid/uuid.dart';

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

  Future<List<Birthday>> getCelebrityBirthdays() async {
    List<Birthday> celebrityList = [];

    http.Response response = await http.get(
      Uri.parse("https://api.api-ninjas.com/v1/celebrity?nationality=de"),
      headers: {"X-Api-Key": "f1Tw9ffI9KwvpkGjDu+72w==ZbJwp82UJeixx23J"},
    );

    if (response.statusCode == 200) {
      final List decodedList = jsonDecode(response.body);
      for (var element in decodedList) {
        Birthday birthday;

        // Ignore if birthday is null

        if (element["birthday"] == null) {
        }
        // If only the birth year is given
        else if (element["birthday"].length == 4) {
          birthday = Birthday(
            id: Uuid().v4(),
            name: element["name"].toString(),
            date: DateTime(int.parse(element["birthday"])),
          );
          celebrityList.add(birthday);
        } else {
          birthday = Birthday(
            id: Uuid().v4(),
            name: element["name"].toString(),
            date: DateTime.parse(element["birthday"]),
          );

          celebrityList.add(birthday);
        }
      }
      return celebrityList.sublist(0, 10).toList();
    }
    return [];
  }
}
