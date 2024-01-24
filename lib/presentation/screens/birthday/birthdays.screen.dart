import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:geburtstags_app/domain/birthday/service/birthday.service.dart';
import 'package:geburtstags_app/presentation/design_system/widgets/ui_loading.dart';
import 'package:geburtstags_app/presentation/screens/birthday/detail/birthday_detail.screen.dart';
import 'package:geburtstags_app/presentation/screens/birthday/widgets/birthday_form.dart';
import 'package:intl/intl.dart';
import 'package:logging/logging.dart';

class BirthdaysScreen extends ConsumerWidget {
  const BirthdaysScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    var birthdaysAsyncValue = ref.watch(getAllBirthdaysServiceProvider);
    return birthdaysAsyncValue.when(
      loading: () => const UiLoading(),
      error: (err, stackTrace) {
        const msg = 'Fehler beim Laden der Geburtstage';
        Logger.root.severe(msg, err, stackTrace);
        return const Text(msg);
      },
      data: (birthdays) {
        return Scaffold(
          appBar: AppBar(
            title: const Text(
              "Geburtstage",
            ),
          ),
          body: ListView.builder(
            itemCount: birthdays.length,
            itemBuilder: (context, index) {
              final birthday = birthdays[index];
              return Dismissible(
                key: UniqueKey(),
                direction: DismissDirection.endToStart,
                background: Container(
                  color: Colors.red,
                  child: const Padding(
                    padding: EdgeInsets.only(right: 10.0),
                    child: Align(
                      alignment: Alignment.centerRight,
                      child: Icon(
                        Icons.delete,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
                onDismissed: (direction) async {
                  await ref.read(removeBirthdayServiceProvider(birthday: birthday).future);
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text(
                        "${birthday.name} gelöscht.",
                      ),
                    ),
                  );
                },
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
                  ),
                  trailing: Text(
                    DateFormat('dd.MM.yyyy').format(birthday.date),
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
      },
    );
  }
}
