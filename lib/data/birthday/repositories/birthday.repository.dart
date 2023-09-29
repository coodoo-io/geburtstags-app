import 'package:geburtstags_app/common/shared_preferences/shared_preferences.dart';
import 'package:geburtstags_app/data/birthday/repositories/data_sources/local/birthday.store.dart';
import 'package:geburtstags_app/domain/birthday/model/birthday.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'birthday.repository.g.dart';

/// Repository ist eine normale Dart-Klasse auf die über ein Provider zugegriffen wird.
class BirthdayRepository {
  BirthdayRepository({required this.birthdayStore});

  final BirthdayStore birthdayStore;
  late List<Birthday> _inMemoryBirthdayList = birthdayStore.fetchAll();

  Future<List<Birthday>> getAll() async {
    // throw Exception('g');
    await Future.delayed(const Duration(seconds: 5));
    return Future.value(_inMemoryBirthdayList);
  }

  Future<Birthday> insert(Birthday birthday) async {
    final newBirthdayList = [..._inMemoryBirthdayList, birthday];

    // Write to local store
    birthdayStore.persist(birthdays: newBirthdayList);
    _inMemoryBirthdayList = newBirthdayList;
    return birthday;
  }

  Future<void> update(Birthday birthday) async {
    for (var i = 0; i < _inMemoryBirthdayList.length; i++) {
      var bday = _inMemoryBirthdayList[i];
      if (bday.id == birthday.id) {
        _inMemoryBirthdayList[i] = birthday;
        break;
      }
    }

    // Write to Store
    birthdayStore.persist(birthdays: _inMemoryBirthdayList);
  }

  Future<void> delete(Birthday birthday) async {
    final newBirthdayList = [
      for (final b in _inMemoryBirthdayList)
        if (b.name != birthday.name && b.date != birthday.date) b,
    ];

    // Write to Store
    birthdayStore.persist(birthdays: newBirthdayList);
    _inMemoryBirthdayList = newBirthdayList;
  }
}

/// Es soll durchgängig nur eine Repository Instanz gehalten werden um die Zugriffe
/// auf die Shared Preferences zu minimieren.
@Riverpod(keepAlive: true)
BirthdayRepository birthdayRepository(BirthdayRepositoryRef ref) {
  final sharedPreferences = ref.read(sharedPrefsProvider);
  final birthdayStore = BirthdayStore(sharedPreferences: sharedPreferences);
  return BirthdayRepository(birthdayStore: birthdayStore);
}
