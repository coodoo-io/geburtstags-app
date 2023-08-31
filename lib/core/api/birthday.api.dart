import 'dart:convert';

import 'package:geburtstags_app/core/models/birthday.model.dart';
import 'package:http/http.dart' as http;

/// The service responsible for networking requests
class BirthdayApi {
  static const endpoint = 'https://myapi';

  final client = http.Client();

  Future<List<Birthday>> getBirthdayList() async {
    final List<Birthday> birthdays = [];

    // Get birthday list from api
    final response = await client.get(Uri.parse("$endpoint/birthdays"));

    // Parse into List
    final parsed = json.decode(response.body) as List<dynamic>;

    // Loop and convert each item to a Birthday
    for (final birthday in parsed) {
      birthdays.add(Birthday.fromJson(birthday));
    }

    return birthdays;
  }
}
