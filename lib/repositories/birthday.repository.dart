import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:geburtstags_app/models/birthday.dart';
import 'package:geburtstags_app/repositories/data_sources/local/birthday.store.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'birthday.repository.g.dart';

/// Repository ist eine normale Dart-Klasse auf die über ein Provider zugegriffen wird.
class BirthdayRepository {
  BirthdayRepository({required this.ref});

  final ProviderRef ref;
  late List<Birthday> _inMemoryBirthdayList =
      ref.read(birthdayStoreProvider).fetchAll(); // Quick access without shared_preferences

  Future<List<Birthday>> getAll() async {
    return _inMemoryBirthdayList;
  }

  Future<Birthday> insert(Birthday birthday) async {
    final newBirthdayList = [..._inMemoryBirthdayList, birthday];

    // Write to Store
    ref.read(birthdayStoreProvider).persist(birthdays: newBirthdayList);
    _inMemoryBirthdayList = newBirthdayList;
    return birthday;
  }

  Future<void> update(Birthday oldData, Birthday newData) async {
    delete(oldData);
    insert(newData);

    // Write to Store
    ref.read(birthdayStoreProvider).persist(birthdays: _inMemoryBirthdayList);
  }

  Future<void> delete(Birthday birthday) async {
    final newBirthdayList = [
      for (final b in _inMemoryBirthdayList)
        if (b.name != birthday.name && b.date != birthday.date) b,
    ];

    // Write to Store
    ref.read(birthdayStoreProvider).persist(birthdays: newBirthdayList);
    _inMemoryBirthdayList = newBirthdayList;
  }
}

@riverpod
FutureOr<BirthdayRepository> birthdayRepository(BirthdayRepositoryRef ref) {
  return BirthdayRepository(ref: ref);
}

/// Provider für Dependency Injection
final birthdayRepoProvider = Provider<BirthdayRepository>((ref) {
  return BirthdayRepository(ref: ref);
});
