import 'package:geburtstags_app/models/birthday.dart';
import 'package:geburtstags_app/util/datetime.util.dart';

class BirthdayRepo {
  static final BirthdayRepo _birthdayRepo = BirthdayRepo._internal();

  factory BirthdayRepo() {
    return _birthdayRepo;
  }

  BirthdayRepo._internal() {
    repo.add(Birthday(date: DateTime(2020, 6, 12), name: "Max"));
    repo.add(Birthday(date: DateTime(1999, 3, 15), name: "Flo"));
    repo.add(Birthday(date: DateTime(1898, 7, 5), name: "Lena"));
    repo.add(Birthday(date: DateTime(2021, 9, 12), name: "Julia"));
    repo.add(Birthday(date: DateTime(2022, 10, 12), name: "Markus"));
    repo.add(Birthday(date: DateTime(2000, 11, 12), name: "Rüdiger"));
    repo.add(Birthday(date: DateTime(1989, 12, 12), name: "Marcel"));
    repo.add(Birthday(date: DateTime.now(), name: "Meier"));
  }

  final List<Birthday> repo = [];

  List<Birthday> getBirthdays() {
    return repo;
  }

  List<Birthday> getNextFiveBirthdays() {
    final dateTimeUtil = DateTimeUtil();
    List<Birthday> nextFiveBirthdays = repo;

    nextFiveBirthdays.sort((a, b) =>
        dateTimeUtil.remainingDaysUntilBirthday(a.date).compareTo(dateTimeUtil.remainingDaysUntilBirthday(b.date)));

    return nextFiveBirthdays.sublist(0, 5);
  }

  List<Birthday> getTodaysBirthdays() {
    List<Birthday> list = [];

    for (var i = 0; i < repo.length; i++) {
      if (repo[i].date.day == DateTime.now().day && repo[i].date.month == DateTime.now().month) list.add(repo[i]);
    }

    return list;
  }

  Birthday insert(Birthday birthday) {
    repo.add(birthday);
    return birthday;
  }

  Birthday update(Birthday birthday) {
    throw UnimplementedError();
  }

  void delete(Birthday birthday) {
    repo.remove(birthday);
  }
}
