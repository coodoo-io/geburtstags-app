import 'package:flutter/material.dart';
import 'package:geburtstags_app/app.dart';
import 'package:geburtstags_app/locator.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  setupLocator();

  runApp(const App());
}
