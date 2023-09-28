import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:geburtstags_app/app.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:shared_preferences/shared_preferences.dart';

part 'main.g.dart';

/// Providers are declared globally and specify how to create a state.
/// They can be easily overridden at start or in tests.
@riverpod
SharedPreferences sharedPrefs(SharedPrefsRef ref) {
  throw UnimplementedError();
}

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final sharedPreferences = await SharedPreferences.getInstance();

  runApp(ProviderScope(
    overrides: [
      sharedPrefsProvider.overrideWith((ref) => sharedPreferences),
    ],
    child: const App(),
  ));
}
