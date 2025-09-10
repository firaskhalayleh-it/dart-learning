# 06 – Async: Futures & Streams

## Goals
- `Future`, `async`/`await`, error handling
- `Stream` (single-subscription vs broadcast)
- Stream transformations & cancellation
- Combining multiple async sources

## Examples
```dart
Future<Task> simulateNetworkCreate(Task t) async {
  await Future.delayed(const Duration(milliseconds: 300));
  return t; // pretend persisted
}

Stream<int> ticker(int count, Duration gap) async* {
  for (var i = 0; i < count; i++) {
    await Future.delayed(gap);
    yield i;
  }
}

Future<void> run() async {
  final created = await simulateNetworkCreate(
    Task(id: '1', title: 'Async Demo', createdAt: DateTime.now()),
  );
  print('Created: ${created.title}');

  final sub = ticker(3, const Duration(milliseconds: 200))
    .listen(print, onDone: () => print('Done'));
  await sub.asFuture();
}
```

## Stream Transformation
```dart
Stream<Task> taskUpdates(Stream<Task> source) => source
  .where((t) => t.status is! Done)
  .map((t) => t.copyWith(priority: 1));
```

## Practice
1. Wrap a callback-based API into a `Future` using `Completer`.
2. Merge two streams (`StreamZip` from `async` package or manual) – tasks + status updates.
3. Implement debounced search input logic with streams.

## Checklist
- [ ] Comfort with `async` / `await`
- [ ] Can explain difference between `Future` and `Stream`
- [ ] Implemented transformation & cancellation

## Next
Error handling & testing (07) to improve resilience.
