# Module 12: Advanced Testing

Master advanced testing techniques including mocking, test doubles, and test-driven development practices.

## Learning Objectives

By the end of this module, you will be able to:
- Create and use mock objects for testing
- Implement test doubles (stubs, spies, fakes)
- Practice test-driven development (TDD)
- Test complex async operations
- Organize large test suites effectively

## Key Concepts

### 1. Mocking with Mocktail
```dart
import 'package:mocktail/mocktail.dart';

class MockTaskRepository extends Mock implements TaskRepository {}

void main() {
  test('should handle repository failure', () async {
    final mockRepo = MockTaskRepository();
    final service = TaskService(taskRepository: mockRepo);
    
    when(() => mockRepo.getAllTasks())
        .thenThrow(Exception('Database error'));
    
    expect(
      () => service.getAllTasks(),
      throwsA(isA<TaskServiceException>()),
    );
  });
}
```

### 2. Test-Driven Development
```dart
// 1. Write the test first (RED)
test('should calculate task completion percentage', () {
  final calculator = TaskAnalytics();
  final tasks = [
    Task(/* completed */),
    Task(/* pending */),
    Task(/* completed */),
  ];
  
  expect(calculator.getCompletionPercentage(tasks), equals(66.67));
});

// 2. Implement minimal code to pass (GREEN)
// 3. Refactor for better design (REFACTOR)
```

This module elevates your testing skills to professional standards.

## Next Steps

Ready for [Module 13: JSON and Serialization](../13_json_serialization/README.md)?
