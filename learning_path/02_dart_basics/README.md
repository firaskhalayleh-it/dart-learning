# 02 – Dart Basics (Deep Dive)

## Goals
* Master value vs reference semantics for common types
* Understand `var` vs explicit types vs `final` vs `const`
* Null safety operators: `?`, `!`, `??`, `??=`, cascade `..`
* String manipulation & interpolation best practices
* Basic numeric APIs & date/time usage

## Scalar & Core Types
```dart
void main() {
  var inferredInt = 3;          // int
  final now = DateTime.now();   // runtime final
  const maxRetries = 5;         // compile-time

  // Explicit types
  String user = 'Aisha';
  num genericNumber = 4.2; // can hold int or double
  dynamic anything = 'temp'; // avoid unless needed
  anything = 42;             // allowed but unsafe

  // Null safety
  String? nickname;          // nullable
  print(nickname ?? 'No nick');
  nickname ??= 'Ace';        // assign if null
  print(nickname!.toUpperCase()); // '!' asserts non-null (be careful)

  // String interpolation
  final status = 'User: $user (${inferredInt + 2})';
  print(status);

  // Multi-line strings
  final jsonMock = '''{
  "ok": true,
  "items": []
}''';
  print(jsonMock.length);
}
```

## Collections Preview (Will Deepen Later)
```dart
final scores = <int>[10, 20, 30];
final doubled = scores.map((e) => e * 2).toList();
final set = { 'a', 'b', 'b' }; // duplicates ignored
final config = { 'url': 'https://api', 'retries': '3' };
```

## Null Safety Operators Summary
| Operator | Purpose | Example |
|----------|---------|---------|
| `?` | Make type nullable | `String? name` |
| `!` | Assert non-null | `name!.length` |
| `??` | Fallback if left null | `name ?? 'anon'` |
| `??=` | Assign if currently null | `name ??= 'set'` |
| `?.` | Null-aware access | `user?.email` |
| `..` | Cascade (operate on same object) | `buffer..write('a')..write('b')` |

## Cascades & Builders
```dart
final buffer = StringBuffer()
  ..writeln('Header')
  ..write('Value: ')
  ..write(42);
print(buffer.toString());
```

## Enum & Enhanced Switch Glimpse
```dart
enum Priority { high, medium, low }

String label(Priority p) => switch (p) {
  Priority.high => '🔥 High',
  Priority.medium => '⚖️ Medium',
  Priority.low => '🧊 Low',
};
```

## Defensive Programming Patterns
```dart
String normalizeEmail(String? raw) {
  final r = raw?.trim();
  if (r == null || r.isEmpty) return 'unknown@example.com';
  return r.toLowerCase();
}
```

## Mini Utilities Example
```dart
int safeParseInt(String input, {int fallback = 0}) {
  return int.tryParse(input.trim()) ?? fallback;
}

Map<String, String> parseEnvLine(String line) {
  final map = <String,String>{};
  for (final part in line.split(';')) {
    final kv = part.split('=');
    if (kv.length == 2) map[kv[0]] = kv[1];
  }
  return map;
}
```

## Practice (Progressive)
1. Build a `formatCurrency(num value, {String symbol = 'USD'})` returning `'USD 1,234.50'`.
2. Implement `String truncate(String input, int max, {String ellipsis = '...'})`.
3. Write a function to generate a pseudo-random identifier of length N using only `[a-z0-9]`.
4. Create a `TaskSeed` record: `({String title, int seed})` and print variations.

## Evolving TaskMate (Data Brainstorm)
Raw task data candidates before modeling OOP:
```dart
final raw = {
  'title': 'Buy groceries',
  'done': false,
  'createdAt': DateTime.now().toIso8601String(),
  'tags': ['errand','home'],
  'priority': 2,
  'estimateMinutes': 15,
};
```
Decide which fields are required vs optional. Note potential types.

## Quality Checklist
* [ ] Can articulate difference `final` vs `const`
* [ ] Avoided `dynamic` in all examples
* [ ] Wrote at least 3 utility functions with tests (later)
* [ ] Understood null safety operators table

## Stretch
Refactor earlier code to use records `(title: String, priority: int)` where appropriate.

## Next
Move to Control Flow & Functions (03) for structured logic abstraction.
