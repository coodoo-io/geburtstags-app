import 'package:geburtstags_app/common/util/datetime.uitl.dart';
import 'package:geburtstags_app/models/birthday.model.dart';

class BirthdayRepository {
  static final BirthdayRepository _singleton = BirthdayRepository._internal();

  BirthdayRepository._internal() {
    birthdays.add(Birthday(birthday: DateTime(1984, 3, 9), name: 'Marcel 1'));
    birthdays.add(Birthday(birthday: DateTime(1994, 1, 20), name: 'Marcel 2'));
    birthdays.add(Birthday(birthday: DateTime(1924, 4, 12), name: 'Marcel 3'));
    birthdays.add(Birthday(birthday: DateTime(2011, 6, 3), name: 'Marcel 4'));
    birthdays.add(Birthday(birthday: DateTime(2000, 12, 31), name: 'Marcel 5'));
    birthdays.add(Birthday(birthday: DateTime(1900, 1, 1), name: 'Marcel 6'));
  }

  factory BirthdayRepository() {
    return _singleton;
  }

  final List<Birthday> birthdays = [];

  List<Birthday> getBirthdays() {
    return birthdays;
  }

  List<Birthday> getNextFiveBirthdays() {
    final dateTimeUtil = DateTimeUtil();
    List<Birthday> birthdaysCopy = List.from(birthdays);

    final now = DateTime.now();

    birthdaysCopy.sort((a, b) => dateTimeUtil
        .remainingDaysUntilBirthday(a.birthday, now)
        .compareTo(dateTimeUtil.remainingDaysUntilBirthday(b.birthday, now)));

    if (birthdaysCopy.length > 5) {
      return birthdaysCopy.sublist(0, 5);
    }

    return birthdaysCopy;
  }

  void insert(Birthday birthday) {
    birthdays.add(birthday);
  }

  Birthday update(Birthday oldBirthday, Birthday newBirthday) {
    birthdays.remove(oldBirthday);
    birthdays.add(newBirthday);
    return newBirthday;
  }

  void delete(Birthday birthday) {
    birthdays.remove(birthday);
  }
}
