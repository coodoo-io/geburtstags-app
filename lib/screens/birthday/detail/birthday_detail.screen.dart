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
    final daysUntilBirthday = DateTimeUtil().remainingDaysUntilBirthday(birthday!.date);

    void _showAlertDialog() {
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

    return Scaffold(
      appBar: AppBar(
        title: Text(birthday!.name),
        actions: <Widget>[
          PopupMenuButton(
              // add icon, by default "3 dot" icon
              // icon: Icon(Icons.book)
              itemBuilder: (context) {
            return [
              const PopupMenuItem<int>(
                value: 0,
                child: Text("Bearbeiten"),
              ),
              const PopupMenuItem<int>(
                value: 1,
                child: Text("Löschen"),
              ),
            ];
          }, onSelected: (value) async {
            if (value == 0) {
              final response = await Navigator.of(context).push(
                MaterialPageRoute(
                  fullscreenDialog: true,
                  builder: (BuildContext context) {
                    return BirthdayForm(
                      birthday: birthday,
                      isEdit: true,
                    );
                  },
                ),
              );

              setState(() {
                birthday = response;
              });
            }
            if (value == 1) {
              _showAlertDialog();
            }
          }),
        ],
      ),
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
                      style:
                          theme.textTheme.headline6?.copyWith(fontWeight: FontWeight.bold, color: theme.primaryColor),
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
              Text('Nächster Geburtstag', style: theme.textTheme.subtitle1),
              Text(
                daysUntilBirthday == 1 ? "in einem Tag" : "in $daysUntilBirthday Tagen",
                style: theme.textTheme.subtitle1?.copyWith(fontWeight: FontWeight.bold),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
