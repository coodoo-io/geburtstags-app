import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

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

  ThemeNotifier() {
    loadFromPrefs();
  }

  toggleTheme() {
    _isDarkTheme = !_isDarkTheme;
    saveToPrefs();
    notifyListeners();
  }

  loadFromPrefs() async {
    final prefs = await SharedPreferences.getInstance();
    _isDarkTheme = prefs.getBool(key) ?? false;
    notifyListeners();
  }

  saveToPrefs() async {
    final prefs = await SharedPreferences.getInstance();
    prefs.setBool(key, isDarkTheme);
  }
}
