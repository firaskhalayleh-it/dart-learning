# 03 – Control Flow & Functions

## Goals
- Conditionals, loops, `switch`/`case` with pattern matching (Dart 3)
- Functions: positional vs named parameters, default values
- Arrow syntax & higher-order functions

## Examples
```dart
String classifyPriority(int p) => switch (p) {
  1 => 'High',
  2 => 'Medium',
  3 => 'Low',
  _ => 'Unknown'
};

int sum(List<int> values) {
  var total = 0;
  for (final v in values) {
    total += v;
  }
  return total;
}

int flexibleAdd(int a, {int factor = 1}) => a * factor;

void main() {
  print(classifyPriority(1));
  print(sum([1,2,3]));
  print(flexibleAdd(5, factor: 3));
}
```

## Practice
1. Implement a function that returns human-friendly relative time ("5m ago").
2. Write a loop that filters even numbers without using `.where`.
3. Convert a nested `if/else` chain to a `switch` expression.

## TaskMate Evolution
Create a function that toggles a task's done state (immutable style):
```dart
class Task {
  final String id;
  final String title;
  final bool done;
  const Task({required this.id, required this.title, this.done = false});
  Task toggle() => Task(id: id, title: title, done: !done);
}
```

## Checklist
- [ ] Comfortable with `switch` expressions
- [ ] Can write pure functions with named params
- [ ] Avoids side effects unless necessary

## Next
Move to OOP & Classes (04) for deeper modeling.
