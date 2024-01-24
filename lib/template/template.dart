import 'package:flutter/material.dart';
import 'package:geburtstags_app/screens/birthdays.screen.dart';
import 'package:geburtstags_app/screens/dashboard.screen.dart';
import 'package:geburtstags_app/screens/settings.screen.dart';

class Template extends StatefulWidget {
  const Template({super.key});

  @override
  State<Template> createState() => _TemplateState();
}

class _TemplateState extends State<Template> {
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
