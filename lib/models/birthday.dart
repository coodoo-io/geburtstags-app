import 'package:flutter/material.dart';

@immutable
class Birthday {
  final String name;
  final DateTime date;
  final String? profileImage;
  final String? notes;

  const Birthday({required this.name, required this.date, this.profileImage, this.notes});
}
