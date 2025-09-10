# 07 – Error Handling & Testing

## Goals
- `try / catch / finally`, custom exceptions
- Functional error representations (sealed Failure types)
- Unit tests, mock/fake patterns
- Golden path vs edge cases

## Error Pattern Example
```dart
sealed class Failure { const Failure(); }
class NetworkFailure extends Failure { final int? code; const NetworkFailure([this.code]); }
class NotFoundFailure extends Failure { const NotFoundFailure(); }
class UnknownFailure extends Failure { final Object error; const UnknownFailure(this.error); }

Future<(Task?, Failure?)> safeFetch(Future<Task> Function() op) async {
  try {
    final t = await op();
    return (t, null);
  } on HttpException catch (e) {
    return (null, NetworkFailure(e.hashCode));
  } catch (e) {
    return (null, UnknownFailure(e));
  }
}
```

## Testing Skeleton
```dart
// test/task_repository_test.dart
import 'package:test/test.dart';
import '../lib/task_repository.dart';

void main() {
  group('TaskRepository', () {
    test('creates & retrieves task', () async {
      final repo = InMemoryTaskRepository();
      final task = Task(id: '1', title: 'Test', createdAt: DateTime.now());
      await repo.create(task);
      expect(await repo.getById('1'), isNotNull);
    });
  });
}
```

## Practice
1. Write tests for `copyWith` behaviors.
2. Simulate a network failure & assert correct Failure type returned.
3. Add a test ensuring overdue filter logic is correct.

## Checklist
- [ ] Uses sealed failures instead of throwing everywhere
- [ ] Has at least one unit test suite
- [ ] Understands when to rethrow vs wrap errors

## Next
Flutter Fundamentals (08) to move from console to UI.
