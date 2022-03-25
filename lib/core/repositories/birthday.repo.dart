import 'package:geburtstags_app/core/models/birthday.model.dart';
import 'package:geburtstags_app/core/repositories/birthday_repo.interface.dart';

class BirthdayRepo implements IBirthdayRepo {
  BirthdayRepo();

  late List<Birthday> _inMemoryBirthdayList = read(birthdayStoreProvider).fetchAll(); // Quick access without shared_preferences

  @override
  Future<List<Birthday>> getAll() async {
    return _inMemoryBirthdayList;
  }

  @override
  Future<Birthday> insert(Birthday birthday) async {
    final newBirthdayList = [..._inMemoryBirthdayList, birthday];

    // Write to Store
    read(birthdayStoreProvider).persist(birthdays: newBirthdayList);
    _inMemoryBirthdayList = newBirthdayList;
    return birthday;
  }

  @override
  Future<void> update(Birthday oldData, Birthday newData) async {
    delete(oldData);
    insert(newData);

    // Write to Store
    read(birthdayStoreProvider).persist(birthdays: _inMemoryBirthdayList);
  }

  @override
  Future<void> delete(Birthday birthday) async {
    final newBirthdayList = [
      for (final b in _inMemoryBirthdayList)
        if (b.name != birthday.name && b.date != birthday.date) b,
    ];

    // Write to Store
    read(birthdayStoreProvider).persist(birthdays: newBirthdayList);
    _inMemoryBirthdayList=newBirthdayList;
  }
}
