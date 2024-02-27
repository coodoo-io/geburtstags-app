import 'package:flutter/material.dart';
import 'package:geburtstags_app/common/util/datetime.uitl.dart';
import 'package:geburtstags_app/repositories/birthday.repository.dart';
import 'package:provider/provider.dart';

class DashboardScreen extends StatelessWidget {
  final dateTimeUtil = DateTimeUtil();
  @override
  Widget build(BuildContext context) {
    final nextFiveBirthdays =
        context.watch<BirthdayRepository>().getNextFiveBirthdays();
    final isLoading = context.watch<BirthdayRepository>().isLoading;
    return Scaffold(
      appBar: AppBar(
        title: const Center(
          child: Text('Dashboard'),
        ),
      ),
      body: isLoading == true
          ? Center(
              child: CircularProgressIndicator(),
            )
          : ListView.builder(
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
                      leading: const CircleAvatar(
                          child: Icon(Icons.person), radius: 25),
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
