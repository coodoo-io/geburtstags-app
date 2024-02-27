import 'package:flutter_test/flutter_test.dart';
import 'package:geburtstags_app/common/util/datetime.uitl.dart';

void main() {
  group('DateTimeUtil ', () {
    final DateTimeUtil classUnderTest = DateTimeUtil();
    group('remainingDaysUntilBirthday', () {
      test('soll 12 sein', () async {
        final result = classUnderTest.remainingDaysUntilBirthday(
          DateTime(1984, 3, 9),
          DateTime(2024, 2, 27),
        );
        expect(result, 12);
      });
    });
    group('getAge', () {
      test('soll 39 sein', () async {
        final result = classUnderTest.getAge(
          DateTime(1984, 3, 9),
          DateTime(2024, 2, 27),
        );
        expect(result, 39);
      });
    });
  });
}
