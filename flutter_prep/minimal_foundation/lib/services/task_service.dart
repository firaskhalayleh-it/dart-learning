/// Business logic services for the Task & Ticket Tracker application
/// 
/// This file contains service classes that implement business logic
/// and coordinate between the UI and data layers.

import '../domain/task.dart';
import '../data/repositories.dart';

/// Exception thrown when a task operation fails
class TaskServiceException implements Exception {
  /// The error message
  final String message;
  
  /// Optional underlying cause
  final Object? cause;
  
  /// Creates a new task service exception
  const TaskServiceException(this.message, [this.cause]);
  
  @override
  String toString() => 'TaskServiceException: $message';
}

/// Service class for managing task operations
/// 
/// This class provides high-level business logic for task management,
/// including validation, business rules, and coordination with the data layer.
class TaskService {
  /// The task repository for data access
  final TaskRepository _taskRepository;
  
  /// The user repository for user validation
  final UserRepository _userRepository;

  /// Creates a new task service with the specified repositories
  TaskService({
    required TaskRepository taskRepository,
    required UserRepository userRepository,
  })  : _taskRepository = taskRepository,
        _userRepository = userRepository;

  /// Retrieves all tasks, sorted by creation date (newest first)
  Future<List<Task>> getAllTasks() async {
    try {
      return await _taskRepository.getAllTasks();
    } catch (e) {
      throw TaskServiceException('Failed to retrieve tasks', e);
    }
  }

  /// Retrieves a task by its ID
  /// 
  /// Returns null if the task is not found.
  Future<Task?> getTaskById(String id) async {
    if (id.trim().isEmpty) {
      throw TaskServiceException('Task ID cannot be empty');
    }
    
    try {
      return await _taskRepository.getTaskById(id);
    } catch (e) {
      throw TaskServiceException('Failed to retrieve task with ID $id', e);
    }
  }

  /// Creates a new task with validation
  /// 
  /// Validates the task data and generates a unique ID if not provided.
  Future<Task> createTask({
    required String title,
    String? description,
    TaskPriority priority = TaskPriority.normal,
    DateTime? dueDate,
    String? assignedTo,
    List<String> tags = const [],
  }) async {
    // Validate input
    if (title.trim().isEmpty) {
      throw TaskServiceException('Task title cannot be empty');
    }
    
    // Validate assignee exists if specified
    if (assignedTo != null) {
      final user = await _userRepository.getUserById(assignedTo);
      if (user == null) {
        throw TaskServiceException('Assigned user not found: $assignedTo');
      }
    }
    
    // Validate due date is in the future
    if (dueDate != null && dueDate.isBefore(DateTime.now())) {
      throw TaskServiceException('Due date cannot be in the past');
    }
    
    try {
      final task = Task(
        id: _generateTaskId(),
        title: title.trim(),
        description: description?.trim(),
        priority: priority,
        createdAt: DateTime.now(),
        dueDate: dueDate,
        assignedTo: assignedTo,
        tags: List.unmodifiable(tags),
      );
      
      return await _taskRepository.createTask(task);
    } catch (e) {
      throw TaskServiceException('Failed to create task', e);
    }
  }

  /// Updates an existing task
  Future<Task> updateTask(Task task) async {
    // Validate the task exists
    final existingTask = await _taskRepository.getTaskById(task.id);
    if (existingTask == null) {
      throw TaskServiceException('Task not found: ${task.id}');
    }
    
    // Validate assignee exists if specified
    if (task.assignedTo != null) {
      final user = await _userRepository.getUserById(task.assignedTo!);
      if (user == null) {
        throw TaskServiceException('Assigned user not found: ${task.assignedTo}');
      }
    }
    
    // Validate title is not empty
    if (task.title.trim().isEmpty) {
      throw TaskServiceException('Task title cannot be empty');
    }
    
    try {
      return await _taskRepository.updateTask(task);
    } catch (e) {
      throw TaskServiceException('Failed to update task', e);
    }
  }

