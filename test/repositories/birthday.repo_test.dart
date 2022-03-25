import 'package:clock/clock.dart';
import 'package:geburtstags_app/models/birthday.dart';
import 'package:test/test.dart';
import 'package:geburtstags_app/repositories/birthday.repo.dart';

void main() {
  group('BirthdayRepo', () {
    late BirthdayRepo repo;

    setUp(() {
      repo = BirthdayRepo();
    });

    tearDown(() {
      repo.reset();
    });

    test("Testing Repo has elements", () async {
      expect((await repo.birthdays).length, 7);
    });

    test("Testing Repo has more elemnts after adding", () async {
      repo.insert(Birthday(name: "Test", date: DateTime(2000, 1, 1)));
      expect((await repo.birthdays).length, 8);
    });

    test("getNextFiveBirthdays with filles list", () {
      withClock(Clock.fixed(DateTime(2022, 1, 1)), () {
        List<Birthday> result = repo.getNextFiveBirthdays();
        expect(result.length, 5);
      });
    });

    test("getNextFiveBirthdays with empty list", () async {
      withClock(Clock.fixed(DateTime(2022, 1, 1)), () async {
        List<Birthday> birthdays = [...(await repo.birthdays)];
        for (Birthday birthday in birthdays) {
          repo.delete(birthday);
        }

        List<Birthday> result = repo.getNextFiveBirthdays();
        expect(result.length, 0);
      });
    });

    test("getNextFiveBirthdays with two entries in list", () {
      withClock(Clock.fixed(DateTime(2022, 1, 1)), () async {
        List<Birthday> birthdays = [...(await repo.birthdays)];
        for (Birthday birthday in birthdays) {
          repo.delete(birthday);
        }

        repo.insert(Birthday(name: "Bar", date: DateTime(2000, 12, 24)));
        repo.insert(Birthday(name: "Foo", date: DateTime(2000, 2, 2)));

        List<Birthday> result = repo.getNextFiveBirthdays();
        expect(result.length, 2);

        expect(result.elementAt(0).name, "Foo");
        expect(result.elementAt(1).name, "Bar");
      });
    });

    test("update birthday, remove from index and push to end", () async {
      List<Birthday> list = (await repo.birthdays);
      Birthday old = list.elementAt(1);

      Birthday current = Birthday(name: "New Name", date: old.date);

      repo.update(oldBirthday: old, newBirthday: current);

      list = (await repo.birthdays);

      expect(list.elementAt(6).name, current.name);
    });
  });
}
