import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:geburtstags_app/app.dart';
import 'package:shared_preferences/shared_preferences.dart';

/// Providers are declared globally and specify how to create a state.
/// They can be easily overridden at start or in tests.
final sharedPrefs = Provider<SharedPreferences>((ref) {
  throw UnimplementedError();
});

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final sharedPreferences = await SharedPreferences.getInstance();

  // Adding ProviderScope enables Riverpod for the entire project
  runApp(ProviderScope(
    overrides: [
      sharedPrefs.overrideWithValue(sharedPreferences),
    ],
    child: const App(),
  ));
}
