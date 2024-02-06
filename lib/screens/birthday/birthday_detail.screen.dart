import 'package:flutter/material.dart';
import 'package:geburtstags_app/app.dart';
import 'package:geburtstags_app/models/birthday.model.dart';

class BirthdayDetail extends StatelessWidget {
  final FreezedBirthday birthday;

  BirthdayDetail({required this.birthday});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Center(
        child: Text(birthday.name),
      ),
    );
  }
}
