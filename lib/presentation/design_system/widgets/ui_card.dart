import 'package:flutter/material.dart';

class UiCard extends StatelessWidget {
  const UiCard({
    super.key,
    required this.child,
    this.width = double.infinity,
    this.height,
    this.padding = const EdgeInsets.only(left: 16, right: 16, top: 20, bottom: 20),
    this.margin,
    this.borderRadius = 8.0,
    this.footer,
  });
  final Widget child;
  final double width;
  final double? height;
  final EdgeInsets padding;
  final EdgeInsets? margin;
  final double borderRadius;
  final Widget? footer;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Container(
      margin: margin,
      constraints: const BoxConstraints(minHeight: 64),
      width: width,
      height: height,
      decoration: BoxDecoration(
        color: theme.cardColor,
        borderRadius: BorderRadius.all(
          Radius.circular(borderRadius),
        ),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.max,
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Padding(
            padding: padding,
            child: child,
          ),
          if (footer != null) footer!,
        ],
      ),
    );
  }
}
