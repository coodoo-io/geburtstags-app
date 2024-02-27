import 'package:flutter_test/flutter_test.dart';
import 'package:geburtstags_app/models/birthday.model.dart';
import 'package:geburtstags_app/repositories/birthday.repository.dart';

void main() {
  test('birthday.repository and contains one element', () async {
    final repo = BirthdayRepository();
    expect(repo.getBirthdays().length, 6);
  });

  test('birthday.repository and contains two elements after insert', () async {
    final repo = BirthdayRepository();
    expect(repo.getBirthdays().length, 6);
    repo.insert(Birthday(birthday: DateTime(1900), name: 'test'));
    expect(repo.getBirthdays().length, 7);
  });

  test('receive 5 birthdays', () {
    final repo = BirthdayRepository();
    expect(repo.getBirthdays().length, 6);
    expect(repo.getNextFiveBirthdays().length, 5);
  });
}
