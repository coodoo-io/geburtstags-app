import 'package:geburtstags_app/models/birthday.dart';
import 'package:geburtstags_app/utils/datetime.util.dart';

class BirthdayRepo {
  static final BirthdayRepo _birthdayRepo = BirthdayRepo._internal();

  factory BirthdayRepo() {
    return _birthdayRepo;
  }

  BirthdayRepo._internal() {
    _birthdays.add(Birthday(date: DateTime(2020, 6, 12), name: "Max"));
    _birthdays.add(Birthday(date: DateTime(1999, 3, 15), name: "Flo"));
    _birthdays.add(Birthday(date: DateTime(1898, 7, 5), name: "Lena"));
    _birthdays.add(Birthday(date: DateTime(2021, 9, 12), name: "Julia"));
    _birthdays.add(Birthday(date: DateTime(2022, 10, 12), name: "Markus"));
    _birthdays.add(Birthday(date: DateTime(2000, 11, 12), name: "Rüdiger"));
    _birthdays.add(Birthday(date: DateTime(1989, 12, 12), name: "Marcel"));
    _birthdays.add(Birthday(date: DateTime.now(), name: "Meier"));
  }

  final List<Birthday> _birthdays = [];

  List<Birthday> getBirthdays() {
    return _birthdays;
  }

  List<Birthday> getNextFiveBirthdays() {
    final dateTimeUtil = DateTimeUtil();
    List<Birthday> nextFiveBirthdays = _birthdays;

    nextFiveBirthdays.sort((a, b) =>
        dateTimeUtil.remainingDaysUntilBirthday(a.date).compareTo(dateTimeUtil.remainingDaysUntilBirthday(b.date)));

    if (nextFiveBirthdays.length > 5) {
      return nextFiveBirthdays.sublist(0, 5);
    }
    return nextFiveBirthdays;
  }

  List<Birthday> getTodaysBirthdays() {
    List<Birthday> list = [];

    for (var i = 0; i < _birthdays.length; i++) {
      if (_birthdays[i].date.day == DateTime.now().day && _birthdays[i].date.month == DateTime.now().month) {
        list.add(_birthdays[i]);
      }
    }

    return list;
  }

  Birthday insert(Birthday birthday) {
    _birthdays.add(birthday);
    return birthday;
  }

  void update({required Birthday oldBirthday, required Birthday newBirthday}) {
    _birthdays.remove(oldBirthday);
    _birthdays.add(newBirthday);
  }

  void delete(Birthday birthday) {
    _birthdays.remove(birthday);
  }
}
