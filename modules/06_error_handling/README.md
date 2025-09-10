# Module 6: Error Handling

Learn how to handle errors gracefully in Dart applications using exceptions, try-catch blocks, and error recovery patterns.

## Learning Objectives

By the end of this module, you will be able to:
- Handle exceptions with try-catch-finally blocks
- Create custom exception classes
- Implement error recovery strategies
- Use Result patterns for better error handling
- Apply defensive programming techniques

## Key Concepts

### 1. Exception Handling
```dart
Future<Task> loadTask(String id) async {
  try {
    final task = await repository.getTaskById(id);
    if (task == null) {
      throw TaskNotFoundException('Task with ID $id not found');
    }
    return task;
  } on TaskNotFoundException {
    rethrow; // Let caller handle this specific error
  } catch (e) {
    throw TaskLoadException('Failed to load task: $e');
  }
}
```

### 2. Custom Exceptions
```dart
abstract class TaskException implements Exception {
  final String message;
  const TaskException(this.message);
  
  @override
  String toString() => 'TaskException: $message';
}

class TaskNotFoundException extends TaskException {
  const TaskNotFoundException(super.message);
}

class TaskValidationException extends TaskException {
  final Map<String, String> errors;
  const TaskValidationException(super.message, this.errors);
}
```

This module builds robust error handling into your task management system.

## Next Steps

Ready for [Module 7: Collections Deep Dive](../07_collections_deep/README.md)?
