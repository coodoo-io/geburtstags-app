import 'package:flutter/material.dart';
import 'package:geburtstags_app/core/utils/datetime.util.dart';
import 'package:intl/intl.dart';

class DashboardScreen extends StatelessWidget {
  const DashboardScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // TODO: get birthdays
    final next5birthdays = [];
    final todaysBirthdays = [];

    return Scaffold(
      appBar: AppBar(
        title: const Text("Dashboard"),
      ),
      body: next5birthdays.isEmpty && todaysBirthdays.isEmpty
          ? const Center(
              child: Text("Es stehen keine Geburtstage an"),
            )
          : Padding(
              padding: const EdgeInsets.all(20.0),
              child: ListView(
                children: [
                  if (todaysBirthdays.isNotEmpty) ...[
                    const Padding(
                      padding: EdgeInsets.only(bottom: 20.0),
                      child: Text(
                        "Heutige Geburtstage 🎂",
                        style: TextStyle(fontSize: 24),
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
                            child: Padding(
                              padding: const EdgeInsets.all(5.0),
                              child: ListTile(
                                onTap: () => Navigator.pushNamed(context, '/birthdays/detail', arguments: birthday),
                                leading: CircleAvatar(
                                  child: Image.asset("assets/images/default.png"),
                                  radius: 25,
                                  backgroundColor: Colors.white,
                                ),
                                title: Text(birthday.name),
                                subtitle: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    const SizedBox(height: 5),
                                    Text("Am ${DateFormat('dd.MM').format(birthday.date)}"),
                                    const SizedBox(height: 5),
                                    const Text(
                                      "Heute Geburtstag",
                                      style: TextStyle(fontStyle: FontStyle.italic, color: Colors.red),
                                    ),
                                  ],
                                ),
                                trailing: Text("wird $getAge Jahre", style: const TextStyle(fontSize: 18)),
                              ),
                            ),
                            elevation: 4,
                            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
                          ),
                        );
                      },
                    ),
                  ],
                  const Padding(
                    padding: EdgeInsets.symmetric(vertical: 20.0),
                    child: Text(
                      "Anstehende Geburtstage 🎉",
                      style: TextStyle(fontSize: 24),
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                  ListView.builder(
                    itemCount: next5birthdays.length,
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemBuilder: (context, index) {
                      final dateTimeUtil = DateTimeUtil();
                      final birthday = next5birthdays[index];
                      final daysUntilBirthday = dateTimeUtil.remainingDaysUntilBirthday(birthday.date);
                      final getNextAge = dateTimeUtil.getNextAge(birthday.date);

                      return Padding(
                        padding: const EdgeInsets.only(bottom: 5.0),
                        child: Card(
                          child: Padding(
                            padding: const EdgeInsets.all(5.0),
                            child: ListTile(
                              onTap: () => Navigator.pushNamed(context, '/birthdays/detail', arguments: birthday),
                              leading: CircleAvatar(
                                child: Image.asset("assets/images/default.png"),
                                radius: 25,
                                backgroundColor: Colors.white,
                              ),
                              title: Text(birthday.name),
                              subtitle: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  const SizedBox(height: 5),
                                  Text("Am ${DateFormat('dd.MM').format(birthday.date)}"),
                                  const SizedBox(height: 5),
                                  Text(
                                    daysUntilBirthday == 1 ? "In einem Tag" : "In $daysUntilBirthday Tagen",
                                    style: TextStyle(fontStyle: FontStyle.italic, color: Colors.green.shade700),
                                  ),
                                ],
                              ),
                              trailing: Text("wird $getNextAge Jahre", style: const TextStyle(fontSize: 18)),
                            ),
                          ),
                          elevation: 4,
                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
                        ),
                      );
                    },
                  ),
                ],
              ),
            ),
    );
  }
}
