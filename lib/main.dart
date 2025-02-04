import 'package:flutter/material.dart';
import 'package:geburtstags_app/app.dart';
import 'package:geburtstags_app/repositories/birthday.repo.dart';
import 'package:geburtstags_app/screens/birthday/detail/birthday_detail.controller.dart';
import 'package:provider/provider.dart';

void main() {
  final birthdayRepo = BirthdayRepo();

  runApp(
    MultiProvider(
      providers: [
        ///neuer Provider
        ChangeNotifierProvider(create: (_) => birthdayRepo),
        ChangeNotifierProvider(create: (_) => BirthdayDetailController())
      ],
      child: const App(),
    ),
  );
}
