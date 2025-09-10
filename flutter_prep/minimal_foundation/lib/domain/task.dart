/// Domain models for the Task & Ticket Tracker application
/// 
/// This file contains the core business entities that represent
/// the fundamental concepts in our task management domain.

import 'package:json_annotation/json_annotation.dart';

part 'task.g.dart';

/// Represents the status of a task
enum TaskStatus {
  /// Task has been created but not started
  pending,
  
  /// Task is currently being worked on
  inProgress,
  
  /// Task has been completed successfully
  completed,
  
  /// Task has been cancelled and will not be completed
  cancelled,
}

/// Represents the priority level of a task
enum TaskPriority {
  /// Low priority task - can be done when time permits
  low,
  
  /// Normal priority task - should be completed in reasonable time
  normal,
  
  /// High priority task - should be completed soon
  high,
  
  /// Critical priority task - needs immediate attention
  critical,
}

/// A basic task in the task tracking system
/// 
/// This class represents a single task with all its properties
/// including title, description, status, priority, and timing information.
@JsonSerializable()
class Task {
  /// Unique identifier for the task
  final String id;
  
  /// The title/summary of the task
  final String title;
  
  /// Detailed description of what needs to be done
  final String? description;
  
  /// Current status of the task
  final TaskStatus status;
  
  /// Priority level of the task
  final TaskPriority priority;
  
  /// When the task was created
  final DateTime createdAt;
  
  /// When the task was last updated
  final DateTime? updatedAt;
  
  /// When the task is due (if applicable)
  final DateTime? dueDate;
  
  /// Who the task is assigned to
  final String? assignedTo;
  
  /// Tags or categories for the task
  final List<String> tags;

  /// Creates a new task with the specified properties
  const Task({
    required this.id,
    required this.title,
    this.description,
    this.status = TaskStatus.pending,
    this.priority = TaskPriority.normal,
    required this.createdAt,
    this.updatedAt,
    this.dueDate,
    this.assignedTo,
    this.tags = const [],
  });

  /// Creates a new task with updated properties
  /// 
  /// This method allows you to create a copy of a task with some
  /// properties changed, which is useful for updating tasks immutably.
  Task copyWith({
    String? id,
    String? title,
    String? description,
    TaskStatus? status,
    TaskPriority? priority,
    DateTime? createdAt,
    DateTime? updatedAt,
    DateTime? dueDate,
    String? assignedTo,
    List<String>? tags,
  }) {
    return Task(
      id: id ?? this.id,
      title: title ?? this.title,
      description: description ?? this.description,
      status: status ?? this.status,
      priority: priority ?? this.priority,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      dueDate: dueDate ?? this.dueDate,
      assignedTo: assignedTo ?? this.assignedTo,
      tags: tags ?? this.tags,
    );
  }

  /// Checks if the task is overdue
  bool get isOverdue {
    if (dueDate == null || status == TaskStatus.completed) {
      return false;
    }
    return DateTime.now().isAfter(dueDate!);
  }

  /// Checks if the task is completed
  bool get isCompleted => status == TaskStatus.completed;

  /// Checks if the task is in progress
  bool get isInProgress => status == TaskStatus.inProgress;

  /// JSON serialization support
  factory Task.fromJson(Map<String, dynamic> json) => _$TaskFromJson(json);
  
  /// JSON serialization support
  Map<String, dynamic> toJson() => _$TaskToJson(this);

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is Task &&
          runtimeType == other.runtimeType &&
          id == other.id;

  @override
  int get hashCode => id.hashCode;

  @override
  String toString() {
    return 'Task{id: $id, title: $title, status: $status, priority: $priority}';
  }
}

/// A user in the task tracking system
/// 
/// Represents someone who can create, assign, and work on tasks.
@JsonSerializable()
class User {
  /// Unique identifier for the user
  final String id;
  
  /// Display name of the user
  final String name;
  
  /// Email address of the user
  final String email;
  
  /// When the user account was created
  final DateTime createdAt;
  
  /// Whether the user account is active
  final bool isActive;

  /// Creates a new user
  const User({
    required this.id,
    required this.name,
    required this.email,
    required this.createdAt,
    this.isActive = true,
  });

  /// Creates a copy of the user with updated properties
  User copyWith({
    String? id,
    String? name,
    String? email,
    DateTime? createdAt,
    bool? isActive,
  }) {
    return User(
      id: id ?? this.id,
      name: name ?? this.name,
      email: email ?? this.email,
      createdAt: createdAt ?? this.createdAt,
      isActive: isActive ?? this.isActive,
    );
  }

  /// JSON serialization support
  factory User.fromJson(Map<String, dynamic> json) => _$UserFromJson(json);
  
  /// JSON serialization support
  Map<String, dynamic> toJson() => _$UserToJson(this);

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is User &&
          runtimeType == other.runtimeType &&
          id == other.id;

  @override
  int get hashCode => id.hashCode;

  @override
  String toString() {
    return 'User{id: $id, name: $name, email: $email}';
  }
}