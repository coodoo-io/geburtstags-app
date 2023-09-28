import 'dart:io';
import 'package:flutter/foundation.dart';

class UiPlatform {
  static bool get isIOS => !kIsWeb && Platform.isIOS;
  static bool get isMacOS => !kIsWeb && Platform.isMacOS;
  static bool get isAndroid => !kIsWeb && Platform.isAndroid;
  static bool get isWindows => !kIsWeb && Platform.isWindows;
  static bool get isLinux => !kIsWeb && Platform.isLinux;
  static bool get isFuchsia => !kIsWeb && Platform.isFuchsia;
  static bool get isWeb => kIsWeb;
  static bool get isMobile => isIOS || isAndroid;
  static bool get isDesktop => isWindows || isMacOS || isLinux;
  static bool get isApple => isIOS || isMacOS;
  static bool get isReleaseMode => kReleaseMode;
  static bool get isDebugMode => kDebugMode;
  static bool get isTestMode => Platform.environment.containsKey('FLUTTER_TEST');
}
