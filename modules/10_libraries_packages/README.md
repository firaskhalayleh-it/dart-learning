# Module 10: Libraries and Packages

Learn how to organize code into libraries, work with external packages, and publish your own packages to pub.dev.

## Learning Objectives

By the end of this module, you will be able to:
- Create and organize Dart libraries
- Import and export library components
- Work with external packages from pub.dev
- Understand library visibility and encapsulation
- Publish packages to the Dart ecosystem

## Key Concepts

### 1. Creating Libraries
```dart
// lib/task_manager.dart
library task_manager;

export 'src/domain/task.dart';
export 'src/services/task_service.dart';
export 'src/data/repositories.dart';

// Hide internal implementation
export 'src/utils/helpers.dart' hide internalHelper;
```

### 2. Package Structure
```
my_task_package/
├── lib/
│   ├── task_manager.dart     # Main library file
│   └── src/                  # Private implementation
│       ├── domain/
│       ├── services/
│       └── data/
├── test/
├── example/
└── pubspec.yaml
```

### 3. Working with Dependencies
```yaml
# pubspec.yaml
dependencies:
  http: ^1.1.0
  json_annotation: ^4.8.1

dev_dependencies:
  test: ^1.21.0
  build_runner: ^2.4.7
```

This module teaches professional code organization and package management.

## Next Steps

Ready for [Module 11: Testing Fundamentals](../11_testing_fundamentals/README.md)?
