import 'package:flutter/material.dart';
import 'package:geburtstags_app/core/models/birthday.model.dart';
import 'package:geburtstags_app/ui/views/birthday_detail.view.dart';
import 'package:geburtstags_app/ui/views/birthdays.view.dart';
import 'package:geburtstags_app/ui/views/dashboard.view.dart';
import 'package:geburtstags_app/ui/views/settings.view.dart';

/// Example for Routing
class Router {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case '/':
        return MaterialPageRoute(builder: (_) => const DashboardView());
      case '/birthdays':
        return MaterialPageRoute(builder: (_) => const BirthdaysView());
      case '/birthdays/detail':
        final birthday = settings.arguments as Birthday;
        return MaterialPageRoute(builder: (_) => BirthdayDetailView(birthday: birthday));
      case '/settings':
        return MaterialPageRoute(builder: (_) => const SettingsView());
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
