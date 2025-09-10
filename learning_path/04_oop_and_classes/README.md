# 04 – OOP & Classes

## Goals
- Classes, constructors, named & factory constructors
- `const`, immutability, copy patterns
- Value equality & `record` types (Dart 3)
- Sealed classes & pattern matching for domain modeling

## Core Model Example (TaskMate)
```dart
// task_model.dart
sealed class TaskStatus { const TaskStatus(); }
class Pending extends TaskStatus { const Pending(); }
class InProgress extends TaskStatus { const InProgress(); }
class Done extends TaskStatus { const Done(); }

class Task {
  final String id;
  final String title;
  final String? description;
  final DateTime createdAt;
  final DateTime? dueAt;
  final TaskStatus status;
  final int priority; // 1 = High, 2 = Medium, 3 = Low
  const Task({
    required this.id,
    required this.title,
    this.description,
    required this.createdAt,
    this.dueAt,
    this.status = const Pending(),
    this.priority = 2,
  });

  Task copyWith({
    String? title,
    String? description,
    DateTime? dueAt,
    TaskStatus? status,
    int? priority,
  }) => Task(
    id: id,
    title: title ?? this.title,
    description: description ?? this.description,
    createdAt: createdAt,
    dueAt: dueAt ?? this.dueAt,
    status: status ?? this.status,
    priority: priority ?? this.priority,
  );

  @override
  bool operator ==(Object other) =>
      other is Task && other.id == id;
  @override
  int get hashCode => id.hashCode;
}
```

## Records For Lightweight Returns
```dart
(String title, bool overdue) summarize(Task t) => (
  t.title,
  t.dueAt != null && t.dueAt!.isBefore(DateTime.now())
);
```

## Practice
1. Add a `Project` class referencing multiple `Task` IDs (aggregate pattern).
2. Implement a `factory Task.fromJson(Map<String,dynamic>)` and `toJson()`.
3. Create a sealed hierarchy for `Failure` (e.g. `NetworkFailure`, `CacheFailure`).

## Checklist
- [ ] Can explain immutability benefits
- [ ] Implemented value equality intentionally
- [ ] Used sealed classes for closed polymorphism

## Next
Collections & Generics (05) to manipulate groups of these models.
