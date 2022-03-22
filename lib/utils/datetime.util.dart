import 'package:clock/clock.dart';

class DateTimeUtil {
  int remainingDaysUntilBirthday(DateTime birthday) {
    DateTime now = clock.now();
    DateTime nextBirthday = DateTime(now.year, birthday.month, birthday.day);
    if (nextBirthday.isBefore(now)) {
      nextBirthday = DateTime(now.year + 1, birthday.month, birthday.day);
    }
    return nextBirthday.difference(now).inDays + 1;
  }

  int getAge(DateTime birthDate) {
    DateTime currentDate = clock.now();
    int age = currentDate.year - birthDate.year;
    int currentMonth = currentDate.month;
    int birthDateMonth = birthDate.month;

    if (birthDateMonth > currentMonth) {
      age--;
    } else if (currentMonth == birthDateMonth) {
      int currentDay = currentDate.day;
      int birthDateDay = birthDate.day;
      if (birthDateDay > currentDay) {
        age--;
      }
    }
    return age;
  }

  int getNextAge(DateTime birthDate) {
    return getAge(birthDate) + 1;
  }
}
