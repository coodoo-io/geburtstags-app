import 'package:flutter/material.dart';

@immutable
class Birthday {
  final String id;
  final String name;
  final DateTime date;
  final String? profileImage;
  final String? notes;
  final int? daysUntilBirthday;

  const Birthday({
    required this.id,
    required this.name,
    required this.date,
    this.profileImage,
    this.notes,
    this.daysUntilBirthday,
  });

  factory Birthday.fromJson(Map<String, dynamic> parsedJson) {
    return Birthday(
      name: parsedJson['name'],
      date: DateTime.parse(parsedJson['date']),
      profileImage: parsedJson['profileImage'],
      notes: parsedJson['notes'],
      id: parsedJson['id'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'date': date.toString(),
      'profileImage': profileImage,
      'notes': notes,
    };
  }
}
