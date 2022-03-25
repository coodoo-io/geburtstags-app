import 'package:geburtstags_app/core/models/birthday.model.dart';

abstract class IBirthdayRepo {
  Future<List<Birthday>> getAll();
  Future<Birthday> insert(Birthday birthday);
  Future<void> update(Birthday oldData, Birthday newData);
  Future<void> delete(Birthday birthday);
}
