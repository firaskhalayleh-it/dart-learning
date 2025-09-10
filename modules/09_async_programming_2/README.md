# Module 9: Async Programming II - Streams

Learn about Dart Streams for handling sequences of asynchronous events and building reactive applications.

## Learning Objectives

By the end of this module, you will be able to:
- Create and consume Streams
- Transform streams with map, where, and other operators
- Handle stream errors and completion
- Build reactive task management features
- Understand the difference between single-subscription and broadcast streams

## Key Concepts

### 1. Introduction to Streams
```dart
// Creating a stream of task updates
Stream<List<Task>> watchTasks() {
  return _taskController.stream;
}

final StreamController<List<Task>> _taskController = 
    StreamController<List<Task>>.broadcast();
```

### 2. Stream Transformations
```dart
// Filter completed tasks
Stream<List<Task>> get completedTasks => 
  watchTasks().map((tasks) => 
    tasks.where((task) => task.isCompleted).toList()
  );

// Get task count updates
Stream<int> get taskCount => 
  watchTasks().map((tasks) => tasks.length);
```

### 3. Real-time Task Updates
```dart
class TaskStreamService {
  final StreamController<TaskEvent> _eventController = 
      StreamController<TaskEvent>.broadcast();
  
  Stream<TaskEvent> get events => _eventController.stream;
  
  void addTask(Task task) {
    _eventController.add(TaskAdded(task));
  }
  
  void updateTask(Task task) {
    _eventController.add(TaskUpdated(task));
  }
}
```

This module enables real-time reactive features in your applications.

## Next Steps

Ready for [Module 10: Libraries and Packages](../10_libraries_packages/README.md)?
