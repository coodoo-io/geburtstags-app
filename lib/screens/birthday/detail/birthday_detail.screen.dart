import 'package:flutter/material.dart';
import 'package:geburtstags_app/models/birthday.dart';
import 'package:geburtstags_app/repositories/birthday.repo.dart';
import 'package:geburtstags_app/screens/birthday/widgets/birthday_form.dart';
import 'package:geburtstags_app/utils/datetime.util.dart';
import 'package:geburtstags_app/utils/snack_bar.util.dart';
import 'package:intl/intl.dart';
import 'package:ms_undraw/ms_undraw.dart';
import 'package:provider/provider.dart';

class BirthdayDetailScreen extends StatefulWidget {
  const BirthdayDetailScreen({
    required this.birthday,
    Key? key,
  }) : super(key: key);

  final Birthday birthday;

  @override
  State<BirthdayDetailScreen> createState() => _BirthdayDetailScreenState();
}

class _BirthdayDetailScreenState extends State<BirthdayDetailScreen> {
  Birthday? birthday;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    // Wenn die Detail Seite aufgerufen wid, ist birthday null. Dann wollen wir die übergebenen Daten verwenden.
    // Wenn wir updaten wollen, z.B. den Namen ändern wollen wir nicht nochmal die übergebenen Daten verwenden sondern die aktualisierten Daten.
    birthday ??= widget.birthday;
    final isTodaysBirthdays = context.read<BirthdayRepo>().isBirthdayToday(birthday!);
    final daysUntilBirthday = DateTimeUtil().remainingDaysUntilBirthday(birthday!.date);

    return Scaffold(
      appBar: AppBar(title: Text(birthday!.name)),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(30),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Center(
                child: UnDraw(
                  color: theme.primaryColor,
                  illustration: UnDrawIllustration.happy_music,
                  height: 200.0,
                  placeholder: const CircularProgressIndicator(),
                  errorWidget: Container(),
                ),
              ),
              const SizedBox(height: 30),
              // Name
              Text('Name', style: theme.textTheme.headline6),
              Text(
                birthday!.name,
                style: theme.textTheme.headline5?.copyWith(fontWeight: FontWeight.bold, color: theme.primaryColor),
              ),
              const SizedBox(height: 20),
              ListTile(
                contentPadding: EdgeInsets.zero,
                leading: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Geburtsdatum', style: theme.textTheme.headline6),
                    Text(
                      DateFormat.yMMMMd('de').format(birthday!.date),
                      style: theme.textTheme.headline6?.copyWith(
                        fontWeight: FontWeight.bold,
                        color: theme.primaryColor,
                      ),
                    ),
                  ],
                ),
                trailing: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text('Alter', style: theme.textTheme.subtitle1),
                    Text(
                      DateTimeUtil().getAge(birthday!.date).toString(),
                      style: theme.textTheme.subtitle1?.copyWith(fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
              ),
              const Divider(height: 50),
              ListTile(
                contentPadding: EdgeInsets.zero,
                leading: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Nächster Geburtstag', style: theme.textTheme.subtitle1),
                    Text(
                      isTodaysBirthdays
                          ? "Heute"
                          : daysUntilBirthday == 1
                              ? "in einem Tag"
                              : "in $daysUntilBirthday Tagen",
                      style: theme.textTheme.subtitle1?.copyWith(fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
                trailing: Text(
                  isTodaysBirthdays ? "🎉" : "",
                  style: theme.textTheme.headline4?.copyWith(color: Colors.black),
                ),
              ),
              const SizedBox(height: 60),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    FloatingActionButton(
                      child: const Icon(Icons.edit_outlined),
                      elevation: 0,
                      onPressed: () => _editBirthday(context),
                      heroTag: null,
                    ),
                    FloatingActionButton(
                      child: const Icon(Icons.delete_outlined),
                      backgroundColor: Colors.pinkAccent,
                      elevation: 0,
                      onPressed: () => _deleteBirthday(context),
                      heroTag: null,
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future<void> _editBirthday(BuildContext context) async {
    final response = await Navigator.of(context).push(
      MaterialPageRoute(
        fullscreenDialog: true,
        builder: (BuildContext context) => BirthdayForm(birthday: birthday!, isEdit: true),
      ),
    );
    setState(() => birthday = response);
  }

  void _deleteBirthday(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text("${birthday!.name} wirklich löschen?"),
          actions: <Widget>[
            TextButton(
              child: const Text("Abbrechen"),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            TextButton(
              child: const Text("Löschen"),
              onPressed: () {
                context.read<BirthdayRepo>().delete(birthday!);
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBarUtil.info(content: '${birthday!.name} gelöscht.'),
                );
                Navigator.of(context).pop();
                Navigator.pop(context);
              },
            ),
          ],
        );
      },
    );
  }
}
