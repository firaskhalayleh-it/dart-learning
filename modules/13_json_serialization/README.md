# Module 13: JSON and Serialization

Learn how to work with JSON data in Dart, including parsing, serialization, and code generation.

## Learning Objectives

By the end of this module, you will be able to:
- Parse JSON data manually and with code generation
- Serialize Dart objects to JSON
- Use json_annotation and json_serializable packages
- Handle nested objects and collections
- Implement data persistence for tasks

## Key Concepts

### 1. Manual JSON Parsing
```dart
class Task {
  // ... properties
  
  factory Task.fromJson(Map<String, dynamic> json) {
    return Task(
      id: json['id'] as String,
      title: json['title'] as String,
      description: json['description'] as String?,
      status: TaskStatus.values.byName(json['status'] as String),
      priority: TaskPriority.values.byName(json['priority'] as String),
      createdAt: DateTime.parse(json['createdAt'] as String),
      dueDate: json['dueDate'] != null 
        ? DateTime.parse(json['dueDate'] as String) 
        : null,
      tags: (json['tags'] as List<dynamic>).cast<String>(),
    );
  }
  
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'description': description,
      'status': status.name,
      'priority': priority.name,
      'createdAt': createdAt.toIso8601String(),
      'dueDate': dueDate?.toIso8601String(),
      'tags': tags,
    };
  }
}
```

### 2. Code Generation with json_serializable
```dart
import 'package:json_annotation/json_annotation.dart';

part 'task.g.dart';

@JsonSerializable()
class Task {
  final String id;
  final String title;
  // ... other properties
  
  const Task({required this.id, required this.title, /* ... */});
  
  factory Task.fromJson(Map<String, dynamic> json) => _$TaskFromJson(json);
  Map<String, dynamic> toJson() => _$TaskToJson(this);
}
```

## Examples

Study the examples in the `examples/` directory for practical JSON handling patterns.

## Next Steps

Ready for [Module 14: Architecture Patterns](../14_architecture_patterns/README.md)?