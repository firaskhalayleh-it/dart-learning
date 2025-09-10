# Module 3: Functions and Methods

In this module, you'll learn how to create and use functions in Dart, including parameters, return types, and functional programming concepts.

## Learning Objectives

By the end of this module, you will be able to:
- Declare and call functions with various parameter types
- Use named parameters and optional parameters effectively
- Understand function as first-class objects
- Apply functional programming concepts
- Create utility functions for task management

## Key Concepts

### 1. Basic Function Declaration
```dart
// Simple function
String greetUser(String name) {
  return 'Hello, $name!';
}

// Function with multiple parameters
int calculateTaskPriority(bool isUrgent, DateTime dueDate) {
  if (isUrgent) return 5;
  final daysUntilDue = dueDate.difference(DateTime.now()).inDays;
  return daysUntilDue <= 1 ? 4 : 2;
}
```

### 2. Optional and Named Parameters
```dart
// Named parameters with defaults
Task createTask({
  required String title,
  String? description,
  TaskPriority priority = TaskPriority.normal,
  DateTime? dueDate,
}) {
  return Task(
    id: generateId(),
    title: title,
    description: description,
    priority: priority,
    dueDate: dueDate,
    createdAt: DateTime.now(),
  );
}
```

### 3. Arrow Functions
```dart
// Concise syntax for simple functions
bool isTaskOverdue(Task task) => 
  task.dueDate != null && DateTime.now().isAfter(task.dueDate!);

String getTaskSummary(Task task) => 
  '${task.title} (${task.status.name})';
```

## Examples

Study the examples in the `examples/` directory:
- `basic_functions.dart` - Function declaration and calling
- `parameters_demo.dart` - Different parameter types
- `functional_programming.dart` - Functions as first-class objects
- `task_utilities.dart` - Practical utility functions

## Exercises

Complete the exercises in the `exercises/` directory:

### Exercise 1: Task Validation Functions
Create validation functions for task data.

### Exercise 2: Task Transformation
Build functions to transform and filter task lists.

## Next Steps

Ready for [Module 4: Classes and Objects](../04_classes_objects/README.md)?