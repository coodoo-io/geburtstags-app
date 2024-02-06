import 'package:flutter/material.dart';
import 'package:geburtstags_app/screens/dashboard.screen.dart';
import 'package:geburtstags_app/screens/geburtstag.screen.dart';
import 'package:geburtstags_app/screens/settings.screen.dart';

class Template extends StatefulWidget {
  const Template({super.key});

  static String routeName = (Template).toString();

  @override
  State<StatefulWidget> createState() => TemplateState();
}

class TemplateState extends State<Template> {
  int index = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(
              onPressed: () => {index = 1, setState(() {})},
              icon: Icon(Icons.cake_outlined))
        ],
      ),
      drawer: Drawer(
        child: ListView(children: [
          ListTile(
            leading: const Icon(Icons.home_max_outlined),
            title: const Text('Dashboard'),
            onTap: () {
              index = 0;
              setState(() {});
              Navigator.of(context).pop();
            },
          )
        ]),
      ),
      bottomNavigationBar: BottomNavigationBar(
        onTap: (tabbedIndex) => setState(() => index = tabbedIndex),
        items: const [
          BottomNavigationBarItem(
              icon: Icon(Icons.home_max_outlined), label: 'Dashboard'),
          BottomNavigationBarItem(
              icon: Icon(Icons.cake_outlined), label: 'Geburtstage'),
          BottomNavigationBarItem(
              icon: Icon(Icons.settings), label: 'Einstellungen'),
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
