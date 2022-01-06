import 'package:geburtstags_app/models/birthday.dart';

class BirthdayRepo {
  static final BirthdayRepo _birthdayRepo = BirthdayRepo._internal();

  factory BirthdayRepo() {
    return _birthdayRepo;
  }

  BirthdayRepo._internal() {
    repo.add(Birthday(date: DateTime(2020, 6, 12), name: "Max"));
    repo.add(Birthday(date: DateTime(1999, 1, 11), name: "Flo"));
    repo.add(Birthday(date: DateTime(1898, 7, 5), name: "Lena"));
    repo.add(Birthday(date: DateTime(2021, 9, 12), name: "Julia"));
    repo.add(Birthday(date: DateTime(2022, 10, 12), name: "Markus"));
    repo.add(Birthday(date: DateTime(2000, 11, 12), name: "Rüdiger"));
    repo.add(Birthday(date: DateTime(1989, 12, 12), name: "Marcel"));
  }

  final List<Birthday> repo = [];

  List<Birthday> getBirthdays() {
    return repo;
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
