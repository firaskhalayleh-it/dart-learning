# 06 – Async: Futures & Streams (Concurrency & Patterns)

## Goals
* Understand event loop & microtask queue
* Distinguish `Future` (one-shot) vs `Stream` (multi-event)
* Compose async tasks: sequencing, parallel, racing
* Implement cancellation & timeouts
* Transform streams & handle backpressure conceptually

## Event Loop Insight
```dart
Future<void> order() async {
  print('A');
  Future(() => print('B macro')); // scheduled
  scheduleMicrotask(() => print('C micro')); // before next event
  print('D');
  await Future.delayed(Duration.zero);
  print('E');
}
// Output order: A, D, C micro, B macro, E
```

## Futures – Patterns
```dart
Future<Task> simulateNetworkCreate(Task t) async {
  await Future.delayed(const Duration(milliseconds: 200));
  return t;
}

Future<List<Task>> createBatch(List<Task> list) => Future.wait(list.map(simulateNetworkCreate));

Future<Task> firstCompleted(List<Future<Task>> futures) => Future.any(futures);

Future<Task> withTimeout(Future<Task> f) => f.timeout(const Duration(seconds: 2),
  onTimeout: () => Task.newTodo('Timeout placeholder'));
```

## Converting Callback to Future
```dart
Future<int> legacyToFuture(void Function(void Function(int)) api) {
  final c = Completer<int>();
  try {
    api((value) => c.complete(value));
  } catch (e, st) { c.completeError(e, st); }
  return c.future;
}
```

## Streams – Creation & Transformation
```dart
Stream<int> ticker(int count, Duration gap) async* {
  for (var i = 0; i < count; i++) {
    await Future.delayed(gap);
    yield i;
  }
}

Stream<Task> promoteUrgent(Stream<Task> source) => source
  .where((t) => t.status is! Done)
  .map((t) => t.dueAt != null && t.dueAt!.isBefore(DateTime.now().add(const Duration(hours: 2)))
      ? t.copyWith(priority: 1) : t);
```

## Broadcast vs Single Subscription
```dart
final controller = StreamController<Task>.broadcast();
// Multiple listeners allowed
```

## Merging & Zipping
```dart
Stream<T> merge<T>(Stream<T> a, Stream<T> b) async* {
  yield* a;
  yield* b;
}
```

## Debounce Utility
```dart
Stream<T> debounce<T>(Stream<T> source, Duration d) {
  Timer? timer;
  StreamController<T>? ctrl;
  void onData(T data) {
    timer?.cancel();
    timer = Timer(d, () => ctrl!.add(data));
  }
  void onDone() { timer?.cancel(); ctrl?.close(); }
  ctrl = StreamController<T>(
    onListen: () => source.listen(onData, onError: ctrl!.addError, onDone: onDone),
    onCancel: () { timer?.cancel(); },
  );
  return ctrl.stream;
}
```

## Cancellation
```dart
final sub = ticker(5, const Duration(milliseconds: 300)).listen(print);
Future.delayed(const Duration(milliseconds: 650), () => sub.cancel());
```

## Error Handling in Streams
```dart
Stream<int> faulty() async* {
  yield 1; yield 2; throw Exception('boom');
}

faulty().handleError((e) => print('Caught: $e')).listen(print);
```

## Parallel vs Sequential
```dart
Future<List<T>> sequential<T>(List<Future<T> Function()> tasks) async {
  final results = <T>[];
  for (final t in tasks) { results.add(await t()); }
  return results;
}

Future<List<T>> parallel<T>(List<Future<T> Function()> tasks) => Future.wait(tasks.map((t) => t()));
```

## Backpressure Concept (Conceptual Only)
If producer emits faster than consumer processes, consider buffering + throttling (not built-in; design pattern with controllers & queue length checks).

## Practice
1. Implement `race<T>(List<Future<T>> futures)` returning first success or throwing AggregateError if all fail.
2. Create a `throttle<T>(Stream<T>, Duration)` similar to debounce but emits leading value immediately.
3. Build a `retryAsync<T>(Future<T> Function(), {int times = 3, Duration delay = const Duration(milliseconds:200)})`.
4. Compose: read tasks stream + status updates stream → produce enriched tasks.

## Edge Cases
* Cancelled subscriptions not freeing timers
* Double listening to single-subscription stream
* Swallowing errors inside `catch` without logging

## Checklist
* [ ] Distinguish Future vs Stream use-cases clearly
* [ ] Implemented debounce or throttle util
* [ ] Properly cancelled subscriptions in examples
* [ ] Avoided unawaited futures (or documented intentionally)

## Next
Proceed to 07 (Error Handling & Testing) for robustness.
