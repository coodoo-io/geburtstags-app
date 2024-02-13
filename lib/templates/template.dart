import 'package:flutter/material.dart';
import 'package:geburtstags_app/screens/dashboard/dashboard.screen.dart';
import 'package:geburtstags_app/screens/birthday/list/birthdays.screen.dart';
import 'package:geburtstags_app/screens/settings/settings.screen.dart';

class Template extends StatefulWidget {
  const Template({super.key});

  static String routeName = (Template).toString();

  @override
  State<StatefulWidget> createState() => TemplateState();
}

class TemplateState extends State<Template> {
  int index = 1;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: BottomNavigationBar(
        onTap: (tabbedIndex) => setState(() => index = tabbedIndex),
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home_max_outlined), label: 'Dashboard'),
          BottomNavigationBarItem(icon: Icon(Icons.cake_outlined), label: 'Geburtstage'),
          BottomNavigationBarItem(icon: Icon(Icons.settings), label: 'Einstellungen'),
        ],
        currentIndex: index,
      ),
      body: IndexedStack(
        index: index,
        children: const [
          DashboardScreen(),
          GeburtstagsScreen(),
          SettingsScreen(),
        ],
      ),
    );
  }
}
