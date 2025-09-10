/// Data access layer for the Task & Ticket Tracker application
/// 
/// This file contains repository interfaces and implementations
/// for managing task data persistence and retrieval.

import '../domain/task.dart';

/// Abstract repository interface for task data operations
/// 
/// This interface defines the contract for task data access,
/// allowing different implementations (in-memory, file-based, database, etc.)
abstract class TaskRepository {
  /// Retrieves all tasks
  Future<List<Task>> getAllTasks();
  
  /// Retrieves a task by its ID
  Future<Task?> getTaskById(String id);
  
  /// Retrieves tasks filtered by status
  Future<List<Task>> getTasksByStatus(TaskStatus status);
  
  /// Retrieves tasks assigned to a specific user
  Future<List<Task>> getTasksByAssignee(String userId);
  
  /// Retrieves tasks with a specific priority
  Future<List<Task>> getTasksByPriority(TaskPriority priority);
  
  /// Creates a new task
  Future<Task> createTask(Task task);
  
  /// Updates an existing task
  Future<Task> updateTask(Task task);
  
  /// Deletes a task by ID
  Future<bool> deleteTask(String id);
  
  /// Searches tasks by title or description
  Future<List<Task>> searchTasks(String query);
}

/// In-memory implementation of TaskRepository
/// 
/// This implementation stores tasks in memory and is useful for
/// development, testing, and prototyping. Data is lost when the
/// application restarts.
class InMemoryTaskRepository implements TaskRepository {
  /// Internal storage for tasks
  final Map<String, Task> _tasks = {};

  /// Creates a new in-memory task repository with optional initial data
  InMemoryTaskRepository([List<Task>? initialTasks]) {
    if (initialTasks != null) {
      for (final task in initialTasks) {
        _tasks[task.id] = task;
      }
    }
  }

  @override
  Future<List<Task>> getAllTasks() async {
    return _tasks.values.toList()
      ..sort((a, b) => b.createdAt.compareTo(a.createdAt));
  }

  @override
  Future<Task?> getTaskById(String id) async {
    return _tasks[id];
  }

  @override
  Future<List<Task>> getTasksByStatus(TaskStatus status) async {
    return _tasks.values
        .where((task) => task.status == status)
        .toList()
      ..sort((a, b) => b.createdAt.compareTo(a.createdAt));
  }

  @override
  Future<List<Task>> getTasksByAssignee(String userId) async {
    return _tasks.values
        .where((task) => task.assignedTo == userId)
        .toList()
      ..sort((a, b) => b.createdAt.compareTo(a.createdAt));
  }

  @override
  Future<List<Task>> getTasksByPriority(TaskPriority priority) async {
    return _tasks.values
        .where((task) => task.priority == priority)
        .toList()
      ..sort((a, b) => b.createdAt.compareTo(a.createdAt));
  }

  @override
  Future<Task> createTask(Task task) async {
    if (_tasks.containsKey(task.id)) {
      throw ArgumentError('Task with ID ${task.id} already exists');
    }
    
    _tasks[task.id] = task;
    return task;
  }

  @override
  Future<Task> updateTask(Task task) async {
    if (!_tasks.containsKey(task.id)) {
      throw ArgumentError('Task with ID ${task.id} not found');
    }
    
    final updatedTask = task.copyWith(
      updatedAt: DateTime.now(),
    );
    
    _tasks[task.id] = updatedTask;
    return updatedTask;
  }

  @override
  Future<bool> deleteTask(String id) async {
    return _tasks.remove(id) != null;
  }

  @override
  Future<List<Task>> searchTasks(String query) async {
    final lowerQuery = query.toLowerCase();
    
    return _tasks.values
        .where((task) =>
            task.title.toLowerCase().contains(lowerQuery) ||
            (task.description?.toLowerCase().contains(lowerQuery) ?? false))
        .toList()
      ..sort((a, b) => b.createdAt.compareTo(a.createdAt));
  }

  /// Gets the total number of tasks
  int get taskCount => _tasks.length;

  /// Clears all tasks (useful for testing)
  void clear() {
    _tasks.clear();
  }
}

/// User repository interface
/// 
/// Similar to TaskRepository but for user management
abstract class UserRepository {
  /// Retrieves all users
  Future<List<User>> getAllUsers();
  
  /// Retrieves a user by ID
  Future<User?> getUserById(String id);
  
  /// Retrieves a user by email
  Future<User?> getUserByEmail(String email);
  
  /// Creates a new user
  Future<User> createUser(User user);
  
  /// Updates an existing user
  Future<User> updateUser(User user);
  
  /// Deletes a user by ID
  Future<bool> deleteUser(String id);
}

/// In-memory implementation of UserRepository
class InMemoryUserRepository implements UserRepository {
  /// Internal storage for users
  final Map<String, User> _users = {};

  /// Creates a new in-memory user repository with optional initial data
  InMemoryUserRepository([List<User>? initialUsers]) {
    if (initialUsers != null) {
      for (final user in initialUsers) {
        _users[user.id] = user;
      }
    }
  }

  @override
  Future<List<User>> getAllUsers() async {
    return _users.values.toList()
      ..sort((a, b) => a.name.compareTo(b.name));
  }

  @override
  Future<User?> getUserById(String id) async {
    return _users[id];
  }

  @override
  Future<User?> getUserByEmail(String email) async {
    return _users.values
        .where((user) => user.email == email)
        .firstOrNull;
  }

  @override
  Future<User> createUser(User user) async {
    if (_users.containsKey(user.id)) {
      throw ArgumentError('User with ID ${user.id} already exists');
    }
    
    // Check for duplicate email
    final existingUser = await getUserByEmail(user.email);
    if (existingUser != null) {
      throw ArgumentError('User with email ${user.email} already exists');
    }
    
    _users[user.id] = user;
    return user;
  }

  @override
  Future<User> updateUser(User user) async {
    if (!_users.containsKey(user.id)) {
      throw ArgumentError('User with ID ${user.id} not found');
    }
    
    _users[user.id] = user;
    return user;
  }

  @override
  Future<bool> deleteUser(String id) async {
    return _users.remove(id) != null;
  }

  /// Gets the total number of users
  int get userCount => _users.length;

  /// Clears all users (useful for testing)
  void clear() {
    _users.clear();
  }
}