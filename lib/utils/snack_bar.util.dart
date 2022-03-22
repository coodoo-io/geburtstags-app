import 'package:flutter/material.dart';

class SnackBarUtil {
  static SnackBar info({required String content}) {
    return SnackBar(
      content: Padding(
        padding: const EdgeInsets.all(4.0),
        child: Text(content),
      ),
      duration: const Duration(seconds: 1),
      behavior: SnackBarBehavior.floating,
    );
  }
}
