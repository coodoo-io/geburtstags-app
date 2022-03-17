import 'package:flutter/material.dart';

ThemeData light = ThemeData(
  brightness: Brightness.light,
  primarySwatch: Colors.blue,
);
ThemeData dark = ThemeData(
  brightness: Brightness.dark,
  primarySwatch: Colors.blueGrey,
);

class ThemeNotifier extends ChangeNotifier {
  final String key = "theme";
  bool _isDarkTheme = false;

  bool get isDarkTheme => _isDarkTheme;

  toggleTheme() {
    _isDarkTheme = !_isDarkTheme;
    notifyListeners();
  }
}
