import 'package:flutter/material.dart';
import 'package:geburtstags_app/utils/file.util.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Einstellungen",
        ),
      ),
      body: Center(
        child: ElevatedButton(
          onPressed: () {
            FileUtil().exportCSV();
          },
          child: const Text(
            "Export to CSV",
          ),
        ),
      ),
    );
  }
}
