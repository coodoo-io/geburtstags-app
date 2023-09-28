import 'package:geburtstags_app/controllers/birthday.state.dart';
import 'package:geburtstags_app/models/birthday.dart';
import 'package:geburtstags_app/repositories/birthday.repository.dart';
import 'package:geburtstags_app/utils/birthday.util.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'birthday.controller.g.dart';

/// Hält den View-State des birthday screen
@riverpod
class BirthdayController extends _$BirthdayController {
  @override
  BirthdayState build() {
    init();
    return BirthdayState(
      birthdays: List.empty(),
      next5Birthdays: List.empty(),
      todaysBirthdays: List.empty(),
    );
  }

  Future<void> init() async {
    final repoBirthdayList = await ref.read(birthdayRepositoryProvider).getAll();
    _updateState(repoBirthdayList);
  }

  Future<Birthday> addBirthday(Birthday birthday) async {
    await ref.read(birthdayRepositoryProvider).insert(birthday);
    final repoBirthdayList = await ref.read(birthdayRepositoryProvider).getAll();
    _updateState(repoBirthdayList);
    return birthday;
  }

  Future<void> updateBirthday(Birthday oldData, Birthday newData) async {
    await ref.read(birthdayRepositoryProvider).update(oldData, newData);
    final newBirthdayList = await ref.read(birthdayRepositoryProvider).getAll();
    _updateState(newBirthdayList);
  }

  Future<void> removeBirthday(Birthday birthday) async {
    await ref.read(birthdayRepositoryProvider).delete(birthday);
    final repoBirthdayList = await ref.read(birthdayRepositoryProvider).getAll();
    _updateState(repoBirthdayList);
  }

  void _updateState(List<Birthday> repoBirthdayList) {
    state = state.copyWith(
        birthdays: repoBirthdayList,
        next5Birthdays: BirthdayUtil.calcNextFiveBirthdays(repoBirthdayList),
        todaysBirthdays: BirthdayUtil.calcTodaysBirthdays(repoBirthdayList));
  }
}
