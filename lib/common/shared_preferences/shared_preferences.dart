import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:shared_preferences/shared_preferences.dart';

part 'shared_preferences.g.dart';

/// Shared Preferences als Provider zur Verfügung stellen
///
/// Die Shared Preferences werden in der bootstrap() initialisiert.
/// Dieser Provider wird anschließend mit den erstelltn SharedPreferences
/// überschrieben.
@riverpod
SharedPreferences sharedPrefs(SharedPrefsRef ref) {
  throw UnimplementedError();
}
