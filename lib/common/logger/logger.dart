import 'package:geburtstags_app/presentation/design_system/constants/ui_plattform.dart';
import 'package:logging/logging.dart';
import 'package:logging_appenders/logging_appenders.dart';

Future<void> setupLogger({required Level level}) async {
  Logger.root.level = level;

  if (UiPlatform.isDebugMode) {
    PrintAppender(formatter: const ColorFormatter()).attachToLogger(Logger.root);
  } else {
    PrintAppender().attachToLogger(Logger.root);
  }
}
