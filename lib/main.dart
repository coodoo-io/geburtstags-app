import 'package:flutter/material.dart';
import 'package:geburtstags_app/app.dart';
import 'package:geburtstags_app/repositories/birthday.repo.dart';
import 'package:logger/logger.dart';
import 'package:provider/provider.dart';

var logger = Logger(
  printer: PrettyPrinter(),
);
void main() {
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => BirthdayRepo()),
      ],
      child: const App(),
    ),
  );
}
