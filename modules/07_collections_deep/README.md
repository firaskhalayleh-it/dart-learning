# Module 7: Collections Deep Dive

Master advanced collection operations, functional programming with collections, and performance considerations.

## Learning Objectives

By the end of this module, you will be able to:
- Use advanced List, Set, and Map operations
- Apply functional programming with collections
- Understand performance implications of different operations
- Filter, sort, and transform task collections efficiently
- Use collection-if and collection-for syntax

## Key Concepts

### 1. Advanced Collection Operations
```dart
// Functional operations on task lists
final tasks = <Task>[/* ... */];

// Filter high priority pending tasks
final urgentTasks = tasks
  .where((task) => task.priority == TaskPriority.high)
  .where((task) => task.status == TaskStatus.pending)
  .toList();

// Group tasks by status
final tasksByStatus = tasks.fold<Map<TaskStatus, List<Task>>>(
  {},
  (map, task) {
    map.putIfAbsent(task.status, () => []).add(task);
    return map;
  },
);
```

### 2. Collection Literals with Control Flow
```dart
// Collection-if for conditional inclusion
final actions = [
  'View Details',
  if (task.status == TaskStatus.pending) 'Start Task',
  if (task.status == TaskStatus.inProgress) 'Complete Task',
  if (user.isAdmin) 'Delete Task',
];

// Collection-for for dynamic generation
final taskWidgets = [
  for (final task in tasks)
    if (task.isVisible)
      TaskWidget(task),
];
```

This module enhances your ability to work with data collections effectively.

## Next Steps

Ready for [Module 8: Async Programming I](../08_async_programming_1/README.md)?
