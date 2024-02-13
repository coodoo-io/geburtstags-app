import 'package:geburtstags_app/models/birthday.model.dart';

class BirthdayRepository {
  static final BirthdayRepository _singleton = BirthdayRepository._internal();

  BirthdayRepository._internal() {
    birthdays.add(Birthday(birthday: DateTime(1984, 3, 9), name: 'Marcel'));
  }

  factory BirthdayRepository() {
    return _singleton;
  }

  final List<Birthday> birthdays = [];

  List<Birthday> getBirthdays() {
    return birthdays;
  }

  void insert(Birthday birthday) {
    birthdays.add(birthday);
  }

  Birthday update(Birthday birthday) {
    return birthday.copyWith(name: 'Name Update');
  }
}
