import 'package:geburtstags_app/common/utils/datetime.util.dart';
import 'package:geburtstags_app/data/birthday/repositories/birthday.repository.dart';
import 'package:geburtstags_app/domain/birthday/model/birthday.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'birthday.service.g.dart';

/// Lädt alle gespeicherten Geburtstage
///
/// Um einen schnelleren Zugriff auf alle Geburtstage zu erhalten soll der Provider
/// als globale Instanz gehalten werden.
@Riverpod(keepAlive: true)
FutureOr<List<Birthday>> getAllBirthdaysService(GetAllBirthdaysServiceRef ref) async {
  final birthdays = await ref.read(birthdayRepositoryProvider).getAll();

  List<Birthday> updatedBirthdays = List.empty(growable: true);

  var dateTimeUtil = DateTimeUtil();
  for (var birthday in birthdays) {
    final days = dateTimeUtil.remainingDaysUntilBirthday(birthday.date);
    final b = Birthday(
      id: birthday.id,
      name: birthday.name,
      date: birthday.date,
      daysUntilBirthday: days,
    );

    updatedBirthdays.add(b);
  }

  return updatedBirthdays;
}

@riverpod
class GetNextBirthdaysService extends _$GetNextBirthdaysService {
  @override
  Future<List<Birthday>> build({required int max}) async {
    List<Birthday> birthdays = await ref.read(getAllBirthdaysServiceProvider.future);
    List<Birthday> nextFiveBirthdays = List.from(birthdays);

    nextFiveBirthdays.sort((a, b) => a.daysUntilBirthday!.compareTo(b.daysUntilBirthday!));

    if (nextFiveBirthdays.length > max) {
      return nextFiveBirthdays.sublist(0, max);
    }
    return nextFiveBirthdays;
  }
}

@riverpod
FutureOr<List<Birthday>> getTodaysBirthdaysService(
  GetTodaysBirthdaysServiceRef ref,
) async {
  List<Birthday> birthdays = await ref.read(getAllBirthdaysServiceProvider.future);
  List<Birthday> todayBirthdays = [];

  birthdays.map((birthday) {
    if (birthday.date.day == DateTime.now().day && birthday.date.month == DateTime.now().month) {
      todayBirthdays.add(birthday);
    }
  });

  return todayBirthdays;
}

@riverpod
FutureOr<Birthday> addBirthdayService(
  AddBirthdayServiceRef ref, {
  required Birthday birthday,
}) async {
  final createdBirthday = await ref.read(birthdayRepositoryProvider).insert(birthday);
  ref.invalidate(getAllBirthdaysServiceProvider);
  ref.invalidate(getNextBirthdaysServiceProvider);

  return createdBirthday;
}

@riverpod
FutureOr<void> updateBirthdayService(
  UpdateBirthdayServiceRef ref, {
  required Birthday birthday,
}) async {
  await ref.read(birthdayRepositoryProvider).update(birthday);
  ref.invalidate(getAllBirthdaysServiceProvider);
  ref.invalidate(getNextBirthdaysServiceProvider);
}

@riverpod
FutureOr<void> removeBirthdayService(
  RemoveBirthdayServiceRef ref, {
  required Birthday birthday,
}) async {
  await ref.read(birthdayRepositoryProvider).delete(birthday);
  ref.invalidate(getAllBirthdaysServiceProvider);
  ref.invalidate(getNextBirthdaysServiceProvider);
}
