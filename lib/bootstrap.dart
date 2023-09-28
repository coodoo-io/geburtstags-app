import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:geburtstags_app/common/logger/logger.dart';
import 'package:geburtstags_app/common/shared_preferences/shared_preferences.dart';
import 'package:geburtstags_app/presentation/design_system/constants/ui_plattform.dart';
import 'package:logging/logging.dart';
import 'package:shared_preferences/shared_preferences.dart';

Future<void> bootstrap(FutureOr<Widget> Function() builder) async {
  // Run app in zone to catch application errors
  await runZonedGuarded(
    () async {
      // Makes sure plugins are initialized
      WidgetsFlutterBinding.ensureInitialized();

      final sharedPreferences = await SharedPreferences.getInstance();

      final container = ProviderContainer(
        overrides: [
          sharedPrefsProvider.overrideWith((ref) => sharedPreferences),
        ],
      );

      setupLogger(level: UiPlatform.isDebugMode ? Level.INFO : Level.WARNING);
      Logger.root.info('Birthday App started');

      return runApp(
        UncontrolledProviderScope(
          container: container,
          // observers: [RiverpodLogger()],
          child: await builder(),
        ),
      );
    },
    (error, stackTrace) {
      if (UiPlatform.isWeb || UiPlatform.isDebugMode) {
        Logger.root.severe('bootstrap: zone-error', error, stackTrace);
      } else {
        Logger.root.severe('bootstrap: zone-error', error, stackTrace);
        // also record error to Crashlytics
      }
    },
  );
}
