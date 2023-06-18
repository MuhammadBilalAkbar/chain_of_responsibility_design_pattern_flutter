import 'loggers.dart';
import 'log_level.dart';

void main() {
  final consoleLogger = ConsoleLogger(LogLevel.values.toSet());
  final emailLogger =
      EmailLogger({LogLevel.functionalMessage, LogLevel.functionalError});
  final fileLogger = FileLogger({LogLevel.warning, LogLevel.error});

  consoleLogger.next = emailLogger;
  emailLogger.next = fileLogger;

  consoleLogger.log(LogLevel.debug, "Some amazingly helpful debug message");
  // Output on console:
  // [ConsoleLogger]: Some amazingly helpful debug message
  consoleLogger.log(LogLevel.info, "Pretty important information");
  // Output on console:
  // [ConsoleLogger]: Pretty important information

  consoleLogger.log(LogLevel.warning, "This is a warning!");
  // Output on console:
  // [ConsoleLogger]: This is a warning!
  // [FileLogger]: This is a warning!
  consoleLogger.log(LogLevel.error, "This shows an error!");
  // Output on console:
  // [ConsoleLogger]: This shows an error!
  // [FileLogger]: This shows an error!

  consoleLogger.log(LogLevel.functionalError, "This is not a show stopper");
  // Output on console:
  // [ConsoleLogger]: This is not a show stopper
  // [EmailLogger]: This is not a show stopper
  consoleLogger.log(LogLevel.functionalMessage, "This is basically just info");
  // Output on console:
  // [ConsoleLogger]: This is basically just info
  // [EmailLogger]: This is basically just info
}
