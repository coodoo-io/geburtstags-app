import 'package:geburtstags_app/models/birthday.dart';

class BirthdayRepo {
  BirthdayRepo() {
    birthdays.add(Birthday(date: DateTime(2020, 6, 12), name: "Max"));
    birthdays.add(Birthday(date: DateTime(1999, 1, 11), name: "Flo"));
    birthdays.add(Birthday(date: DateTime(1898, 7, 5), name: "Lena"));
    birthdays.add(Birthday(date: DateTime(2021, 9, 12), name: "Julia"));
    birthdays.add(Birthday(date: DateTime(2022, 10, 12), name: "Markus"));
    birthdays.add(Birthday(date: DateTime(2000, 11, 12), name: "Rüdiger"));
    birthdays.add(Birthday(date: DateTime(1989, 12, 12), name: "Marcel"));
  }

  final List<Birthday> birthdays = [];

  List<Birthday> getBirthdays() {
    return birthdays;
  }

  Birthday insert(Birthday birthday) {
    throw UnimplementedError();
  }

  Birthday update(Birthday birthday) {
    throw UnimplementedError();
  }

  void delete(Birthday birthday) {
    throw UnimplementedError();
  }
}
