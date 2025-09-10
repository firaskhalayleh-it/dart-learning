# 04 – OOP & Classes (Patterns & Sealed Hierarchies)

## Goals
* Immutable domain modeling with expressive constructors
* Advanced constructor forms: named, factory, redirecting
* Sealed classes vs abstract classes
* Records for lightweight aggregates
* Value equality strategies (manual vs packages) & hashing pitfalls
* Copy patterns & object transformation

## Status Modeling (Sealed Hierarchy)
```dart
sealed class TaskStatus { const TaskStatus(); }
class Pending extends TaskStatus { const Pending(); }
class InProgress extends TaskStatus { const InProgress({this.startedAt}); final DateTime? startedAt; }
class Done extends TaskStatus { const Done({this.completedAt}); final DateTime? completedAt; }

String statusLabel(TaskStatus s) => switch (s) {
  Pending() => 'Pending',
  InProgress(startedAt: final d) => 'In Progress${d == null ? '' : ' since ${d.toIso8601String()}'}',
  Done(completedAt: final c) => 'Done${c == null ? '' : ' @ ${c.toIso8601String()}'}',
};
```

## Core Entity
```dart
class Task {
  final String id;
  final String title;
  final String? description;
  final DateTime createdAt;
  final DateTime? dueAt;
  final TaskStatus status;
  final int priority; // 1=High
  final Set<String> tags;

  const Task({
    required this.id,
    required this.title,
    this.description,
    required this.createdAt,
    this.dueAt,
    this.status = const Pending(),
    this.priority = 2,
    this.tags = const {},
  });

  factory Task.newTodo(String title) => Task(
    id: _genId(),
    title: title.trim(),
    createdAt: DateTime.now(),
  );

  factory Task.fromJson(Map<String,dynamic> json) => Task(
    id: json['id'] as String,
    title: json['title'] as String,
    description: json['description'] as String?,
    createdAt: DateTime.parse(json['createdAt'] as String),
    dueAt: json['dueAt'] == null ? null : DateTime.parse(json['dueAt'] as String),
    status: _statusFrom(json['status'] as String?),
    priority: json['priority'] as int? ?? 2,
    tags: (json['tags'] as List?)?.cast<String>().toSet() ?? const {},
  );

  Map<String, dynamic> toJson() => {
    'id': id,
    'title': title,
    'description': description,
    'createdAt': createdAt.toIso8601String(),
    'dueAt': dueAt?.toIso8601String(),
    'status': status.runtimeType.toString(),
    'priority': priority,
    'tags': tags.toList(),
  };

  Task copyWith({
    String? title,
    String? description,
    DateTime? dueAt,
    TaskStatus? status,
    int? priority,
    Set<String>? tags,
  }) => Task(
    id: id,
    title: title ?? this.title,
    description: description ?? this.description,
    createdAt: createdAt,
    dueAt: dueAt ?? this.dueAt,
    status: status ?? this.status,
    priority: priority ?? this.priority,
    tags: tags ?? this.tags,
  );

  @override
  bool operator ==(Object other) => other is Task && other.id == id;
  @override
  int get hashCode => id.hashCode;
}

String _genId() => DateTime.now().microsecondsSinceEpoch.toRadixString(36);
TaskStatus _statusFrom(String? raw) => switch(raw) { 'InProgress' => const InProgress(), 'Done' => const Done(), _ => const Pending() };
```

## Records for Lightweight Composition
```dart
({Task task, bool overdue}) summarize(Task t) => (
  task: t,
  overdue: t.dueAt != null && t.dueAt!.isBefore(DateTime.now())
);
```

## Composition vs Inheritance
Prefer composition:
```dart
class Auditable { final DateTime createdAt; final DateTime? updatedAt; const Auditable(this.createdAt, this.updatedAt); }
class Taggable { final Set<String> tags; const Taggable(this.tags); }

class Note with _TagMixin implements Comparable<Note> {
  final String id; final String content; final Auditable meta; final Taggable tagging;
  Note(this.id, this.content, this.meta, this.tagging);
  @override
  int compareTo(Note other) => content.length.compareTo(other.content.length);
}

mixin _TagMixin {}
```

## Equality & Hash Strategy
If ID uniquely identifies entity, compare only ID. If you need full structural equality use `package:equatable` (optional).

## Invariants & Validation
```dart
class PositiveInt {
  final int value;
  PositiveInt(this.value) : assert(value > 0, 'Must be > 0');
  @override String toString() => value.toString();
}
```

## Practice
1. Add a `Project` entity containing ordered `List<Task>` plus helper `addTask(Task)` returning new instance.
2. Implement a `splitByStatus(List<Task>) -> ({List<Task> open, List<Task> done})` using records.
3. Introduce a `mixin Timed` adding `duration()` to classes with `start` & `end` fields.
4. Add validation ensuring `dueAt` is after `createdAt` (throw or assert).

## Edge Cases
* JSON missing keys
* Duplicate tags (Set resolves)
* Unknown status strings

## Checklist
* [ ] Constructors provide clear invariants
* [ ] Copy semantics maintain immutability
* [ ] Sealed statuses exhaustive in switches
* [ ] No implicit mutable shared collections

## Next
Proceed to 05 (Collections & Generics) to operate over groups efficiently.
