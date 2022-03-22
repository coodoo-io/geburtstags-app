import 'package:flutter/material.dart';
import 'package:geburtstags_app/templates/template.dart';
import 'package:geburtstags_app/themes/themes.dart';
import 'package:provider/provider.dart';

class App extends StatelessWidget {
  const App({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Geburtstags App',
      debugShowCheckedModeBanner: false,
      theme: light,
      darkTheme: dark,
      themeMode: context.watch<ThemeNotifier>().current,
      home: const Template(),
    );
  }
}
