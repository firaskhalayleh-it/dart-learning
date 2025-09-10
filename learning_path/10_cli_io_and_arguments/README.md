# 10 – CLI I/O & Arguments

## Goals
* Parse command-line arguments (`args` package or manual)
* Read stdin, write stdout/stderr
* Exit codes & error reporting

## Manual Argument Parsing
```dart
void main(List<String> args) {
  final map = <String,String>{};
  for (var i = 0; i < args.length; i++) {
    final a = args[i];
    if (a.startsWith('--')) {
      final key = a.substring(2);
      final value = (i + 1 < args.length && !args[i+1].startsWith('--')) ? args[++i] : 'true';
      map[key] = value;
    }
  }
  print(map);
}
```

## Stdin Streaming
```dart
import 'dart:convert';
import 'dart:io';

Future<void> consume() async {
  stdout.writeln('Enter lines (type quit to stop)');
  await for (final line in stdin.transform(utf8.decoder).transform(const LineSplitter())) {
    if (line == 'quit') break;
    stdout.writeln('Echo: $line');
  }
}
```

## Exit Codes
```dart
import 'dart:io';
void fail(String message, {int code = 64}) { // 64: command line usage error
  stderr.writeln('ERROR: $message');
  exit(code);
}
```

## Practice
1. Build a `task_cli.dart` that supports: `--add "Title"`, `--list`, `--done <id>`.
2. Add JSON output mode `--json` for scripting.
3. Support pipeline input: `cat tasks.txt | dart run bin/task_cli.dart --import`.

## Checklist
* [ ] Graceful help message
* [ ] Non-zero exit codes for errors
* [ ] No interactive prompts in non-TTY mode

## Next
Proceed to 11 (HTTP & JSON). 
