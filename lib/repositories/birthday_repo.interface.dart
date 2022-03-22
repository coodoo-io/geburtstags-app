import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:geburtstags_app/models/birthday.dart';
import 'package:geburtstags_app/repositories/birthday.state.dart';

abstract class BirthdayRepo extends StateNotifier<BirthdayState> {
  BirthdayRepo(BirthdayState state) : super(state);

  Future<Birthday> insert(Birthday birthday);
  Future<void> update(Birthday oldData, Birthday newData);
  Future<void> delete(Birthday birthday);
}
