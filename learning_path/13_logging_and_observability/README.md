# 13 – Logging & Observability

## Goals
* Structured logs (JSON) vs human logs
* Log levels & filtering
* Timing operations & simple metrics

## Basic Logger
```dart
enum LogLevel { trace, debug, info, warn, error }

class Logger {
  final LogLevel level;
  const Logger({this.level = LogLevel.info});

  bool _enabled(LogLevel l) => l.index >= level.index;
  void _log(LogLevel l, String msg, [Object? data]) {
    if (!_enabled(l)) return;
    final record = {
      'ts': DateTime.now().toIso8601String(),
      'level': l.name,
      'msg': msg,
      if (data != null) 'data': data,
    };
    print(record); // Could write to file
  }

  void info(String m, [Object? d]) => _log(LogLevel.info, m, d);
  void error(String m, [Object? d]) => _log(LogLevel.error, d);
}
```

## Timing Helper
```dart
Future<T> time<T>(String label, Future<T> Function() op, Logger log) async {
  final start = DateTime.now();
  try { return await op(); } finally {
    final dur = DateTime.now().difference(start);
    log.info('$label completed', {'ms': dur.inMilliseconds});
  }
}
```

## Practice
1. Add rotating log file (max size then rollover).
2. Add log level via environment variable `LOG_LEVEL`.
3. Implement counter metrics (Map<String,int>) printed every 60s.

## Checklist
* [ ] No blocking long IO in hot path
* [ ] Sensitive data redacted
* [ ] Levels respected

## Next
14 (Testing Advanced & Property-Based).
