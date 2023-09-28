import 'package:flutter/cupertino.dart';

class UiDatePickerApple extends StatelessWidget {
  const UiDatePickerApple({
    super.key,
    required this.onDateTimeChanged,
    this.mode = CupertinoDatePickerMode.dateAndTime,
    this.maximumDate,
  });

  final Function(DateTime) onDateTimeChanged;
  final CupertinoDatePickerMode mode;
  final DateTime? maximumDate;

  @override
  Widget build(BuildContext context) {
    final mediaQuery = MediaQuery.of(context);
    final screenHeight = mediaQuery.size.height;
    final screenHeightHalf = screenHeight / 3;

    return SafeArea(
      bottom: true,
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              height: screenHeightHalf,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
              ),
              child: CupertinoDatePicker(
                mode: mode,
                use24hFormat: true,
                onDateTimeChanged: onDateTimeChanged,
                maximumDate: maximumDate,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
