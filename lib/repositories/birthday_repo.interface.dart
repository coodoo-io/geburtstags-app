import 'package:geburtstags_app/models/birthday.dart';

abstract class BirthdayRepo {
  const BirthdayRepo();

  Future<List<Birthday>> getAll();
  Future<Birthday> insert(Birthday birthday);
  Future<void> update(Birthday oldData, Birthday newData);
  Future<void> delete(Birthday birthday);
}
