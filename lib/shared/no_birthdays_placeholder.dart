import 'package:flutter/material.dart';
import 'package:ms_undraw/ms_undraw.dart';

class NoBirthdaysPlaceholder extends StatelessWidget {
  const NoBirthdaysPlaceholder({
    Key? key,
    required this.label,
    this.illustration = UnDrawIllustration.happy_birthday,
  }) : super(key: key);

  final String label;
  final UnDrawIllustration illustration;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          UnDraw(
            color: theme.primaryColor,
            illustration: illustration,
            height: 200.0,
            placeholder: const CircularProgressIndicator(),
            errorWidget: Container(),
          ),
          const SizedBox(height: 20),
          Text(
            label,
            style: theme.textTheme.titleMedium,
          ),
        ],
      ),
    );
  }
}
