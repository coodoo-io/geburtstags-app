import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:geburtstags_app/controllers/birthday.state.dart';
import 'package:geburtstags_app/models/birthday.dart';
import 'package:geburtstags_app/repositories/birthday.repo.dart';
import 'package:geburtstags_app/repositories/data_sources/local/birthday.store.dart';
import 'package:geburtstags_app/utils/birthday.util.dart';

final birthdayControllerProvider = StateNotifierProvider.autoDispose<BirthdayController, BirthdayState>((ref) {
  const initialState = BirthdayState(birthdays: [], next5Birthdays: [], todaysBirthdays: []);
  return BirthdayController(ref: ref, initialState: initialState);
});

class BirthdayController extends StateNotifier<BirthdayState> {
  BirthdayController({required this.ref, required BirthdayState initialState}) : super(initialState) {
    _init();
  }

  final StateNotifierProviderRef ref;

  // actual constructor
  Future<void> _init() async {
    final repoBirthdayList = ref.read(birthdayStoreProvider).fetchAll();
    state = state.copyWith(
        birthdays: repoBirthdayList,
        next5Birthdays: BirthdayUtil.calcNextFiveBirthdays(repoBirthdayList),
        todaysBirthdays: BirthdayUtil.calcTodaysBirthdays(repoBirthdayList));
  }

  Future<Birthday> addBirthday(Birthday birthday) async {
    await ref.read(birthdayRepoProvider).insert(birthday);
    final repoBirthdayList = await ref.read(birthdayRepoProvider).getAll();
    _updateState(repoBirthdayList);
    return birthday;
  }

  Future<void> updateBirthday(Birthday oldData, Birthday newData) async {
    await ref.read(birthdayRepoProvider).update(oldData, newData);
    final newBirthdayList = await ref.read(birthdayRepoProvider).getAll();
    _updateState(newBirthdayList);
  }

  Future<void> removeBirthday(Birthday birthday) async {
    await ref.read(birthdayRepoProvider).delete(birthday);
    final repoBirthdayList = await ref.read(birthdayRepoProvider).getAll();
    _updateState(repoBirthdayList);
  }

  void _updateState(List<Birthday> repoBirthdayList) {
    state = state.copyWith(
        birthdays: repoBirthdayList,
        next5Birthdays: BirthdayUtil.calcNextFiveBirthdays(repoBirthdayList),
        todaysBirthdays: BirthdayUtil.calcTodaysBirthdays(repoBirthdayList));
  }
}
