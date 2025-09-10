# Module 11: Testing Fundamentals

In this module, you'll learn the fundamentals of testing in Dart, including unit tests, test organization, and testing best practices.

## Learning Objectives

By the end of this module, you will be able to:
- Write unit tests using the test package
- Organize tests effectively
- Use test matchers and assertions
- Test asynchronous code
- Apply test-driven development (TDD) principles
- Test your task tracker components

## Key Concepts

### 1. Introduction to Testing
Testing ensures your code works correctly and prevents regressions:

```dart
import 'package:test/test.dart';

void main() {
  test('should create a task with correct properties', () {
    // Arrange
    final task = Task(
      id: 'test_123',
      title: 'Test Task',
      createdAt: DateTime.now(),
    );
    
    // Act & Assert
    expect(task.id, equals('test_123'));
    expect(task.title, equals('Test Task'));
    expect(task.status, equals(TaskStatus.pending));
  });
}
```

### 2. Test Organization
Group related tests and use setUp/tearDown:

```dart
void main() {
  group('Task Tests', () {
    late Task task;
    
    setUp(() {
      task = Task(
        id: 'test_123',
        title: 'Test Task',
        createdAt: DateTime.now(),
      );
    });
    
    test('should be pending by default', () {
      expect(task.status, equals(TaskStatus.pending));
    });
    
    test('should update status correctly', () {
      final updatedTask = task.copyWith(status: TaskStatus.completed);
      expect(updatedTask.status, equals(TaskStatus.completed));
    });
  });
}
```

### 3. Testing Async Code
Test asynchronous operations properly:

```dart
void main() {
  test('should load tasks asynchronously', () async {
    // Arrange
    final repository = InMemoryTaskRepository();
    final service = TaskService(taskRepository: repository);
    
    // Act
    final tasks = await service.getAllTasks();
    
    // Assert
    expect(tasks, isEmpty);
  });
  
  test('should handle async errors', () async {
    final service = TaskService(taskRepository: FailingRepository());
    
    expect(
      () => service.getAllTasks(),
      throwsA(isA<TaskServiceException>()),
    );
  });
}
```

### 4. Test Matchers
Use expressive matchers for better test readability:

```dart
void main() {
  test('demonstrates various matchers', () {
    final task = Task(id: '123', title: 'Test', createdAt: DateTime.now());
    
    // Equality matchers
    expect(task.id, equals('123'));
    expect(task.title, isNotEmpty);
    
    // Type matchers
    expect(task, isA<Task>());
    expect(task.createdAt, isA<DateTime>());
    
    // Collection matchers
    expect(task.tags, isEmpty);
    expect(task.tags, hasLength(0));
    
    // Boolean matchers
    expect(task.isCompleted, isFalse);
    expect(task.isOverdue, isFalse);
    
    // String matchers
    expect(task.title, contains('Test'));
    expect(task.id, startsWith('1'));
    
    // Null matchers
    expect(task.description, isNull);
    expect(task.assignedTo, isNull);
  });
}
```

## Examples

Study the examples in the `examples/` directory:
- `basic_testing.dart` - Simple unit tests
- `async_testing.dart` - Testing asynchronous code
- `matcher_examples.dart` - Using different test matchers
- `task_service_tests.dart` - Real-world testing example

## Exercises

Complete the exercises in the `exercises/` directory:

### Exercise 1: Task Model Tests
Write comprehensive tests for the Task class.

### Exercise 2: Repository Tests
Test the InMemoryTaskRepository implementation.

### Exercise 3: Service Layer Tests
Create tests for TaskService business logic.

## Testing Best Practices

1. **AAA Pattern**: Arrange, Act, Assert
2. **One assertion per test**: Keep tests focused
3. **Descriptive names**: Test names should explain what's being tested
4. **Independent tests**: Tests shouldn't depend on each other
5. **Test edge cases**: Include boundary conditions and error cases

## Next Steps

Ready for [Module 12: Advanced Testing](../12_advanced_testing/README.md)?

## Additional Resources

- [Dart Testing](https://dart.dev/guides/testing)
- [Test Package Documentation](https://pub.dev/packages/test)