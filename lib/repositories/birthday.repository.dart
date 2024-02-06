import 'package:geburtstags_app/models/birthday.model.dart';

class BirthdayRepository {
  static final BirthdayRepository _singleton = BirthdayRepository._internal();

  BirthdayRepository._internal() {
    birthdays
        .add(FreezedBirthday(birthday: DateTime(1984, 3, 9), name: 'Marcel'));
  }

  factory BirthdayRepository() {
    return _singleton;
  }

  final List<FreezedBirthday> birthdays = [];

  List<FreezedBirthday> getBirthdays() {
    return birthdays;
  }

  void insert(FreezedBirthday birthday) {
    birthdays.add(birthday);
  }
}
