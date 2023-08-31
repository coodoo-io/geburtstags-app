import 'package:flutter/material.dart';

class BirthdaysScreen extends StatelessWidget {
  const BirthdaysScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Geburtstage",
        ),
      ),
      body: ListView(
        children: const [
          ListTile(
            title: Text(
              'Julia',
            ),
            trailing: Text(
              "16.04.1993",
            ),
          ),
          ListTile(
            title: Text(
              'Flo',
            ),
            trailing: Text(
              "07.05.2003",
            ),
          ),
          ListTile(
            title: Text(
              'Marcel',
            ),
            trailing: Text(
              "09.03.1984",
            ),
          ),
        ],
      ),
    );
  }
}
