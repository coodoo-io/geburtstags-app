import 'package:clock/clock.dart';
import 'package:test/test.dart';
import 'package:geburtstags_app/utils/datetime.util.dart';

void main() {
  group('DateTimeUtil', () {
    late DateTimeUtil classUnderTest;

    setUp(() {
      classUnderTest = DateTimeUtil();
    });

    test('getAge should return correct value', () {
      withClock(Clock.fixed(DateTime(2022, 3, 17)), () {
        int result = classUnderTest.getAge(DateTime(2011, 2, 24));
        expect(result, 11);
      });
    });

    test('remainingDaysUntilBirthday should return the correct time to elapse', () {
      withClock(Clock.fixed(DateTime(2022, 3, 17)), () {
        int result = classUnderTest.remainingDaysUntilBirthday(DateTime(2011, 2, 24));
        expect(result, 345);
      });
    });

    test('getNextAge should return the correct next age', () {
      withClock(Clock.fixed(DateTime(2022, 3, 17)), () {
        int result = classUnderTest.getNextAge(DateTime(2011, 2, 24));
        expect(result, 12);
      });
    });
  });
}
