# 05 – Collections & Generics (Algorithms & Extensions)

## Goals
* Internalize List / Set / Map complexity & use-cases
* Master collection if / for, spreads, and lazy vs eager transforms
* Implement generic abstractions with constraints (`extends`, `implements`)
* Apply folding, partitioning, grouping, sliding windows
* Build expressive extension methods & avoid over-extension

## Core Patterns
```dart
final tasks = <Task>[];

// Spread + conditional inclusion
final renderable = [
  if (tasks.isEmpty) 'No tasks yet' else ...tasks.map((t) => t.title)
];

// Shallow copy to avoid mutating original
final cloned = [...tasks];

// Unmodifiable view
final safeView = List.unmodifiable(tasks);
```

## Grouping & Multi-Index
```dart
Map<int, List<Task>> groupByPriority(Iterable<Task> items) {
  final map = <int, List<Task>>{};
  for (final t in items) {
    map.putIfAbsent(t.priority, () => []).add(t);
  }
  return map;
}

Map<String, Task> indexById(Iterable<Task> items) => {
  for (final t in items) t.id : t
};
```

## Generic Repository Interface
```dart
abstract interface class Repository<T> {
  Future<T> create(T entity);
  Future<T?> getById(String id);
  Future<List<T>> list();
  Future<bool> delete(String id);
}

class InMemoryRepository<T extends Object> implements Repository<T> {
  final _store = <String, T>{};
  final String Function(T) idOf;
  InMemoryRepository(this.idOf);

  @override
  Future<T> create(T entity) async => _store[idOf(entity)] = entity;
  @override
  Future<T?> getById(String id) async => _store[id];
  @override
  Future<List<T>> list() async => _store.values.toList(growable: false);
  @override
  Future<bool> delete(String id) async => _store.remove(id) != null;
}
```

## Extension Methods – Power with Restraint
```dart
extension TaskIterableX on Iterable<Task> {
  Iterable<Task> overdue() => where((t) => t.dueAt != null && t.dueAt!.isBefore(DateTime.now()));
  Iterable<Task> byStatus<T extends TaskStatus>() => where((t) => t.status is T);
  double averagePriority() => isEmpty ? 0 : map((t) => t.priority).reduce((a,b) => a+b) / length;
  ({List<Task> open, List<Task> done}) partitionDone() {
    final open = <Task>[]; final done = <Task>[];
    for (final t in this) { (t.status is Done) ? done.add(t) : open.add(t); }
    return (open: open, done: done);
  }
}
```

## Sliding Window Example
```dart
Iterable<List<T>> windows<T>(List<T> list, int size) sync* {
  if (size <= 0) throw ArgumentError('size must be > 0');
  for (var i = 0; i + size <= list.length; i++) {
    yield list.sublist(i, i + size);
  }
}
```

## Sorting with Comparator Composition
```dart
List<Task> sortUrgent(List<Task> list) {
  final copy = [...list];
  copy.sort((a,b) {
    // earlier due date first (nulls last)
    final dueCmp = _compareNullableDate(a.dueAt, b.dueAt);
    if (dueCmp != 0) return dueCmp;
    // priority ascending (1 before 2)
    return a.priority.compareTo(b.priority);
  });
  return copy;
}

int _compareNullableDate(DateTime? a, DateTime? b) {
  if (a == null && b == null) return 0;
  if (a == null) return 1;
  if (b == null) return -1;
  return a.compareTo(b);
}
```

## Algorithmic Considerations
| Operation | List | Set | Map |
|-----------|------|-----|-----|
| Lookup | O(n) | O(1) avg | O(1) avg |
| Insert end | Amortized O(1) | O(1) | O(1) |
| Remove by value | O(n) | O(1) | O(1) |
| Ordered iteration | Yes (index) | Insertion order | Insertion order |

## Functional vs Imperative Tradeoff
Prefer clarity: a simple `for` loop may outperform chained transforms in hot code paths; profile before micro-optimizing.

## Practice (Tiered)
Basic:
1. Implement `countByStatus(Iterable<Task>) -> Map<String,int>`.
2. Create a `uniquePriorities(Iterable<Task>) -> Set<int>`.

Intermediate:
3. Implement `topN(List<Task>, int n)` using a partial selection (avoid full sort for large N).
4. Add an extension returning tasks grouped by day: `Map<DateTime,List<Task>> byCreationDay()`.

Advanced:
5. Implement a generic `paginate<T>(List<T>, int page, int size)` that is safe on edges.
6. Implement `Iterable<T> interleave<T>(Iterable<T> a, Iterable<T> b)`.

## Edge Cases
* Empty iterables in reductions → provide defaults
* Duplicate IDs when indexing → last write wins (document it)
* Large lists: copying via spread can be costly; consider views (not built-in; design API carefully)

## Checklist
* [ ] Chose correct collection types for semantics
* [ ] Extensions do not leak internal mutability
* [ ] Sorting & grouping tested with edge cases
* [ ] Generic repository compiled & used with `Task`

## Next
Proceed to 06 (Async) to integrate IO and real-time style updates.
