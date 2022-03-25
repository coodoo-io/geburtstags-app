import 'package:flutter/material.dart';
import 'package:geburtstags_app/core/models/birthday.model.dart';
import 'package:geburtstags_app/templates/template.dart';
import 'package:geburtstags_app/ui/screens/birthday_detail.screen.dart';
import 'package:geburtstags_app/ui/screens/birthdays.screen.dart';
import 'package:geburtstags_app/ui/screens/dashboard.screen.dart';
import 'package:geburtstags_app/ui/screens/settings.screen.dart';

/// Example for Routing
class AppRouter {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case '/':
        return MaterialPageRoute(builder: (_) => const Template());
      case '/birthdays/detail':
        final birthday = settings.arguments as Birthday;
        return MaterialPageRoute(builder: (_) => BirthdayDetailScreen(birthday: birthday));
      default:
        return MaterialPageRoute(
          builder: (_) => Scaffold(
            body: Center(
              child: Text('No route defined for ${settings.name}.'),
            ),
          ),
        );
    }
  }
}