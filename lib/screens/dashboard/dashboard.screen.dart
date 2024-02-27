import 'package:flutter/material.dart';
import 'package:geburtstags_app/common/util/datetime.uitl.dart';
import 'package:geburtstags_app/repositories/birthday.repository.dart';

class DashboardScreen extends StatefulWidget {
  const DashboardScreen({super.key});

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  final dateTimeUtil = DateTimeUtil();
  @override
  Widget build(BuildContext context) {
    final repo = BirthdayRepository();
    final nextFiveBirthdays = repo.getNextFiveBirthdays();
    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(
              onPressed: () {
                setState(() {});
              },
              icon: Icon(Icons.replay))
        ],
        title: const Center(
          child: Text('Dashboard'),
        ),
      ),
      body: ListView.builder(
          itemCount: nextFiveBirthdays.length,
          itemBuilder: (BuildContext context, index) {
            final birthday = nextFiveBirthdays[index];
            final getNextAge =
                dateTimeUtil.getAge(birthday.birthday, DateTime.now());
            return Padding(
              padding: const EdgeInsets.all(8.0),
              child: Card(
                elevation: 10,
                shape: const RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(
                    Radius.circular(10),
                  ),
                ),
                child: ListTile(
                  leading:
                      const CircleAvatar(child: Icon(Icons.person), radius: 25),
                  title: Text(birthday.name),
                  subtitle: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                          '${dateTimeUtil.remainingDaysUntilBirthday(birthday.birthday, DateTime.now())}')
                    ],
                  ),
                  trailing: Text("wird $getNextAge Jahre",
                      style: const TextStyle(fontSize: 18)),
                ),
              ),
            );
          }),
    );
  }
}