  /// Marks a task as completed
  Future<Task> completeTask(String taskId) async {
    final task = await getTaskById(taskId);
    if (task == null) {
      throw TaskServiceException('Task not found: $taskId');
    }
    
    if (task.isCompleted) {
      throw TaskServiceException('Task is already completed');
    }
    
    final completedTask = task.copyWith(
      status: TaskStatus.completed,
      updatedAt: DateTime.now(),
    );
    
    return await updateTask(completedTask);
  }

  /// Starts work on a task (sets status to in progress)
  Future<Task> startTask(String taskId) async {
    final task = await getTaskById(taskId);
    if (task == null) {
      throw TaskServiceException('Task not found: $taskId');
    }
    
    if (task.status != TaskStatus.pending) {
      throw TaskServiceException('Can only start pending tasks');
    }
    
    final startedTask = task.copyWith(
      status: TaskStatus.inProgress,
      updatedAt: DateTime.now(),
    );
    
    return await updateTask(startedTask);
  }

  /// Assigns a task to a user
  Future<Task> assignTask(String taskId, String userId) async {
    final task = await getTaskById(taskId);
    if (task == null) {
      throw TaskServiceException('Task not found: $taskId');
    }
    
    final user = await _userRepository.getUserById(userId);
    if (user == null) {
      throw TaskServiceException('User not found: $userId');
    }
    
    final assignedTask = task.copyWith(
      assignedTo: userId,
      updatedAt: DateTime.now(),
    );
    
    return await updateTask(assignedTask);
  }

  /// Deletes a task
  Future<bool> deleteTask(String taskId) async {
    if (taskId.trim().isEmpty) {
      throw TaskServiceException('Task ID cannot be empty');
    }
    
    try {
      return await _taskRepository.deleteTask(taskId);
    } catch (e) {
      throw TaskServiceException('Failed to delete task', e);
    }
  }

  /// Searches for tasks by title or description
  Future<List<Task>> searchTasks(String query) async {
    if (query.trim().isEmpty) {
      return await getAllTasks();
    }
    
    try {
      return await _taskRepository.searchTasks(query.trim());
    } catch (e) {
      throw TaskServiceException('Failed to search tasks', e);
    }
  }

  /// Gets tasks by status
  Future<List<Task>> getTasksByStatus(TaskStatus status) async {
    try {
      return await _taskRepository.getTasksByStatus(status);
    } catch (e) {
      throw TaskServiceException('Failed to retrieve tasks by status', e);
    }
  }

  /// Gets tasks assigned to a specific user
  Future<List<Task>> getTasksByAssignee(String userId) async {
    try {
      return await _taskRepository.getTasksByAssignee(userId);
    } catch (e) {
      throw TaskServiceException('Failed to retrieve tasks by assignee', e);
    }
  }

  /// Gets overdue tasks
  Future<List<Task>> getOverdueTasks() async {
    final allTasks = await getAllTasks();
    return allTasks.where((task) => task.isOverdue).toList();
  }

  /// Gets task statistics
  Future<TaskStatistics> getTaskStatistics() async {
    final allTasks = await getAllTasks();
    
    return TaskStatistics(
      total: allTasks.length,
      pending: allTasks.where((t) => t.status == TaskStatus.pending).length,
      inProgress: allTasks.where((t) => t.status == TaskStatus.inProgress).length,
      completed: allTasks.where((t) => t.status == TaskStatus.completed).length,
      overdue: allTasks.where((t) => t.isOverdue).length,
    );
  }

  /// Generates a unique task ID
  String _generateTaskId() {
    return 'task_${DateTime.now().millisecondsSinceEpoch}';
  }
}

/// Statistics about tasks in the system
class TaskStatistics {
  /// Total number of tasks
  final int total;
  
  /// Number of pending tasks
  final int pending;
  
  /// Number of in-progress tasks
  final int inProgress;
  
  /// Number of completed tasks
  final int completed;
  
  /// Number of overdue tasks
  final int overdue;

  /// Creates new task statistics
  const TaskStatistics({
    required this.total,
    required this.pending,
    required this.inProgress,
    required this.completed,
    required this.overdue,
  });

  @override
  String toString() {
    return 'TaskStatistics{total: $total, pending: $pending, '
        'inProgress: $inProgress, completed: $completed, overdue: $overdue}';
  }
}