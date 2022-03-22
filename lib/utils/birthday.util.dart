import 'package:geburtstags_app/models/birthday.dart';
import 'package:geburtstags_app/utils/datetime.util.dart';

class BirthdayUtil {
  static List<Birthday> calcNextFiveBirthdays(List<Birthday> birthdays) {
    final dateTimeUtil = DateTimeUtil();

    List<Birthday> nextFiveBirthdays = List.from(birthdays);

    nextFiveBirthdays.sort((a, b) =>
        dateTimeUtil.remainingDaysUntilBirthday(a.date).compareTo(dateTimeUtil.remainingDaysUntilBirthday(b.date)));

    if (nextFiveBirthdays.length > 5) {
      return nextFiveBirthdays.sublist(0, 5);
    }
    return nextFiveBirthdays;
  }

  static List<Birthday> calcTodaysBirthdays(List<Birthday> birthdays) {
    List<Birthday> list = [];

    birthdays.map((birthday) {
      if (birthday.date.day == DateTime.now().day && birthday.date.month == DateTime.now().month) {
        list.add(birthday);
      }
    });

    return list;
  }
}
