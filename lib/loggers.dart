import 'log_level.dart';

abstract interface class BaseLogger {
  final Set<LogLevel> levels;
  BaseLogger? next;

  BaseLogger(this.levels);

  void writeMessage(String msg);

  void log(LogLevel level, String msg) {
    if (levels.contains(level) || levels.containsAll(LogLevel.values)) {
      writeMessage(msg);
    }
    next?.log(level, msg);
  }
}

class ConsoleLogger extends BaseLogger {
  ConsoleLogger(super.levels);

  @override
  void writeMessage(msg) => print("[ConsoleLogger]: $msg");
}

class EmailLogger extends BaseLogger {
  EmailLogger(super.levels);

  @override
  void writeMessage(String msg) => print("[EmailLogger]: $msg");
}

class FileLogger extends BaseLogger {
  FileLogger(super.levels);

  @override
  void writeMessage(String msg) => print("[FileLogger]: $msg");
}
