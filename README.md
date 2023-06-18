# chain_of_responsibility_design_pattern_flutter

A new Flutter project.

## Getting Started

This project is a starting point for a Flutter application.

A few resources to get you started if this is your first Flutter project:

- [Lab: Write your first Flutter app](https://docs.flutter.dev/get-started/codelab)
- [Cookbook: Useful Flutter samples](https://docs.flutter.dev/cookbook)

For help getting started with Flutter development, view the
[online documentation](https://docs.flutter.dev/), which offers tutorials,
samples, guidance on mobile development, and a full API reference.

## 1. Research: Chain of Responsibility Design Pattern in Flutter

- Keywords:
    - chain of responsibility design pattern
    - chain of responsibility design pattern in flutter
    - chain of responsibility design pattern with flutter
    - chain pattern design
    - chain of responsibility vs command pattern
    - chain of responsibility design pattern real world example
    - chain of responsibility design pattern flutter
    - chain of responsibility pattern
    - chain of responsibility pattern flutter
    - chain of responsibility pattern java
    - chain of responsibility pattern example
- Video Title: Chain of Responsibility in Flutter | Behavioral Design Patterns in Flutter | Chain Of
  Responsibility Design Pattern in Flutter with Example

## 2. Research: Competitors

**Flutter Videos/Articles**

- https://medium.com/flutter-community/flutter-design-patterns-20-chain-of-responsibility-2ff122624297
- https://kazlauskas.dev/flutter-design-patterns-20-chain-of-responsibility/
- https://scottt2.github.io/design-patterns-in-dart/chain_of_responsibility/
- https://github.com/scottt2/design-patterns-in-dart/tree/master/chain_of_responsibility
- https://github.com/scottt2/design-patterns-in-dart

**Android/Swift/React Videos**

- 15K: https://youtu.be/FafNcoBvVQo
- 20K: https://youtu.be/Izh9x_VoNUg?list=PLmCsXDGbJHdjoepoowHBlbXCBVPdeTGM9
- 140K: https://youtu.be/jDX6x8qmjbA
- 4.6K: https://youtu.be/h9wiLblSRXk
- 2.2K: https://youtu.be/8oftOLkY6sI
- 1.7K: https://youtu.be/2Vh34iOzrt4

**Great Features**

- Decoupling of senders and receivers
- Flexible request handling
- Simplified object interaction
- Runtime configuration and modification
- Hierarchical organization
- Multiple handlers for a request
- Encapsulation of handling logic
- Error handling and fallback mechanisms
- Scalability and reusability
- Clear separation of concerns

**Problems from Videos**

- NA

**Problems from Flutter Stackoverflow**

- https://stackoverflow.com/questions/55979891/is-chain-of-responsibility-pattern-just-an-overkill-a-list-of-handlers-can-acc
- https://stackoverflow.com/questions/34007871/chain-of-responsibility-pass-the-request-through-all-the-chains
- https://stackoverflow.com/questions/41837876/why-would-chain-of-responsibility-be-inappropriate-when-there-is-only-one-handle
- https://stackoverflow.com/questions/9194922/the-chain-of-responsibility-pattern
- https://stackoverflow.com/questions/46359659/chain-of-responsibility-design-pattern-implementation-with-starting-stopping-the
- https://stackoverflow.com/questions/65185252/decorator-vs-chain-of-responsibility-dp
- https://stackoverflow.com/questions/58699902/chain-of-responsibility-handling-more-than-one-request
- https://stackoverflow.com/questions/67302660/decorator-or-chain-of-responsibility

## 3. Video Structure

**Main Points / Purpose Of Lesson**

1. In this video lesson, you will learn how to use chain of responsibility (a type of behavioral
   design pattern) for handling a request with multiple handlers.
2. Main point in this lesson is that I have used Loggers here. Console, Email and File loggers are
   used to handle a request with enum LogLevel.
3. In a nutshell, it is simplified object interaction with multiple handlers.

**The Structured Main Content**

# Chain of Responsibility

## Definition

Chain of Responsibility (CoR), also known as Chain of Command pattern sends data to an object and it
that object can't use it, it sends it to any number of other objects that may be able to use it.

Chain of Responsibility design pattern is an ordered list of message handlers that know how to do
two things — process a specific type of message or pass the message along to the next message
handler.

The Chain of Responsibility pattern allows reordering, adding or removing handlers in the chain at
run-time.

## Analysis

The Chain of Responsibility design pattern should be used when the system is expected to process
different kinds of requests in various ways, but neither the request types nor the handling sequence
is defined at compile time. The pattern enables linking several handlers into one chain and allowing
the client to pass requests along that chain. As a result, each handler will receive the request,
process it, and/or pass it further.

Furthermore, the CoR pattern should be used when a single request must be handled by multiple
handlers, usually in a particular order. In this case, the chain could be defined at compile-time
and all requests will get through the chain exactly as planned.

One thing to remember — **the receipt isn’t guaranteed**. Since CoR introduces the loose
coupling between sender and receiver, and the request could be handled by any handler in the chain,
there is no guarantee that it will be actually handled. In cases when the request must be processed
by at least one handler, you must ensure that the chain is configured properly, for instance, by
adding some kind of a monitor handler at the end of the chain that notifies about unhandled requests
and/or executes some specific logic.

## Implementation

1. In `log_level.dart` file, define LogLevel enum:

```dart
enum LogLevel {
  none,
  info,
  debug,
  warning,
  error,
  functionalMessage,
  functionalError,
}
```

2. `ConsoleLogger`, `EmailLogger`, and `FileLogger` classes are extending an abstract class which
   is `BaseLogger`:

```dart
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
```

- It has default constructor `BaseLogger(this.levels);` which is calling `Set<LogLevel>` from
  log_level.dart file.
- A variable named `next` of type `BaseLogger` class is used to go to the next logger.
- `writeMessage()` method is used in `log()` method and it is overrided for the classes which are
  extending from BaseLogger.
- `log(LogLevel level, String msg)` method calls `writeMessage()` method:
    - Inside if statement, it checks if `Set<LogLevel>` which is named `levels` variable here,
      contains level passed to this `log` method. If it has then call writeMessage.
    - Outside if statement, it checks if has next log level or not which is defined in `main.dart`
      file then call `log` method again which calls writeMessage.

3. In `main.dart` file, initialize consoleLogger, emailLogger, and fileLogger. Also set next
   property of consoleLogger and emailLogger.
    - For `consoleLogger`, define _all_ `Set<LogLevel>` which are defined in enum
      of `log_level.dart`.
    - For `emailLogger`, define two log levels `functionalMessage` and `functionalError`.
    - For `emailLogger`, define two log levels `warning` and `error`.
    - next to consoleLogger is emailLogger and next to emailLogger is fileLogger.

```dart 
final consoleLogger = ConsoleLogger(LogLevel.values.toSet());
final emailLogger =
EmailLogger({LogLevel.functionalMessage, LogLevel.functionalError});
final fileLogger = FileLogger({LogLevel.warning, LogLevel.error});

consoleLogger.next = emailLogger;
emailLogger.next = fileLogger;
```

**Main code of chain with output on console:**

1. `consoleLogger.log(LogLevel.debug, "Some amazingly helpful debug message");`
    - It will print `[ConsoleLogger]: Some amazingly helpful debug message` because ConsoleLogger
      has all levels including `debug` level and this `debug` level is not present in emailLogger
      and fileLogger.
2. `consoleLogger.log(LogLevel.info, "Pretty important information");`
    - It will print `[ConsoleLogger]: Pretty important information` because ConsoleLogger
      has all levels including `info` level and this `info` level is not present in emailLogger and
      fileLogger.
3. `consoleLogger.log(LogLevel.warning, "This is a warning!");`
    - It will print `[ConsoleLogger]: This is a warning!` and `[FileLogger]: This is a warning!`
      because ConsoleLogger has all levels including `warning` level and this `warning` level is
      also present in fileLogger.
4. `consoleLogger.log(LogLevel.error, "This shows an error!");`
    - It will print `[ConsoleLogger]: This shows an error!` and `[FileLogger]: This shows an error!`
      because ConsoleLogger has all levels including `error` level and this `error` level is also
      present in fileLogger.
5. `consoleLogger.log(LogLevel.functionalError, "This is not a show stopper");`
    - It will print `[ConsoleLogger]: This is not a show stopper`
      and `[EmailLogger]: This is not a show stopper` because ConsoleLogger has all levels
      including `functionalError` level and this `functionalError` level is also present in
      emailLogger.
6. `consoleLogger.log(LogLevel.functionalMessage, "This is basically just info");`
    - It will print `[ConsoleLogger]: This is basically just info`
      and `[EmailLogger]: This is basically just info` because ConsoleLogger has all levels
      including `functionalMessage` level and this `functionalMessage` level is also present in
      emailLogger.
