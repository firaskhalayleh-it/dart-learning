# Module 2: Variables and Types

In this module, you'll learn about Dart's type system, null safety, and how to work with variables and collections.

## Learning Objectives

By the end of this module, you will be able to:
- Declare and use variables with proper types
- Understand Dart's null safety system
- Work with basic data types (int, double, String, bool)
- Use collections (List, Set, Map)
- Apply type inference effectively
- Handle nullable and non-nullable types

## Key Concepts

### 1. Variable Declaration
Dart provides several ways to declare variables:

```dart
// Explicit type declaration
String name = 'Task Tracker';
int version = 1;

// Type inference with var
var appName = 'Task Tracker';  // String inferred
var versionNumber = 1;         // int inferred

// Final and const
final String createdDate = DateTime.now().toString();  // Runtime constant
const int maxTasks = 100;      // Compile-time constant
```

### 2. Null Safety
Dart has sound null safety, which prevents null reference errors:

```dart
// Non-nullable types (cannot be null)
String name = 'John';
int age = 25;

// Nullable types (can be null)
String? optionalName;  // null by default
int? optionalAge;

// Safe null checking
if (optionalName != null) {
  print(optionalName.length);  // Safe to use
}

// Null-aware operators
print(optionalName?.length);     // Returns null if optionalName is null
print(optionalName ?? 'Unknown'); // Use 'Unknown' if optionalName is null
```

### 3. Basic Data Types

```dart
// Numbers
int wholeNumber = 42;
double decimal = 3.14159;
num flexible = 42;  // Can hold int or double

// Strings
String singleQuote = 'Hello';
String doubleQuote = "World";
String multiLine = '''
This is a
multi-line string
''';

// String interpolation
String message = 'Hello, $name! You are $age years old.';

// Booleans
bool isComplete = true;
bool isActive = false;
```

### 4. Collections

```dart
// Lists (ordered, allow duplicates)
List<String> tasks = ['Buy groceries', 'Walk the dog'];
var moreTasks = <String>['Read book', 'Exercise'];

// Sets (unordered, unique items)
Set<String> categories = {'Work', 'Personal', 'Shopping'};

// Maps (key-value pairs)
Map<String, int> taskPriorities = {
  'Buy groceries': 1,
  'Walk the dog': 2,
};
```

## Examples

Study the examples in the `examples/` directory:
- `variables_basics.dart` - Variable declaration and types
- `null_safety_demo.dart` - Working with nullable types
- `collections_intro.dart` - Lists, Sets, and Maps
- `task_data_structures.dart` - Applying concepts to our domain

## Exercises

Complete the exercises in the `exercises/` directory:

### Exercise 1: Task Properties
Create variables to represent a task with proper types and null safety.

### Exercise 2: Task Collection
Build collections to manage multiple tasks and their properties.

## Testing Your Understanding

Make sure you can:
- Choose appropriate types for variables
- Use null safety operators correctly
- Work with collections effectively
- Apply type inference appropriately

## Next Steps

Ready for [Module 3: Functions and Methods](../03_functions_methods/README.md)?

## Additional Resources

- [Dart Type System](https://dart.dev/guides/language/type-system)
- [Null Safety in Dart](https://dart.dev/null-safety)
- [Collections in Dart](https://dart.dev/guides/libraries/library-tour#collections)