class DateTimeUtil {
  int remainingDaysUntilBirthday(DateTime birthday) {
    DateTime now = DateTime.now();
    DateTime nextBirthday = DateTime(now.year, birthday.month, birthday.day);
    if (nextBirthday.isBefore(now)) {
      nextBirthday = DateTime(now.year + 1, birthday.month, birthday.day);
    }

    return nextBirthday.difference(now).inDays + 1;
  }

  int getAge(DateTime birthday) {
    DateTime now = DateTime.now();
    return now.year - birthday.year;
  }
}
