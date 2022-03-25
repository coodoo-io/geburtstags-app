import 'package:flutter/material.dart';
import 'package:geburtstags_app/ui/screens/birthdays.screen.dart';
import 'package:geburtstags_app/ui/screens/dashboard.screen.dart';
import 'package:geburtstags_app/ui/screens/settings.screen.dart';

/// Example for Routing
class Router {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case '/':
        return MaterialPageRoute(builder: (_) => const DashboardScreen());
      case '/birthdays':
        // var birthday = settings.arguments as Birthday; // Example Parameter
        return MaterialPageRoute(builder: (_) => const BirthdaysScreen());
      case '/settings':
        return MaterialPageRoute(builder: (_) => const SettingsScreen());
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