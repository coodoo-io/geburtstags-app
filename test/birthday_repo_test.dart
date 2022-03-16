import 'package:flutter_test/flutter_test.dart';
import 'package:geburtstags_app/models/birthday.dart';
import 'package:geburtstags_app/repositories/birthday.repo.dart';
import 'package:geburtstags_app/utils/datetime.util.dart';

void main() {
  final BirthdayRepo birthdayRepo = BirthdayRepo();

  setUp(() {
    birthdayRepo.insert(
      Birthday(
        name: 'Nico',
        date: DateTime(1998, 6, 12),
      ),
    );
    birthdayRepo.insert(
      Birthday(
        name: 'Flo',
        date: DateTime(2003, 5, 7),
      ),
    );
    birthdayRepo.insert(
      Birthday(
        name: 'Lena',
        date: DateTime(2001, 8, 12),
      ),
    );
    birthdayRepo.insert(
      Birthday(
        name: 'Lukas',
        date: DateTime(2000, 10, 12),
      ),
    );
  });

  test('birthday list is not empty', () {
    expect(birthdayRepo.birthdays.length, equals(4));
  });

  test('birthday list contains Lena', () {
    expect(
      birthdayRepo.birthdays.any((birthday) => birthday.name == 'Lena'),
      isTrue,
    );
  });

  test("Get next 5 Birthdays", () {
    final DateTimeUtil dateTimeUtil = DateTimeUtil();
    List<Birthday> nextFiveBirthdays = birthdayRepo.getNextFiveBirthdays();

    expect(
      nextFiveBirthdays.length > 5,
      false,
    );

    for (var i = 0; i < nextFiveBirthdays.length - 1; i++) {
      expect(
          dateTimeUtil.remainingDaysUntilBirthday(nextFiveBirthdays[i].date) <=
              dateTimeUtil.remainingDaysUntilBirthday(nextFiveBirthdays[i + 1].date),
          true);
    }
  });

  test("Get todays Birthdays", () {
    final List<Birthday> todaysBirthdays = birthdayRepo.getTodaysBirthdays();
    for (var i = 0; i < todaysBirthdays.length; i++) {
      expect(
        todaysBirthdays[i].date.day,
        equals(DateTime.now().day),
      );
      expect(
        todaysBirthdays[i].date.month,
        equals(DateTime.now().month),
      );
    }
  });
}
