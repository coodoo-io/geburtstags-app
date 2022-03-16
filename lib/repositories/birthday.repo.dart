import 'package:geburtstags_app/models/birthday.dart';

class BirthdayRepo {
  static final BirthdayRepo _birthdayRepo = BirthdayRepo._internal();

  factory BirthdayRepo() {
    return _birthdayRepo;
  }

  BirthdayRepo._internal() {
    _birthdays.add(Birthday(date: DateTime(2020, 6, 12), name: "Max"));
    _birthdays.add(Birthday(date: DateTime(1999, 1, 11), name: "Flo"));
    _birthdays.add(Birthday(date: DateTime(1898, 7, 5), name: "Lena"));
    _birthdays.add(Birthday(date: DateTime(2021, 9, 12), name: "Julia"));
    _birthdays.add(Birthday(date: DateTime(2022, 10, 12), name: "Markus"));
    _birthdays.add(Birthday(date: DateTime(2000, 11, 12), name: "Rüdiger"));
    _birthdays.add(Birthday(date: DateTime(1989, 12, 12), name: "Marcel"));
  }

  final List<Birthday> _birthdays = [];

  List<Birthday> getBirthdays() {
    return _birthdays;
  }

  Birthday insert(Birthday birthday) {
    _birthdays.add(birthday);
    return birthday;
  }

  void update(Birthday oldData, Birthday newData) {
    _birthdays.remove(oldData);
    _birthdays.add(newData);
  }

  void delete(Birthday birthday) {
    _birthdays.remove(birthday);
  }

  void edit(Birthday birthday) {}
}
