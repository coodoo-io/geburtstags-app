import 'dart:io';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

ThemeData light = BirthdayTheme.getTheme(isDark: false);
ThemeData dark = BirthdayTheme.getTheme(isDark: true);

class BirthdayTheme {
  static ThemeData getTheme({isDark = true}) {
    const color = Colors.blue;
    final theme = isDark ? ThemeData.dark() : ThemeData.dark();
    return ThemeData(
      brightness: isDark ? Brightness.dark : Brightness.light,
      primarySwatch: color,
      primaryColor: color,
      splashColor: Platform.isAndroid ? theme.splashColor : Colors.transparent,
      highlightColor: Platform.isAndroid ? theme.highlightColor : Colors.transparent,
      fontFamily: GoogleFonts.openSans().fontFamily,
      primaryTextTheme: theme.textTheme.apply(fontFamily: GoogleFonts.openSans().fontFamily),
      bottomNavigationBarTheme: theme.bottomNavigationBarTheme.copyWith(selectedItemColor: color),
      floatingActionButtonTheme: theme.floatingActionButtonTheme.copyWith(backgroundColor: color),
      snackBarTheme: theme.snackBarTheme.copyWith(
        backgroundColor: color.shade500,
        elevation: 0,
        contentTextStyle: GoogleFonts.openSans(fontSize: 15),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(24),
        ),
      ),
      inputDecorationTheme: theme.inputDecorationTheme.copyWith(
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(15),
        ),
      ),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          textStyle: GoogleFonts.openSans(fontSize: 20),
        ),
      ),
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
