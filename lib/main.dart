import 'package:flutter/material.dart';
import 'package:geburtstags_app/app.dart';
import 'package:geburtstags_app/repositories/birthday.repo.dart';
import 'package:geburtstags_app/themes/themes.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => BirthdayRepo()),
        ChangeNotifierProvider(create: (_) => ThemeNotifier()),
      ],
      child: const App(),
    ),
  );
}
