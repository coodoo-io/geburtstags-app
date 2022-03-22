import 'package:flutter/material.dart';
import 'package:geburtstags_app/models/birthday.dart';

@immutable
class BirthdayState {
  const BirthdayState({
    required this.birthdays,
    required this.next5Birthdays,
    required this.todaysBirthdays,
  });

  BirthdayState copyWith({
    List<Birthday>? birthdays,
    List<Birthday>? next5Birthdays,
    List<Birthday>? todaysBirthdays,
  }) {
    return BirthdayState(
        birthdays: birthdays ?? this.birthdays,
        next5Birthdays: next5Birthdays ?? this.next5Birthdays,
        todaysBirthdays: todaysBirthdays ?? this.todaysBirthdays);
  }

  final List<Birthday> birthdays;
  final List<Birthday> next5Birthdays;
  final List<Birthday> todaysBirthdays;
}