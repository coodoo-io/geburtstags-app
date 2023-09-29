import 'dart:async';

import 'package:flutter_riverpod/flutter_riverpod.dart';

extension on AutoDisposeRef {
  /// When invoked keeps your provider alive for [duration]
  // ignore: unused_element
  void cacheFor(Duration duration) {
    final link = keepAlive();
    final timer = Timer(duration, () => link.close());
    onDispose(() => timer.cancel());
  }
}
