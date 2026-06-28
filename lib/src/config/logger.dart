import 'package:flutter/foundation.dart';
import 'package:logger/logger.dart';
import 'dart:developer' as developer;

final Logger logger = Logger(
  printer: CustomLogPrinter(),
  output: CustomLogOutput(),
);

class CustomLogPrinter extends LogPrinter {
  final LogPrinter _realPrinter = PrettyPrinter(
    colors: true,
    lineLength: 5,
    dateTimeFormat: DateTimeFormat.none,
    printEmojis: true,
  );

  @override
  List<String> log(LogEvent event) {
    return _realPrinter.log(event);
  }
}

class CustomLogOutput extends LogOutput {
  @override
  void output(OutputEvent event) {
    final messageBlock = event.lines.join('\n');

    developer.log(
      messageBlock,
      name: 'lurp_poll',
      level: _mapLogLevel(event.level),
    );

    if (kIsWeb) {
      // ignore: avoid_print
      print(messageBlock);
    }
  }

  int _mapLogLevel(Level level) {
    switch (level) {
      case Level.trace:
        return 0;
      case Level.debug:
        return 500;
      case Level.info:
        return 800;
      case Level.warning:
        return 900;
      case Level.error:
        return 1000;
      case Level.fatal:
        return 2000;
      default:
        return 0;
    }
  }
}
