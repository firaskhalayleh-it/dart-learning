# Module 5: Enums and Pattern Matching

In this module, you'll learn about Dart's powerful enum types and pattern matching capabilities, including the new features introduced in Dart 3.

## Learning Objectives

By the end of this module, you will be able to:
- Create and use enum types effectively
- Understand enhanced enums with methods and properties
- Use switch expressions for pattern matching
- Apply sealed classes for exhaustive matching
- Implement the State pattern using enums

## Key Concepts

### 1. Basic Enums
Enums represent a fixed set of constant values:

```dart
enum TaskStatus {
  pending,
  inProgress,
  completed,
  cancelled,
}

enum TaskPriority {
  low,
  normal,
  high,
  critical,
}
```

### 2. Enhanced Enums (Dart 2.17+)
Enums can have constructors, methods, and properties:

```dart
enum TaskPriority {
  low(1, 'Low Priority', '🔵'),
  normal(2, 'Normal Priority', '🟢'),
  high(3, 'High Priority', '🟡'),
  critical(4, 'Critical Priority', '🔴');

  const TaskPriority(this.value, this.displayName, this.icon);
  
  final int value;
  final String displayName;
  final String icon;
  
  bool get isUrgent => this == high || this == critical;
  
  String get description {
    switch (this) {
      case TaskPriority.low:
        return 'Can be done when time permits';
      case TaskPriority.normal:
        return 'Should be completed in reasonable time';
      case TaskPriority.high:
        return 'Should be completed soon';
      case TaskPriority.critical:
        return 'Needs immediate attention';
    }
  }
}
```

### 3. Switch Expressions (Dart 3.0+)
More concise than switch statements:

```dart
String getStatusDescription(TaskStatus status) {
  return switch (status) {
    TaskStatus.pending => 'Task is waiting to be started',
    TaskStatus.inProgress => 'Task is currently being worked on',
    TaskStatus.completed => 'Task has been finished',
    TaskStatus.cancelled => 'Task was cancelled',
  };
}

String getStatusIcon(TaskStatus status) => switch (status) {
  TaskStatus.pending => '⭕',
  TaskStatus.inProgress => '🔄',
  TaskStatus.completed => '✅',
  TaskStatus.cancelled => '❌',
};
```

### 4. Pattern Matching with Records
Combine multiple values in pattern matching:

```dart
String getTaskAdvice(TaskStatus status, TaskPriority priority) {
  return switch ((status, priority)) {
    (TaskStatus.pending, TaskPriority.critical) => 'Start immediately!',
    (TaskStatus.pending, TaskPriority.high) => 'Start soon',
    (TaskStatus.inProgress, TaskPriority.critical) => 'Focus on this',
    (TaskStatus.completed, _) => 'Well done!',
    (TaskStatus.cancelled, _) => 'Task was cancelled',
    _ => 'Continue as planned',
  };
}
```

### 5. Sealed Classes (Dart 3.0+)
For exhaustive pattern matching with classes:

```dart
sealed class TaskEvent {}

class TaskCreated extends TaskEvent {
  final String taskId;
  final String title;
  TaskCreated(this.taskId, this.title);
}

class TaskStarted extends TaskEvent {
  final String taskId;
  TaskStarted(this.taskId);
}

class TaskCompleted extends TaskEvent {
  final String taskId;
  final DateTime completedAt;
  TaskCompleted(this.taskId, this.completedAt);
}

// Switch expression with sealed classes
String handleTaskEvent(TaskEvent event) {
  return switch (event) {
    TaskCreated(taskId: var id, title: var title) => 
      'Task "$title" created with ID: $id',
    TaskStarted(taskId: var id) => 
      'Task $id started',
    TaskCompleted(taskId: var id, completedAt: var time) => 
      'Task $id completed at $time',
  };
}
```

## Examples

Study the examples in the `examples/` directory:
- `basic_enums.dart` - Simple enum usage
- `enhanced_enums.dart` - Enums with methods and properties
- `switch_expressions.dart` - Pattern matching with switch expressions
- `sealed_classes.dart` - Exhaustive matching with sealed classes
- `task_state_machine.dart` - State pattern implementation

## Exercises

Complete the exercises in the `exercises/` directory:

### Exercise 1: User Role Enum
Create an enhanced enum for user roles with permissions.

### Exercise 2: Task Filter System
Build a filtering system using pattern matching.

### Exercise 3: Notification Types
Implement a notification system using sealed classes.

## Testing Your Understanding

Make sure you can:
- Create and use basic enums
- Add methods and properties to enums
- Use switch expressions effectively
- Implement exhaustive pattern matching
- Choose between enums and sealed classes appropriately

## Next Steps

Ready for [Module 6: Error Handling](../06_error_handling/README.md)?

## Additional Resources

- [Dart Enums](https://dart.dev/guides/language/language-tour#enumerations)
- [Pattern Matching](https://dart.dev/language/patterns)
- [Sealed Classes](https://dart.dev/language/class-modifiers#sealed)