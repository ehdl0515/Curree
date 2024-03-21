import 'package:flutter/material.dart';
import 'package:logger/logger.dart';


class LoggerProvider with ChangeNotifier {
  final Logger _logger = Logger(
    filter: null,
    printer: PrettyPrinter(
        methodCount: 0, // Number of method calls to be displayed
        errorMethodCount: 8, // Number of method calls if stacktrace is provided
        lineLength: 120, // Width of the output
        colors: true, // Colorful log messages
        printEmojis: true, // Print an emoji for each log message
        printTime: true // Should each log print contain a timestamp
    ),
    output: null,
  );

  Logger get logger => _logger;
}