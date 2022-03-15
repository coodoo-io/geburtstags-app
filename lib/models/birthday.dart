import 'package:flutter/material.dart';

@immutable
class Birthday {
  final String name;
  final DateTime date;
  final String? profileImage;
  final String? notes;

  const Birthday({required this.name, required this.date, this.profileImage, this.notes});

  factory Birthday.fromJson(Map<String, dynamic> parsedJson) {
    return Birthday(
      name: parsedJson['name'],
      date: DateTime.parse(parsedJson['date']),
      profileImage: parsedJson['profileImage'],
      notes: parsedJson['notes'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'date': date.toString(),
      'profileImage': profileImage,
      'notes': notes,
    };
  }
}
