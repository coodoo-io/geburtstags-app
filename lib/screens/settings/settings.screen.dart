import 'package:flutter/material.dart';
import 'package:geburtstags_app/themes/themes.dart';
import 'package:ms_undraw/ms_undraw.dart';
import 'package:provider/provider.dart';

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({super.key});

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  @override
  Widget build(BuildContext context) {
    final darkTheme = context.watch<ThemeNotifier>().isDarkTheme;
    final theme = Theme.of(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Einstellungen",
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          children: [
            UnDraw(
              color: theme.primaryColor,
              illustration: UnDrawIllustration.elements,
              height: 200.0,
              placeholder: const CircularProgressIndicator(),
              errorWidget: Container(),
            ),
            Card(
              shape: const RoundedRectangleBorder(
                borderRadius: BorderRadius.all(
                  Radius.circular(20.0),
                ),
              ),
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: SwitchListTile.adaptive(
                  value: darkTheme,
                  activeColor: theme.primaryColor,
                  onChanged: (value) => context.read<ThemeNotifier>().toggleTheme(),
                  title: const Text(
                    "Dark Theme",
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
