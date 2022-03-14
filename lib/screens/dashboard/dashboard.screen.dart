import 'package:flutter/material.dart';
import 'package:geburtstags_app/repositories/birthday.repo.dart';
import 'package:geburtstags_app/screens/birthday/detail/birthday_detail.screen.dart';
import 'package:geburtstags_app/util/datetime.util.dart';
import 'package:intl/intl.dart';

class DashboardScreen extends StatefulWidget {
  const DashboardScreen({Key? key}) : super(key: key);

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  @override
  Widget build(BuildContext context) {
    final repo = BirthdayRepo();
    final nextbirthdays = repo.getNextFiveBirthdays();
    final todaysBirthdays = repo.getTodaysBirthdays();

    return Scaffold(
      appBar: AppBar(
        title: const Text("Dashboard"),
        actions: [
          IconButton(
            onPressed: () => setState(() {}),
            icon: const Icon(Icons.refresh),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: ListView(
          children: [
            if (todaysBirthdays.isNotEmpty) ...[
              const Padding(
                padding: EdgeInsets.only(bottom: 20.0),
                child: Text(
                  "🥳Heutige Geburtstage🎂",
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
                          onTap: () => Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => BirthdayDetailScreen(birthday: birthday)),
                          ).then((value) => setState(() {})),
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
                          trailing: Text("$getAge Jahre", style: const TextStyle(fontSize: 18)),
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
                "🎉Anstehende Geburtstage🎉",
                style: TextStyle(fontSize: 24),
                overflow: TextOverflow.ellipsis,
              ),
            ),
            ListView.builder(
              itemCount: nextbirthdays.length,
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemBuilder: (context, index) {
                final dateTimeUtil = DateTimeUtil();
                final birthday = nextbirthdays[index];
                final daysUntilBirthday = dateTimeUtil.remainingDaysUntilBirthday(birthday.date);
                final getAge = dateTimeUtil.getAge(birthday.date);

                return Padding(
                  padding: const EdgeInsets.only(bottom: 5.0),
                  child: Card(
                    child: Padding(
                      padding: const EdgeInsets.all(5.0),
                      child: ListTile(
                        onTap: () => Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => BirthdayDetailScreen(birthday: birthday)),
                        ).then((value) => setState(() {})),
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
                              "In $daysUntilBirthday Tagen",
                              style: TextStyle(fontStyle: FontStyle.italic, color: Colors.green.shade700),
                            ),
                          ],
                        ),
                        trailing: Text("$getAge Jahre", style: const TextStyle(fontSize: 18)),
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
