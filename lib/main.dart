import 'package:flutter/material.dart';
import 'package:geburtstags_app/app.dart';
import 'package:geburtstags_app/repositories/birthday.repository.dart';
import 'package:provider/provider.dart';

void main() {
  /// Neuen Multiprovider
  runApp(
    MultiProvider(
      /// ChangeNotifierProvider
      providers: [
        ChangeNotifierProvider(create: (_) => BirthdayRepository()),
      ],
      child: const App(),
    ),
  );
}
