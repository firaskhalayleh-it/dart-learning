# 08 – Package Structure & Modularization (Pure Dart)

## Goals
* Organize code into libraries & barrel files
* Understand public vs private APIs (`_` prefix)
* Split domain, infrastructure, and utilities cleanly
* Create re-exports for ergonomic consumption

## Example Layout
```
lib/
  taskmate.dart            # barrel export
  domain/
    task.dart
    project.dart
  infra/
    in_memory_task_repo.dart
  util/
    date_format.dart
```

## Barrel File (`lib/taskmate.dart`)
```dart
export 'domain/task.dart';
export 'domain/project.dart';
export 'infra/in_memory_task_repo.dart';
```

## Private vs Public
```dart
// _internal_helper.dart (not exported)
String _normalize(String s) => s.trim();
```

## Practice
1. Create a `lib/domain/failure.dart` and export it.
2. Add a util file providing `String humanizeDate(DateTime)`.
3. Re-export everything through a single barrel; import only barrel in examples.

## Checklist
* [ ] No cyclic imports
* [ ] Barrel exports kept minimal and intentional
* [ ] Private internals not leaked

## Next
Proceed to 09 (Configuration & Environment Management).
