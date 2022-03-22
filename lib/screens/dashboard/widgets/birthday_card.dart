import 'package:flutter/material.dart';
import 'package:geburtstags_app/models/birthday.dart';
import 'package:geburtstags_app/screens/birthday/detail/birthday_detail.screen.dart';
import 'package:geburtstags_app/utils/datetime.util.dart';
import 'package:intl/intl.dart';

class BirthdayCard extends StatelessWidget {
  const BirthdayCard({Key? key, required this.birthday, this.isToday = false}) : super(key: key);

  final Birthday birthday;
  final bool isToday;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final daysUntilBirthday = DateTimeUtil().remainingDaysUntilBirthday(birthday.date);
    final nextAge = DateTimeUtil().getNextAge(birthday.date);
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: ListTile(
          onTap: () => Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => BirthdayDetailScreen(birthday: birthday)),
          ),
          leading: Container(
            constraints: const BoxConstraints(maxWidth: 150),
            child: Text(
              birthday.name,
              overflow: TextOverflow.ellipsis,
              maxLines: 2,
              style: theme.textTheme.headline6?.copyWith(fontWeight: FontWeight.bold, color: theme.primaryColor),
            ),
          ),
          title: Text(
            DateFormat.MMMMd('de').format(birthday.date),
            style: theme.textTheme.caption,
          ),
          trailing: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              if (isToday)
                Text(
                  "🎉",
                  style: theme.textTheme.headline5,
                ),
              RichText(
                text: TextSpan(
                  style: theme.textTheme.subtitle1?.copyWith(fontSize: 16),
                  children: [
                    TextSpan(text: nextAge.toString(), style: const TextStyle(fontWeight: FontWeight.bold)),
                    TextSpan(text: nextAge > 1 ? ' Jahre ' : ' Jahr '),
                  ],
                ),
              ),
              if (!isToday)
                Text(
                  daysUntilBirthday == 1 ? "in einem Tag" : "in $daysUntilBirthday Tagen",
                  style: theme.textTheme.caption,
                ),
            ],
          ),
        ),
      ),
      elevation: 4,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
    );
  }
}
