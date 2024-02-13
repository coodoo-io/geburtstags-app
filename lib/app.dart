import 'package:flutter/material.dart';
import 'package:geburtstags_app/screens/birthday/detail/birthday_detail.screen.dart';
import 'package:geburtstags_app/templates/template.dart';

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Geburtstags App',
      theme: ThemeData(
        useMaterial3: true,
        colorSchemeSeed: Colors.green,
        appBarTheme: const AppBarTheme(elevation: 3),
      ),
      initialRoute: Template.routeName,
      routes: {
        Template.routeName: (BuildContext context) => const Template(),
        BirthdayDetail.routeName: (BuildContext context) => BirthdayDetail(),
      },
    );
  }
}
