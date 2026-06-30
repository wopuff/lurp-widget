import 'package:flutter/foundation.dart';
import 'dart:developer' as developer;

enum LurpLogLevel {
  trace(0),
  debug(500),
  info(800),
  warning(900),
  error(1000),
  fatal(2000);

  const LurpLogLevel(this.value);
  final int value;
}

class LurpLogger {
  const LurpLogger();

  void i(
    dynamic message, {
    Object? error,
    StackTrace? stackTrace,
  }) {
    _log(LurpLogLevel.info, message, error, stackTrace);
  }

  void e(
    dynamic message, {
    Object? error,
    StackTrace? stackTrace,
  }) {
    _log(LurpLogLevel.error, message, error, stackTrace);
  }

  void _log(LurpLogLevel level, dynamic message, Object? error, StackTrace? stackTrace) {
    final timeStr = DateTime.now().toIso8601String().substring(11, 19);
    final levelStr = level.name.toUpperCase();
    
    final StringBuffer buffer = StringBuffer();
    buffer.write('[$timeStr] $levelStr: $message');
    if (error != null) {
      buffer.write('\nError: $error');
    }
    if (stackTrace != null) {
      buffer.write('\n$stackTrace');
    }

    final msg = buffer.toString();
    developer.log(
      msg,
      name: 'lurp_poll',
      level: level.value,
      error: error,
      stackTrace: stackTrace,
    );

    if (kIsWeb) {
      // ignore: avoid_print
      print(msg);
    }
  }
}

final logger = LurpLogger();
