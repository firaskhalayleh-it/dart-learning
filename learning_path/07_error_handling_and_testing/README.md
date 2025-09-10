# 07 – Error Handling & Testing (Resilience & Quality)

## Goals
* Distinguish exceptions vs domain failures
* Implement safe execution wrappers (sync & async)
* Write focused unit tests & property-based style checks
* Use test doubles: dummy, fake, stub, mock
* Ensure error paths have coverage (not only happy path)

## Exceptions vs Failures
* Exceptions: unexpected (IO errors, parsing issues) – thrown
* Failures: expected domain conditions (validation, not found) – represented as values (sealed types)

## Failure Hierarchy
```dart
sealed class Failure { const Failure(); }
class NetworkFailure extends Failure { final int? code; const NetworkFailure([this.code]); }
class NotFoundFailure extends Failure { const NotFoundFailure(); }
class ValidationFailure extends Failure { final String message; const ValidationFailure(this.message); }
class UnknownFailure extends Failure { final Object error; final StackTrace stack; const UnknownFailure(this.error, this.stack); }
```

## Safe Async Wrapper (Result via Record)
```dart
Future<({T? data, Failure? failure})> guard<T>(Future<T> Function() op) async {
  try {
    final v = await op();
    return (data: v, failure: null);
  } on FormatException catch (e, st) {
    return (data: null, failure: ValidationFailure(e.message));
  } on HttpException catch (e, st) {
    return (data: null, failure: NetworkFailure(e.hashCode));
  } catch (e, st) {
    return (data: null, failure: UnknownFailure(e, st));
  }
}
```

## Sync Guard
```dart
({T? data, Failure? failure}) guardSync<T>(T Function() op) {
  try { return (data: op(), failure: null); } catch (e, st) { return (data: null, failure: UnknownFailure(e, st)); }
}
```

## Retrying Pattern
```dart
Future<T> retry<T>(Future<T> Function() op, {int times = 3, Duration delay = const Duration(milliseconds:200)}) async {
  late Object lastError; late StackTrace lastSt;
  for (var attempt = 0; attempt < times; attempt++) {
    try { return await op(); } catch (e, st) { lastError = e; lastSt = st; await Future.delayed(delay); }
  }
  // ignore: only_throw_errors
  throw lastError; // escalate after attempts exhausted
}
```

## Custom Exception Example
```dart
class CacheMissException implements Exception {
  final String key; CacheMissException(this.key);
  @override String toString() => 'CacheMissException: $key';
}
```

## Test Structure Philosophy
Arrange – Act – Assert (AAA):
```dart
test('toggles done', () {
  // Arrange
  final t = Task.newTodo('Sample');
  // Act
  final toggled = t.copyWith(title: t.title); // placeholder; maybe implement toggle method
  // Assert
  expect(toggled.id, equals(t.id));
});
```

## Example Repository Fake
```dart
class FakeTaskRepo {
  final _map = <String, Task>{};
  Future<Task> create(Task t) async => _map[t.id] = t;
  Future<Task?> get(String id) async => _map[id];
}
```

## Property-Based Style Idea (Manual)
```dart
void propertyTestGenerateLengths() {
  for (var i = 0; i < 100; i++) {
    final len = i;
    final s = 'a' * len;
    assert(s.length == len);
  }
}
```

## Test Organization Tips
* One logical assertion per test (or grouped asserts around one behavior)
* Name tests with intent: `repository returns null for missing id`
* Avoid hidden global state; use fresh instances per test

## Edge Cases To Test
| Case | Why |
|------|-----|
| Empty collections | Avoid reduce errors |
| Null inputs (when allowed) | Validate guards |
| Boundary numbers (0, -1) | Off-by-one detection |
| Large lists | Performance regression risk |
| Unexpected status string in JSON | Robust parsing |

## Coverage Targets (Guideline)
* Core domain entities: 90%+
* Utility pure functions: 100% feasible
* Async wrappers: ensure both success & failure paths

## Practice
1. Write tests for `groupByPriority` including empty input.
2. Ensure `retry` stops after N failures (spy with counter variable).
3. Validate `guard` returns `ValidationFailure` for `FormatException`.
4. Add a test ensuring JSON round-trip integrity for `Task`.

## Checklist
* [ ] Failure types exhaustive and documented
* [ ] Async + sync guards implemented
* [ ] Retry logic tested for success after transient failure
* [ ] Negative paths (errors) have assertions

## Next
Continue to next modules or integrate tests incrementally as you add features.
