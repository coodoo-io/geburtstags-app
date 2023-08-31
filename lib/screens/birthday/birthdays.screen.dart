import 'package:flutter/material.dart';
import 'package:geburtstags_app/repositories/birthday.repo.dart';
import 'package:geburtstags_app/screens/birthday/detail/birthday_detail.screen.dart';
import 'package:geburtstags_app/screens/birthday/widgets/birthday_form.dart';
import 'package:geburtstags_app/shared/no_birthdays_placeholder.dart';
import 'package:geburtstags_app/utils/snack_bar.util.dart';
import 'package:intl/intl.dart';
import 'package:ms_undraw/ms_undraw.dart';
import 'package:provider/provider.dart';

class BirthdaysScreen extends StatelessWidget {
  const BirthdaysScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final birthdays = context.watch<BirthdayRepo>().birthdays;
    final theme = Theme.of(context);
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Geburtstage",
        ),
      ),
      body: birthdays.isEmpty
          ? const NoBirthdaysPlaceholder(
              label: "Noch keine Geburtstage angelegt.",
              illustration: UnDrawIllustration.gifts,
            )
          : ListView.separated(
              itemCount: birthdays.length,
              separatorBuilder: (BuildContext context, int index) => const Divider(height: 0),
              itemBuilder: (context, index) {
                final birthday = birthdays[index];
                return Dismissible(
                  key: UniqueKey(),
                  direction: DismissDirection.endToStart,
                  background: Container(
                    color: Colors.pinkAccent,
                    child: const Padding(
                      padding: EdgeInsets.only(right: 10.0),
                      child: Align(
                        alignment: Alignment.centerRight,
                        child: Icon(
                          Icons.delete_outlined,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                  onDismissed: (direction) {
                    context.read<BirthdayRepo>().delete(birthday);
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBarUtil.info(
                        content: "${birthday.name} gelöscht.",
                      ),
                    );
                  },
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: ListTile(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => BirthdayDetailScreen(
                              birthday: birthday,
                            ),
                          ),
                        );
                      },
                      title: Text(
                        birthday.name,
                        overflow: TextOverflow.ellipsis,
                        maxLines: 2,
                        style: theme.textTheme.titleLarge
                            ?.copyWith(fontWeight: FontWeight.bold, color: theme.primaryColor),
                      ),
                      trailing: Text(
                        DateFormat('dd.MM.yyyy').format(birthday.date),
                        style: theme.textTheme.titleMedium,
                      ),
                    ),
                  ),
                );
              },
            ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.of(context).push(
            MaterialPageRoute(
              fullscreenDialog: true,
              builder: (BuildContext context) {
                return const BirthdayForm();
              },
            ),
          );
        },
        child: const Icon(
          Icons.add,
        ),
      ),
    );
  }
}
