import 'package:flutter/material.dart';

class UiLoading extends StatelessWidget {
  const UiLoading({super.key, this.color, this.padding = const EdgeInsets.all(20)});

  final EdgeInsets padding;
  final Color? color;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: padding,
        child: SizedBox(width: 24, height: 24, child: CircularProgressIndicator(strokeWidth: 3, color: color)),
      ),
    );
  }
}
