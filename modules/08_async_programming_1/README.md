# Module 8: Async Programming I - Futures

In this module, you'll learn about asynchronous programming in Dart using Futures and async/await syntax.

## Learning Objectives

By the end of this module, you will be able to:
- Understand the concept of asynchronous programming
- Work with Future objects and async/await syntax
- Handle errors in asynchronous operations
- Transform and combine futures
- Apply async programming to task loading and saving

## Key Concepts

### 1. Introduction to Futures
A Future represents a potential value or error that will be available at some time in the future:

```dart
// A function that returns a Future
Future<String> fetchTaskTitle(String taskId) async {
  // Simulate network delay
  await Future.delayed(Duration(seconds: 1));
  return 'Task #$taskId';
}
```

### 2. Async/Await Syntax
The async and await keywords make asynchronous code look synchronous:

```dart
Future<void> loadTasks() async {
  try {
    print('Loading tasks...');
    final tasks = await taskRepository.getAllTasks();
    print('Loaded ${tasks.length} tasks');
  } catch (error) {
    print('Failed to load tasks: $error');
  }
}
```

### 3. Error Handling in Async Code
Proper error handling is crucial in asynchronous programming:

```dart
Future<Task?> safeGetTask(String taskId) async {
  try {
    return await taskRepository.getTaskById(taskId);
  } catch (error) {
    print('Error fetching task $taskId: $error');
    return null;
  }
}
```

### 4. Future Transformations
Transform and combine futures using various methods:

```dart
// Transform a future result
Future<String> getTaskSummary(String taskId) async {
  final task = await taskRepository.getTaskById(taskId);
  return task != null ? '${task.title} (${task.status})' : 'Task not found';
}

// Wait for multiple futures
Future<void> loadAllData() async {
  final results = await Future.wait([
    taskRepository.getAllTasks(),
    userRepository.getAllUsers(),
  ]);
  
  final tasks = results[0] as List<Task>;
  final users = results[1] as List<User>;
  
  print('Loaded ${tasks.length} tasks and ${users.length} users');
}
```

## Examples

Study the examples in the `examples/` directory:
- `basic_futures.dart` - Introduction to Future and async/await
- `error_handling.dart` - Handling errors in async code
- `future_transformations.dart` - Combining and transforming futures
- `task_loading_service.dart` - Practical example with task loading

## Exercises

Complete the exercises in the `exercises/` directory:

### Exercise 1: Async Task Creator
Build an async task creation service with validation.

### Exercise 2: Batch Operations
Implement batch task operations using Future.wait.

### Exercise 3: Retry Logic
Add retry functionality for failed operations.

## Next Steps

Ready for [Module 9: Async Programming II - Streams](../09_async_programming_2/README.md)?