import 'package:flutter/material.dart';
import 'package:geburtstags_app/screens/birthday/birthdays.screen.dart';
import 'package:geburtstags_app/screens/birthday/detail/birthday_detail.screen.dart';
import 'package:geburtstags_app/screens/birthday/widgets/birthday_form.dart';
import 'package:geburtstags_app/templates/template.dart';

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Geburtstags App',
      debugShowCheckedModeBanner: false,
      initialRoute: Template.routeName,
      routes: {
        Template.routeName: (context) => const Template(),
        BirthdaysScreen.routeName: (context) => const BirthdaysScreen(),
        BirthdayDetailScreen.routeName: (context) => const BirthdayDetailScreen(),
        BirthdayForm.routeName: (context) => const BirthdayForm(),
      },
      //onGenerateRoute: (_) => Template.routeName,
      theme: ThemeData(
        primarySwatch: Colors.blue,
        useMaterial3: false,
      ),
    );
  }
}
