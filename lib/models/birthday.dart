import 'package:flutter/material.dart';

@immutable
class Birthday {
  final String name;
  final DateTime date;
  final String? profileImage;
  final String? notes;

  const Birthday(
      {required this.name, required this.date, this.profileImage, this.notes});

  Birthday.fromJson(Map<String, dynamic> json)
      : name = json['name'],
        date = DateTime.fromMillisecondsSinceEpoch(json['createdAt']),
        profileImage = json['profileImage'] ?? '',
        notes = json['notes'] ?? '';

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'date': date.millisecondsSinceEpoch.toString(),
      'profileImage': profileImage ?? '',
      'notes': notes ?? ''
    };
  }
}
