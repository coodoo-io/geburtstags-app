import 'package:flutter/material.dart';
import 'package:geburtstags_app/presentation/screens/birthday/birthdays.screen.dart';
import 'package:geburtstags_app/presentation/screens/dashboard/dashboard.screen.dart';
import 'package:geburtstags_app/presentation/screens/settings/settings.screen.dart';

class Template extends StatefulWidget {
  const Template({super.key});

  @override
  TemplateState createState() => TemplateState();
}

class TemplateState extends State<Template> {
  int _index = 1;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _index,
        onTap: (index) => setState(() => _index = index),
        items: const [
          BottomNavigationBarItem(
            icon: Icon(
              Icons.home_outlined,
            ),
            label: 'Dashboard',
          ),
          BottomNavigationBarItem(
            icon: Icon(
              Icons.cake_outlined,
            ),
            label: 'Geburtstage',
          ),
          BottomNavigationBarItem(
            icon: Icon(
              Icons.settings_outlined,
            ),
            label: 'Einstellungen',
          ),
        ],
      ),
      body: IndexedStack(
        index: _index,
        children: const [
          DashboardScreen(),
          BirthdaysScreen(),
          SettingsScreen(),
        ],
      ),
    );
  }
}
