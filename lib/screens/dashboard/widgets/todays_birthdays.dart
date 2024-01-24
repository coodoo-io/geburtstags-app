import 'package:flutter/material.dart';
import 'package:geburtstags_app/repositories/birthday.repo.dart';
import 'package:geburtstags_app/utils/datetime.util.dart';

class TodaysBirthdays extends StatelessWidget {
  const TodaysBirthdays({super.key});

  @override
  Widget build(BuildContext context) {
    final repo = BirthdayRepo();
    final todaysBirthdays = repo.getTodaysBirthdays();

    return ListView.separated(
      scrollDirection: Axis.horizontal,
      itemCount: todaysBirthdays.length,
      shrinkWrap: true,
      itemBuilder: (context, index) {
        final dateTimeUtil = DateTimeUtil();
        final birthday = todaysBirthdays[index];
        final getAge = dateTimeUtil.getAge(birthday.date);

        return SizedBox(
          height: MediaQuery.of(context).size.width * 0.7,
          width: MediaQuery.of(context).size.width * 0.7,
          child: Card(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(15.0),
            ),
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const CircleAvatar(
                      radius: 50,
                      child: Icon(
                        Icons.person,
                        size: 50,
                      )),
                  const SizedBox(height: 25),
                  Text(
                    birthday.name,
                    style: const TextStyle(fontSize: 25),
                  ),
                  Text(
                    "${getAge.toString()} Jahre",
                    style: TextStyle(fontSize: 18, color: Colors.black.withOpacity(0.5)),
                  ),
                ],
              ),
            ),
          ),
        );
      },
      separatorBuilder: (context, index) => const SizedBox(width: 25),
    );
  }
}
