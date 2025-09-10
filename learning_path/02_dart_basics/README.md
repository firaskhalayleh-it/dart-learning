e# 02 – Dart Basics

## Goals
- Variables, types, `var` vs `final` vs `const`
- Basic I/O & string interpolation
- Operators & string manipulation
- Null safety fundamentals

## Core Concepts
```dart
void main() {
  var mutable = 3;          // type inferred as int
  final timestamp = DateTime.now(); // runtime constant
  const pi = 3.14159;       // compile-time constant

  String name = 'Fira';
  int age = 28;
  double score = 87.5;
  bool isActive = true;

  print('User: $name (${age + 1}), score=${score.toStringAsFixed(1)} active=$isActive');

  // Null safety
  String? maybeValue; // can be null
  maybeValue ??= 'default';
  print(maybeValue.length); // safe: now non-null
}
```

## Common Pitfalls
- Forgetting `?` on nullable types.
- Using `late` without initialization causing runtime errors.
- Overusing `dynamic` (avoid unless interop).

## Mini Practice
1. Write a script that formats a multi-line invoice string.
2. Parse an environment-like string: `API_URL=https://example.com;TIMEOUT=30` into a map.
3. Safely handle a possibly null user nickname.

## Evolving TaskMate
Define initial raw data you might store for a task before modeling:
```dart
final taskTitle = 'Buy groceries';
final isDone = false;
final createdAt = DateTime.now();
```
List out which pieces of data you think a real task needs (priority, due date, tags, etc.).

## Checklist
- [ ] Understand difference between `final` and `const`
- [ ] Can explain null safety basics
- [ ] Can run a standalone Dart script: `dart run bin/example.dart`

## Next
Control flow & functions (03) to structure logic.
