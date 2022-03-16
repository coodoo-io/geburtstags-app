import 'package:flutter_test/flutter_test.dart';
import 'package:geburtstags_app/utils/datetime.util.dart';

void main() {
  test('get age', () {
    final DateTimeUtil dateTimeUtil = DateTimeUtil();
    expect(dateTimeUtil.getAge(DateTime(2003, 5, 7)), equals(18));
    expect(dateTimeUtil.getAge(DateTime(2006, 4, 30)), equals(15));
  });

  test('remaining days until birthday', () {
    final DateTimeUtil dateTimeUtil = DateTimeUtil();
    final DateTime now = DateTime.now();

    expect(dateTimeUtil.remainingDaysUntilBirthday(now), equals(365));
    expect(dateTimeUtil.remainingDaysUntilBirthday(DateTime(now.year + 1, now.month, now.day)), equals(365));
  });
}
