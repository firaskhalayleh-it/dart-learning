# 05 – Collections & Generics

## Goals
- Lists, Sets, Maps, spread & collection if/for
- Generics & type constraints
- Sorting, grouping, mapping, folding
- Extension methods for expressiveness

## Examples
```dart
final tasks = <Task>[];

// Spread + condition
final display = [
  if (tasks.isEmpty) 'No tasks yet' else ...tasks.map((t) => t.title)
];

// Group by priority
Map<int, List<Task>> groupByPriority(Iterable<Task> list) {
  final map = <int, List<Task>>{};
  for (final t in list) {
    map.putIfAbsent(t.priority, () => []).add(t);
  }
  return map;
}

// Generic repository interface
abstract interface class Repository<T> {
  Future<T> create(T entity);
  Future<T?> getById(String id);
  Future<List<T>> list();
}

extension TaskFiltering on Iterable<Task> {
  Iterable<Task> overdue() => where((t) => t.dueAt != null && t.dueAt!.isBefore(DateTime.now()));
  Iterable<Task> byStatus(Type statusType) => where((t) => t.status.runtimeType == statusType);
}
```

## Practice
1. Implement an in-memory `TaskRepository` implementing `Repository<Task>`.
2. Write a function returning top 5 most urgent tasks (due soonest then priority).
3. Extend `Iterable<Task>` with `averagePriority()`.

## Checklist
- [ ] Comfort with collection literals & control flow in literals
- [ ] Understand generics vs `dynamic`
- [ ] Added at least one useful extension

## Next
Async (06) to handle future data sources (APIs, databases, streams).
