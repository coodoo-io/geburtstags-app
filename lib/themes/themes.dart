import 'dart:io';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

ThemeData light = BirthdayTheme.getTheme(isDark: false);
ThemeData dark = BirthdayTheme.getTheme(isDark: true);

class BirthdayTheme {
  static ThemeData getTheme({isDark = true}) {
    const color = Colors.blue;
    final _theme = isDark ? ThemeData.dark() : ThemeData.dark();
    return ThemeData(
      brightness: isDark ? Brightness.dark : Brightness.light,
      primarySwatch: color,
      primaryColor: color,
      splashColor: Platform.isAndroid ? _theme.splashColor : Colors.transparent,
      highlightColor: Platform.isAndroid ? _theme.highlightColor : Colors.transparent,
      fontFamily: GoogleFonts.openSans().fontFamily,
      primaryTextTheme: _theme.textTheme.apply(fontFamily: GoogleFonts.openSans().fontFamily),
      bottomNavigationBarTheme: _theme.bottomNavigationBarTheme.copyWith(selectedItemColor: color),
      floatingActionButtonTheme: _theme.floatingActionButtonTheme.copyWith(backgroundColor: color),
    );
  }
}

class ThemeNotifier extends ChangeNotifier {
  final String key = "theme";

  bool _isDarkTheme = false;

  bool get isDarkTheme => _isDarkTheme;

  ThemeMode get current => _isDarkTheme ? ThemeMode.dark : ThemeMode.light;

  toggleTheme() {
    _isDarkTheme = !_isDarkTheme;
    notifyListeners();
  }
}
