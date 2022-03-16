import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:geburtstags_app/models/birthday.dart';
import 'package:geburtstags_app/repositories/birthday.repo.dart';
import 'package:geburtstags_app/screens/birthday/birthdays.screen.dart';
import 'package:geburtstags_app/templates/template.dart';
import 'package:provider/provider.dart';

void main() {
  Widget createWidgetForTesting({required Widget child}) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => BirthdayRepo()),
      ],
      child: MaterialApp(
        home: child,
      ),
    );
  }

  setUp(() {
    final BirthdayRepo birthdayRepo = BirthdayRepo();
    birthdayRepo.insert(
      Birthday(
        name: 'Nico',
        date: DateTime(1998, 6, 12),
      ),
    );
    birthdayRepo.insert(
      Birthday(
        name: 'Flo',
        date: DateTime(2003, 5, 7),
      ),
    );
    birthdayRepo.insert(
      Birthday(
        name: 'Lena',
        date: DateTime(2001, 8, 12),
      ),
    );
    birthdayRepo.insert(
      Birthday(
        name: 'Lukas',
        date: DateTime(2000, 10, 12),
      ),
    );
  });

  testWidgets('BottomNavigationBar', (WidgetTester tester) async {
    await tester.pumpWidget(createWidgetForTesting(child: const Template()));

    expect(find.byIcon(Icons.home_outlined), findsWidgets);
    expect(find.byIcon(Icons.cake_outlined), findsWidgets);
    expect(find.byIcon(Icons.settings_outlined), findsWidgets);

    await tester.tap(find.byIcon(Icons.home_outlined));
    await tester.tap(find.byIcon(Icons.cake_outlined));
    await tester.tap(find.byIcon(Icons.settings_outlined));
  });

  testWidgets('BirthdayScreen', (WidgetTester tester) async {
    await tester.pumpWidget(createWidgetForTesting(child: const BirthdaysScreen()));

    expect(find.byType(ListView), findsWidgets);
    expect(find.byType(ListTile), findsNWidgets(4));
  });

  testWidgets('BottomNavigationBar => Dashboard', (WidgetTester tester) async {
    await tester.pumpWidget(createWidgetForTesting(child: const Template()));

    await tester.tap(find.byIcon(Icons.home_outlined));

    expect(find.byType(ListView), findsWidgets);
    expect(find.text("Flo"), findsWidgets);
  });
}
