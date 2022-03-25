import 'package:flutter/material.dart';
import 'package:geburtstags_app/core/models/birthday.model.dart';
import 'package:geburtstags_app/ui/widgets/template.dart';
import 'package:geburtstags_app/ui/views/birthday_detail.view.dart';

/// Example for Routing
class AppRouter {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case '/':
        return MaterialPageRoute(builder: (_) => const Template());
      case '/birthdays/detail':
        final birthday = settings.arguments as Birthday;
        return MaterialPageRoute(builder: (_) => BirthdayDetailView(birthday: birthday));
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
