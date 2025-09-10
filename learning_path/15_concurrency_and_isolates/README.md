# 15 – Concurrency & Isolates

## Goals
* Understand isolates vs threads conceptually
* Use `Isolate.spawn` for CPU-bound work
* Share data via message passing (ports)

## Basic Spawn
```dart
import 'dart:isolate';

void worker(SendPort send) {
  var sum = 0;
  for (var i = 0; i < 5_000_000; i++) { sum += i; }
  send.send(sum);
}

Future<void> run() async {
  final receive = ReceivePort();
  await Isolate.spawn(worker, receive.sendPort);
  final result = await receive.first;
  print('Sum=$result');
}
```

## Two-Way Communication
```dart
void calculator(List<dynamic> args) {
  final SendPort mainPort = args[0];
  final ReceivePort port = ReceivePort();
  mainPort.send(port.sendPort);
  port.listen((message) {
    if (message is (int, int)) {
      final (a,b) = message;
      mainPort.send(a + b);
    }
  });
}
```

## Practice
1. Implement a pool of 4 isolates processing tasks from a queue.
2. Add graceful shutdown sequence.
3. Benchmark isolate vs inline for small vs large workloads.

## Checklist
* [ ] No shared mutable state across isolates
* [ ] Ports closed after use
* [ ] Benchmark justifies isolate cost

## Next
16 (Security & Validation Basics).
