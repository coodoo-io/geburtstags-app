import 'package:flutter/material.dart';
import 'package:geburtstags_app/themes/themes.dart';
import 'package:provider/provider.dart';

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({Key? key}) : super(key: key);

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  @override
  Widget build(BuildContext context) {
    final darkTheme = context.watch<ThemeNotifier>().isDarkTheme;

    return Scaffold(
      appBar: AppBar(title: const Text("Einstellungen")),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Card(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: SwitchListTile.adaptive(
              value: darkTheme,
              onChanged: (value) {
                context.read<ThemeNotifier>().toggleTheme();
              },
              title: const Text("Dark Theme"),
            ),
          ),
          shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(20.0)),
          ),
        ),
      ),
    );
  }
}
