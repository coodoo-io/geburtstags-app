import 'package:flutter/material.dart';
import 'package:geburtstags_app/repositories/birthday.repo.dart';
import 'package:geburtstags_app/screens/dashboard/widgets/birthday_card.dart';
import 'package:geburtstags_app/shared/no_birthdays_placeholder.dart';
import 'package:provider/provider.dart';

class DashboardScreen extends StatelessWidget {
  const DashboardScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final nextBirthdays = context.watch<BirthdayRepo>().getNextFiveBirthdays();
    final todaysBirthdays = context.watch<BirthdayRepo>().getTodaysBirthdays();
    final theme = Theme.of(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text("Dashboard"),
      ),
      body: nextBirthdays.isEmpty && todaysBirthdays.isEmpty
          ? const NoBirthdaysPlaceholder(label: "Es stehen keine Geburtstage an.")
          : Padding(
              padding: const EdgeInsets.all(20.0),
              child: ListView(
                children: [
                  if (todaysBirthdays.isNotEmpty) ...[
                    Padding(
                      padding: const EdgeInsets.only(bottom: 20.0),
                      child: Text(
                        "Heutige Geburtstage",
                        overflow: TextOverflow.ellipsis,
                        style: theme.textTheme.headline5,
                      ),
                    ),
                    ListView.separated(
                      itemCount: todaysBirthdays.length,
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      itemBuilder: (context, index) => BirthdayCard(birthday: todaysBirthdays[index], isToday: true),
                      separatorBuilder: (BuildContext context, int index) => const SizedBox(width: 5),
                    ),
                  ],
                  if (nextBirthdays.isNotEmpty) ...[
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 20.0),
                      child: Text(
                        "Anstehende Geburtstage",
                        style: theme.textTheme.headline5,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                    ListView.separated(
                      itemCount: nextBirthdays.length,
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      itemBuilder: (context, index) => BirthdayCard(birthday: nextBirthdays[index]),
                      separatorBuilder: (BuildContext context, int index) => const SizedBox(width: 5),
                    ),
                  ]
                ],
              ),
            ),
    );
  }
}
