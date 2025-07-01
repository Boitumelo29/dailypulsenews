import 'package:logger/logger.dart';

var logger = Logger();

void logI(Object message) => logger.i(message.toString());

void logW(Object message) => logger.w(
      message.toString(),
    );

void logE(Object message) => logger.e(message.toString(), error: "Error");

void logF(Object message, Object error, StackTrace stackTrace) =>
    logger.f(message.toString(), error: error, stackTrace: stackTrace);
