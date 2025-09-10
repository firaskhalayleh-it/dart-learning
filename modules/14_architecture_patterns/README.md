# Module 14: Architecture Patterns

Learn clean architecture principles and design patterns that prepare you for scalable Flutter applications.

## Learning Objectives

By the end of this module, you will be able to:
- Understand clean architecture principles
- Implement the Repository pattern
- Use dependency injection effectively
- Apply separation of concerns
- Structure code for maintainability and testability

## Key Concepts

### 1. Clean Architecture Layers
```dart
// Domain Layer - Business entities
class Task { /* ... */ }

// Data Layer - Data access
abstract class TaskRepository { /* ... */ }
class LocalTaskRepository implements TaskRepository { /* ... */ }

// Service/Use Case Layer - Business logic  
class TaskService {
  final TaskRepository _repository;
  TaskService(this._repository);
  /* ... business methods ... */
}

// Presentation Layer - UI (Future Flutter widgets)
```

### 2. Dependency Injection
```dart
class ServiceLocator {
  static final _instance = ServiceLocator._internal();
  factory ServiceLocator() => _instance;
  ServiceLocator._internal();
  
  final Map<Type, dynamic> _services = {};
  
  void register<T>(T service) => _services[T] = service;
  T get<T>() => _services[T] as T;
}

// Usage
void main() {
  // Register dependencies
  ServiceLocator().register<TaskRepository>(InMemoryTaskRepository());
  ServiceLocator().register<TaskService>(
    TaskService(ServiceLocator().get<TaskRepository>())
  );
}
```

### 3. Repository Pattern Implementation
```dart
abstract class TaskRepository {
  Future<List<Task>> getAllTasks();
  Future<Task?> getTaskById(String id);
  Future<Task> saveTask(Task task);
  Future<bool> deleteTask(String id);
}

class FileTaskRepository implements TaskRepository {
  final String _filePath;
  FileTaskRepository(this._filePath);
  
  @override
  Future<List<Task>> getAllTasks() async {
    // File-based implementation
  }
  
  // ... other methods
}
```

## Examples

Study the examples demonstrating clean architecture in practice.

## Next Steps

Ready for [Module 15: Flutter Preparation](../15_flutter_prep/README.md)?