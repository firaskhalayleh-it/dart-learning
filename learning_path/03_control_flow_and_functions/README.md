# 03 – Control Flow & Functions (Advanced)

## Goals
* Master branching: `if`, `switch` expressions, pattern matching
* Understand loop varieties & prefer iterator / functional forms when clearer
* Design clean function signatures (positional vs named, required named)
* Use higher-order functions & closures effectively
* Leverage tail recursion alternatives (iterative / fold)

## Conditional Patterns & Switch Expressions
```dart
String classifyPriority(int p) => switch (p) {
  >= 1 && <= 1 => 'High',   // guard style range
  2 => 'Medium',
  3 => 'Low',
  _ => 'Unknown'
};

String describeRecord((String name, int score)? rec) => switch (rec) {
  (final name, >=90) => '$name is top-tier',
  (final name, >=70 && <90) => '$name is solid',
  (final name, _) => '$name needs improvement',
  null => 'No data'
};
```

## Loops vs Functional APIs
```dart
int sumLoop(List<int> values) {
  var total = 0;
  for (final v in values) { total += v; }
  return total;
}

int sumFold(List<int> values) => values.fold(0, (a,b) => a + b);
```

## Parameter Design
```dart
int scale(int value, {required int factor, int offset = 0}) => value * factor + offset;

// Avoid long positional lists: prefer named for clarity
String formatUser({required String name, int? age, String role = 'user'}) =>
  '$name${age == null ? '' : ' ($age)'} – $role';
```

## Higher-Order Functions & Closures
```dart
List<int> makeSequence(int n, int Function(int) mapFn) =>
  List.generate(n, mapFn);

Function makeAdder(int seed) {
  var counter = seed; // captured mutable state (use sparingly)
  return (int delta) {
    counter += delta;
    return counter;
  };
}

void closureDemo() {
  final add = makeAdder(10);
  print(add(5));  // 15
  print(add(3));  // 18 (state retained)
}
```

## Guard Clauses vs Nested Conditionals
```dart
String evaluate(int? value) {
  if (value == null) return 'missing';
  if (value < 0) return 'negative';
  if (value == 0) return 'zero';
  return 'positive';
}
```

## Exception-Aware Function Pattern
```dart
T tryOr<T>(T Function() op, T fallback) {
  try { return op(); } catch (_) { return fallback; }
}
```

## Tail-Recursive Alternative (Factorial)
```dart
int factorial(int n) {
  var acc = 1;
  for (var i = 2; i <= n; i++) { acc *= i; }
  return acc;
}
```

## TaskMate Evolution – Pure Function Utilities
```dart
class Task { final String id; final String title; final bool done; const Task({required this.id, required this.title, this.done=false}); Task toggle() => Task(id: id, title: title, done: !done); }

List<Task> markAllDone(List<Task> list) => [for (final t in list) Task(id: t.id, title: t.title, done: true)];

Iterable<Task> filterBy(List<Task> tasks, bool Function(Task) predicate) sync* {
  for (final t in tasks) { if (predicate(t)) yield t; }
}
```

## Practice (Progressive)
1. Implement `String relativeTime(DateTime dt)` returning `"5m" / "2h" / "3d"`.
2. Create a reusable `retry<T>(Future<T> Function(), {int times = 3})` (sync pseudo first; real async later).
3. Convert a deeply nested `if/else` chain you write into guard clauses + switch expression.
4. Write `partition<T>(Iterable<T>, bool Function(T)) -> (List<T> pass, List<T> fail)` using a single pass.

## Edge Cases To Consider
* Empty lists in reductions
* Null records
* Overflow in iterative math (large factorial)
* Captured mutable state causing bugs

## Quality Checklist
* [ ] All new functions pure (unless explicitly stateful)
* [ ] Switch expressions exhaustively handle patterns
* [ ] Named parameters used for clarity where needed
* [ ] Replaced manual loops with folds/maps where readability improved

## Next
Advance to 04 (OOP & Classes) for richer domain modeling.
