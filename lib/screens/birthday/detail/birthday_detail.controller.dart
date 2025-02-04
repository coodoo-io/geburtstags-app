import 'package:flutter/material.dart';
import 'package:geburtstags_app/models/birthday.dart';

class BirthdayDetailController extends ChangeNotifier {
  Birthday? _birthday;

  void setBirthday(Birthday birthday) {
    _birthday = birthday;
    notifyListeners();
  }

  Birthday? get birthday => _birthday;
}
