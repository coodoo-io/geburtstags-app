import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:geburtstags_app/models/birthday.dart';
import 'package:geburtstags_app/repositories/birthday.state.dart';
import 'package:geburtstags_app/repositories/birthday_repo.interface.dart';
import 'package:geburtstags_app/repositories/data_sources/local/birthday.store.dart';
import 'package:geburtstags_app/utils/birthday.util.dart';

final birthdayRepoProvider = StateNotifierProvider<BirthdayRepo, BirthdayState>((ref) {
  const initialState = BirthdayState(birthdays: [], next5Birthdays: [], todaysBirthdays: []);
  return SharedPrefsBirthdayRepo(read: ref.read, initialState: initialState);
});

class SharedPrefsBirthdayRepo extends StateNotifier<BirthdayState> implements BirthdayRepo {
  SharedPrefsBirthdayRepo({required this.read, required BirthdayState initialState}) : super(initialState) {
    _init();
  }

  final Reader read;

  // actual constructor
  Future<void> _init() async {
    final birthdayList = await read(birthdayStoreProvider).fetchAll();
    state = state.copyWith(
        birthdays: birthdayList,
        next5Birthdays: BirthdayUtil.calcNextFiveBirthdays(birthdayList),
        todaysBirthdays: BirthdayUtil.calcTodaysBirthdays(birthdayList));
  }

  @override
  Future<Birthday> insert(Birthday birthday) async {
    final newBirthdayList = [...state.birthdays, birthday];

    // Update State
    state = state.copyWith(
        birthdays: newBirthdayList,
        next5Birthdays: BirthdayUtil.calcNextFiveBirthdays(newBirthdayList),
        todaysBirthdays: BirthdayUtil.calcTodaysBirthdays(newBirthdayList));

    // Write to Store
    await read(birthdayStoreProvider).persist(birthdays: state.birthdays);

    return birthday;
  }

  @override
  Future<void> update(Birthday oldData, Birthday newData) async {
    // Update State
    delete(oldData);
    insert(newData);

    // Write to Store
    await read(birthdayStoreProvider).persist(birthdays: state.birthdays);
  }

  @override
  Future<void> delete(Birthday birthday) async {
    // Update State
    final newBirthdayList = [
      for (final b in state.birthdays)
        if (b != birthday) b,
    ];

    state = state.copyWith(
        birthdays: newBirthdayList,
        next5Birthdays: BirthdayUtil.calcNextFiveBirthdays(newBirthdayList),
        todaysBirthdays: BirthdayUtil.calcTodaysBirthdays(newBirthdayList));

    // Write to Store
    await read(birthdayStoreProvider).persist(birthdays: state.birthdays);
  }
}
