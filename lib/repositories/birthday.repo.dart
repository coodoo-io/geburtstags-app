import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:geburtstags_app/models/birthday.dart';
import 'package:geburtstags_app/repositories/birthday.state.dart';
import 'package:geburtstags_app/repositories/data_sources/local/birthday.store.dart';
import 'package:geburtstags_app/utils/datetime.util.dart';

final birthdayRepoProvider = StateNotifierProvider<BirthdayRepo, BirthdayState>((ref) {
  const initialState = BirthdayState(birthdays: [], next5Birthdays: [], todaysBirthdays: []);
  return BirthdayRepo(read: ref.read, initialState: initialState);
});

class BirthdayRepo extends StateNotifier<BirthdayState> {
  BirthdayRepo({required this.read, required BirthdayState initialState}) : super(initialState) {
    loadBirthdays();
  }

  final Reader read;

  List<Birthday> _calcNextFiveBirthdays(List<Birthday> birthdays) {
    final dateTimeUtil = DateTimeUtil();

    List<Birthday> nextFiveBirthdays = List.from(birthdays);

    nextFiveBirthdays.sort((a, b) =>
        dateTimeUtil.remainingDaysUntilBirthday(a.date).compareTo(dateTimeUtil.remainingDaysUntilBirthday(b.date)));

    if (nextFiveBirthdays.length > 5) {
      return nextFiveBirthdays.sublist(0, 5);
    }
    return nextFiveBirthdays;
  }

  List<Birthday> _calcTodaysBirthdays(List<Birthday> birthdays) {
    List<Birthday> list = [];

    birthdays.map((birthday) {
      if (birthday.date.day == DateTime.now().day && birthday.date.month == DateTime.now().month) {
        list.add(birthday);
      }
    });

    return list;
  }

  Future<Birthday> insert(Birthday birthday) async {
    final newBirthdayList = [...state.birthdays, birthday];

    // Update State
    state = state.copyWith(birthdays: newBirthdayList,next5Birthdays: _calcNextFiveBirthdays(newBirthdayList),
        todaysBirthdays: _calcTodaysBirthdays(newBirthdayList));
    
    // Write to Store
    await read(birthdayStoreProvider).persist(birthdays: state.birthdays);
    
    return birthday;
  }

  Future<void> update(Birthday oldData, Birthday newData) async {
    delete(oldData);
    insert(newData);
    
    // Write to Store
    await read(birthdayStoreProvider).persist(birthdays: state.birthdays);
  }

  Future<void> delete(Birthday birthday) async {
    final newBirthdayList = [
      for (final b in state.birthdays)
        if (b != birthday) b,
    ];

    state = state.copyWith(birthdays: newBirthdayList, next5Birthdays: _calcNextFiveBirthdays(newBirthdayList), todaysBirthdays: _calcTodaysBirthdays(newBirthdayList));
    
    // Write to Store
    await read(birthdayStoreProvider).persist(birthdays: state.birthdays);
  }


  Future<void> loadBirthdays() async {
    final birthdayList = await read(birthdayStoreProvider).fetchAll();
    state = state.copyWith(
        birthdays: birthdayList,
        next5Birthdays: _calcNextFiveBirthdays(birthdayList),
        todaysBirthdays: _calcTodaysBirthdays(birthdayList));
  }
}
