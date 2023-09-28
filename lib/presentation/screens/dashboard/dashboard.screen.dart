import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:geburtstags_app/domain/birthday/service/birthday.service.dart';
import 'package:geburtstags_app/presentation/design_system/widgets/ui_loading.dart';
import 'package:geburtstags_app/presentation/screens/birthday/detail/birthday_detail.screen.dart';
import 'package:geburtstags_app/common/utils/datetime.util.dart';
import 'package:intl/intl.dart';
import 'package:logging/logging.dart';

class DashboardScreen extends ConsumerWidget {
  const DashboardScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Dashboard",
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: TodaysBirthdaysList(),
      ),
    );
  }
}

class TodaysBirthdaysList extends ConsumerWidget {
  const TodaysBirthdaysList({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    var todaysBirthdaysAsyncValue = ref.watch(getTodaysBirthdaysServiceProvider);

    return todaysBirthdaysAsyncValue.when(
        loading: () => const UiLoading(),
        error: (err, stackTrace) {
          const msg = 'Fehler beim Laden der aktuellen Geburtstage';
          Logger.root.severe(msg, err, stackTrace);
          return const Text(msg);
        },
        data: (todaysBirthdays) {
          return ListView(
            children: [
              if (todaysBirthdays.isNotEmpty) ...[
                const Padding(
                  padding: EdgeInsets.only(bottom: 20.0),
                  child: Text(
                    "Heutige Geburtstage🎂",
                    style: TextStyle(
                      fontSize: 24,
                    ),
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
                ListView.builder(
                  itemCount: todaysBirthdays.length,
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemBuilder: (context, index) {
                    final dateTimeUtil = DateTimeUtil();
                    final birthday = todaysBirthdays[index];
                    final getAge = dateTimeUtil.getAge(birthday.date);

                    return Padding(
                      padding: const EdgeInsets.only(bottom: 5.0),
                      child: Card(
                        elevation: 4,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(15),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(5.0),
                          child: ListTile(
                            onTap: () => Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => BirthdayDetailScreen(birthday: birthday),
                              ),
                            ),
                            leading: CircleAvatar(
                              radius: 25,
                              backgroundColor: Colors.white,
                              child: Image.asset(
                                "assets/images/default.png",
                              ),
                            ),
                            title: Text(
                              birthday.name,
                            ),
                            subtitle: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const SizedBox(
                                  height: 5,
                                ),
                                Text(
                                  "Am ${DateFormat('dd.MM').format(birthday.date)}",
                                ),
                                const SizedBox(
                                  height: 5,
                                ),
                                const Text(
                                  "Heute Geburtstag",
                                  style: TextStyle(
                                    fontStyle: FontStyle.italic,
                                    color: Colors.red,
                                  ),
                                ),
                              ],
                            ),
                            trailing: Text(
                              "wird $getAge Jahre",
                              style: const TextStyle(
                                fontSize: 18,
                              ),
                            ),
                          ),
                        ),
                      ),
                    );
                  },
                ),
              ],
              const Padding(
                padding: EdgeInsets.symmetric(vertical: 20.0),
                child: Text(
                  "Anstehende Geburtstage 🎉",
                  style: TextStyle(
                    fontSize: 24,
                  ),
                  overflow: TextOverflow.ellipsis,
                ),
              ),
              const NextBirthdaysList()
            ],
          );
        });
  }
}

class NextBirthdaysList extends ConsumerWidget {
  const NextBirthdaysList({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    var nextBirthdaysAsyncValue = ref.watch(getNextBirthdaysServiceProvider(max: 5));

    return nextBirthdaysAsyncValue.when(
        loading: () => const UiLoading(),
        error: (err, stackTrace) {
          const msg = 'Fehler beim Laden der nächsten Geburtstage';
          Logger.root.severe(msg, err, stackTrace);
          return const Text(msg);
        },
        data: (next5birthdays) {
          return ListView.builder(
            itemCount: next5birthdays.length,
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemBuilder: (context, index) {
              final dateTimeUtil = DateTimeUtil();
              final birthday = next5birthdays[index];
              final getNextAge = dateTimeUtil.getNextAge(birthday.date);

              return Padding(
                padding: const EdgeInsets.only(bottom: 5.0),
                child: Card(
                  elevation: 4,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(5.0),
                    child: ListTile(
                      onTap: () => Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => BirthdayDetailScreen(birthday: birthday)),
                      ),
                      leading: CircleAvatar(
                        radius: 25,
                        backgroundColor: Colors.white,
                        child: Image.asset(
                          "assets/images/default.png",
                        ),
                      ),
                      title: Text(
                        birthday.name,
                      ),
                      subtitle: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const SizedBox(
                            height: 5,
                          ),
                          Text(
                            "Am ${DateFormat('dd.MM.yyyy').format(birthday.date)}",
                          ),
                          const SizedBox(
                            height: 5,
                          ),
                          Text(
                            birthday.daysUntilBirthday == 1 ? "In einem Tag" : "In ${birthday.daysUntilBirthday} Tagen",
                            style: TextStyle(
                              fontStyle: FontStyle.italic,
                              color: Colors.green.shade700,
                            ),
                          ),
                        ],
                      ),
                      trailing: Text(
                        "wird $getNextAge Jahre",
                        style: const TextStyle(
                          fontSize: 18,
                        ),
                      ),
                    ),
                  ),
                ),
              );
            },
          );
        });
  }
}
