import 'package:flutter/material.dart';
import 'package:geburtstags_app/templates/template.dart';

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'Geburtstags App',
        theme: ThemeData(
          useMaterial3: true,
          primarySwatch: Colors.red,
        ),
        home: const Template());
  }
}
