# Module 4: Classes and Objects

Learn object-oriented programming in Dart, including classes, constructors, inheritance, and encapsulation.

## Learning Objectives

By the end of this module, you will be able to:
- Create classes with properties and methods
- Use constructors effectively (default, named, factory)
- Understand inheritance and method overriding
- Apply encapsulation principles
- Build the Task and User classes for our domain

## Key Concepts

### 1. Basic Class Declaration
```dart
class Task {
  final String id;
  final String title;
  String? description;
  TaskStatus status;
  DateTime createdAt;
  
  Task({
    required this.id,
    required this.title,
    this.description,
    this.status = TaskStatus.pending,
    required this.createdAt,
  });
  
  void markCompleted() {
    status = TaskStatus.completed;
  }
  
  bool get isCompleted => status == TaskStatus.completed;
}
```

### 2. Constructor Types
```dart
class User {
  final String id;
  final String name;
  final String email;
  
  // Default constructor
  User({required this.id, required this.name, required this.email});
  
  // Named constructor
  User.guest() : id = 'guest', name = 'Guest User', email = 'guest@example.com';
  
  // Factory constructor
  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      id: json['id'],
      name: json['name'], 
      email: json['email'],
    );
  }
}
```

## Examples

Study the examples in the `examples/` directory:
- `basic_classes.dart` - Class fundamentals
- `constructors_demo.dart` - Different constructor types
- `inheritance_example.dart` - Inheritance and polymorphism
- `task_models.dart` - Domain-specific classes

## Exercises

Complete the exercises in the `exercises/` directory.

## Next Steps

Ready for [Module 5: Enums and Pattern Matching](../05_enums_patterns/README.md)?