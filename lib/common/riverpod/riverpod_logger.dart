import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:logging/logging.dart';

/// Riverpod logger class
class RiverpodLogger extends ProviderObserver {
  @override
  void didUpdateProvider(
    ProviderBase provider,
    Object? previousValue,
    Object? newValue,
    ProviderContainer container,
  ) {
    // final logger = container.read(loggerProvider);
    final error = newValue is AsyncError ? newValue : null;
    if (error != null) {
      // logger.logError(error);
      Logger.root.info('RiverpodLogger: $error');
    }
    // '''
    //   {
    //   "provider": "${provider.name ?? provider.runtimeType}",
    //   "newValue": "$newValue"
    //   }''',
  }
}
