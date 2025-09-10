# Module 1: Dart Fundamentals

Welcome to your first Dart module! In this module, you'll set up your development environment and write your first Dart programs.

## Learning Objectives

By the end of this module, you will be able to:
- Set up a Dart development environment
- Understand Dart's basic syntax and structure
- Write and run simple Dart programs
- Use the `dart` command-line tool
- Understand Dart's entry point and program structure

## Key Concepts

### 1. Dart Program Structure
Every Dart program has an entry point - the `main()` function:

```dart
void main() {
  print('Hello, Dart!');
}
```

### 2. Comments
Dart supports three types of comments:

```dart
// Single line comment

/*
  Multi-line comment
  can span multiple lines
*/

/// Documentation comment
/// Used for API documentation
void myFunction() {}
```

### 3. Imports and Libraries
Dart uses imports to access code from other files and packages:

```dart
import 'dart:core';  // Core library (imported by default)
import 'dart:io';    // I/O operations
import 'package:test/test.dart';  // External package
```

### 4. Basic Output
Use `print()` to output text to the console:

```dart
void main() {
  print('Hello, Task Tracker!');
  print('Starting our Dart journey...');
}
```

## Examples

Look at the files in the `examples/` directory:
- `hello_world.dart` - Basic program structure
- `comments_demo.dart` - Different types of comments
- `imports_demo.dart` - Using imports and libraries

## Exercises

Complete the exercises in the `exercises/` directory:

### Exercise 1: Your First Program
Create a file called `my_first_program.dart` that:
1. Prints a welcome message for the Task Tracker application
2. Prints your name as the developer
3. Uses different types of comments to document your code

### Exercise 2: Multiple Imports
Create a file called `imports_practice.dart` that:
1. Imports the `dart:math` library
2. Imports the `dart:io` library
3. Prints a random number using `Random()` from dart:math
4. Uses proper documentation comments

## Running Your Code

### Command Line
```bash
# Run a Dart file directly
dart run examples/hello_world.dart

# Run with debugging information
dart --enable-asserts run examples/hello_world.dart
```

### IDE Integration
If you're using VS Code with the Dart extension:
1. Open any `.dart` file
2. Press `F5` to run
3. Use `Ctrl+Shift+P` and type "Dart: Run" for more options

## Common Mistakes to Avoid

1. **Forgetting the main function**: Every Dart program needs a `main()` function
2. **Case sensitivity**: Dart is case-sensitive. `Print` is not the same as `print`
3. **Missing semicolons**: Most statements in Dart end with a semicolon `;`
4. **Incorrect imports**: Make sure your import paths are correct

## Testing Your Understanding

Run the example programs and make sure you understand:
- Why we need a `main()` function
- How to add comments that help explain your code
- When and how to use imports
- How to run Dart programs from the command line

## Next Steps

Once you've completed this module and feel comfortable with:
- Basic Dart program structure
- Running Dart programs
- Using comments and imports

Move on to [Module 2: Variables and Types](../02_variables_types/README.md) where you'll learn about Dart's type system and null safety.

## Additional Resources

- [Dart Language Tour - A Basic Dart Program](https://dart.dev/guides/language/language-tour#a-basic-dart-program)
- [Dart Command Line Tools](https://dart.dev/tools/dart-tool)
- [Dart Core Libraries](https://dart.dev/guides/libraries)

Happy coding! 🎯