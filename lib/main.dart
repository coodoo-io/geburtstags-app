import 'dart:async';

import 'package:geburtstags_app/app.dart';
import 'package:geburtstags_app/bootstrap.dart';

Future<void> main() async {
  await bootstrap(() => const App());
}
