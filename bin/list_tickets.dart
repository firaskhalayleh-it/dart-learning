#!/usr/bin/env dart

/// Command-line utility to list and manage tickets in the Task Tracker
/// 
/// This utility demonstrates how to use the foundation library
/// and provides a simple CLI interface for task management.

import 'dart:io';
import '../flutter_prep/minimal_foundation/lib/foundation.dart';

/// Main entry point for the ticket listing utility
void main(List<String> arguments) async {
  print('🎯 Task & Ticket Tracker - CLI Utility');
  print('======================================');

  // Initialize repositories and service
  final taskRepository = InMemoryTaskRepository();
  final userRepository = InMemoryUserRepository();
  final taskService = TaskService(
    taskRepository: taskRepository,
    userRepository: userRepository,
  );

  // Create some sample data
  await _createSampleData(taskService, userRepository);

  // Process command line arguments
  if (arguments.isEmpty) {
    await _showUsage();
    await _listAllTasks(taskService);
  } else {
    final command = arguments[0].toLowerCase();
    switch (command) {
      case 'list':
      case 'ls':
        await _listAllTasks(taskService);
        break;
      case 'stats':
        await _showStatistics(taskService);
        break;
      case 'pending':
        await _listTasksByStatus(taskService, TaskStatus.pending);
        break;
      case 'completed':
        await _listTasksByStatus(taskService, TaskStatus.completed);
        break;
      case 'overdue':
        await _listOverdueTasks(taskService);
        break;
      case 'search':
        if (arguments.length < 2) {
          print('❌ Search requires a query. Usage: dart run bin/list_tickets.dart search <query>');
          exit(1);
        }
        await _searchTasks(taskService, arguments[1]);
        break;
      case 'help':
      case '-h':
      case '--help':
        await _showUsage();
        break;
      default:
        print('❌ Unknown command: $command');
        await _showUsage();
        exit(1);
    }
  }
}

/// Shows usage information for the CLI utility
Future<void> _showUsage() async {
  print('''
Usage: dart run bin/list_tickets.dart [command]

Commands:
  list, ls      List all tasks (default)
  stats         Show task statistics
  pending       List pending tasks
  completed     List completed tasks
  overdue       List overdue tasks
  search <query> Search tasks by title or description
  help          Show this help message

Examples:
  dart run bin/list_tickets.dart
  dart run bin/list_tickets.dart pending
  dart run bin/list_tickets.dart search "grocery"
''');
}

/// Lists all tasks
Future<void> _listAllTasks(TaskService taskService) async {
  print('\n📋 All Tasks:');
  print('━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━');
  
  final tasks = await taskService.getAllTasks();
  
  if (tasks.isEmpty) {
    print('No tasks found.');
    return;
  }

  for (final task in tasks) {
    _printTask(task);
  }
}

/// Lists tasks by status
Future<void> _listTasksByStatus(TaskService taskService, TaskStatus status) async {
  final statusName = status.name.toUpperCase();
  print('\n📋 $statusName Tasks:');
  print('━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━');
  
  final tasks = await taskService.getTasksByStatus(status);
  
  if (tasks.isEmpty) {
    print('No $statusName tasks found.');
    return;
  }

  for (final task in tasks) {
    _printTask(task);
  }
}

/// Lists overdue tasks
Future<void> _listOverdueTasks(TaskService taskService) async {
  print('\n⏰ Overdue Tasks:');
  print('━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━');
  
  final tasks = await taskService.getOverdueTasks();
  
  if (tasks.isEmpty) {
    print('No overdue tasks found. Great job! 🎉');
    return;
  }

  for (final task in tasks) {
    _printTask(task);
  }
}

/// Searches for tasks
Future<void> _searchTasks(TaskService taskService, String query) async {
  print('\n🔍 Search Results for "$query":');
  print('━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━');
  
  final tasks = await taskService.searchTasks(query);
  
  if (tasks.isEmpty) {
    print('No tasks found matching "$query".');
    return;
  }

  for (final task in tasks) {
    _printTask(task);
  }
}

/// Shows task statistics
Future<void> _showStatistics(TaskService taskService) async {
  print('\n📊 Task Statistics:');
  print('━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━');
  
  final stats = await taskService.getTaskStatistics();
  
  print('Total Tasks:      ${stats.total}');
  print('Pending:          ${stats.pending}');
  print('In Progress:      ${stats.inProgress}');
  print('Completed:        ${stats.completed}');
  print('Overdue:          ${stats.overdue}');
  
  if (stats.total > 0) {
    final completionRate = (stats.completed / stats.total * 100).toStringAsFixed(1);
    print('Completion Rate:  $completionRate%');
  }
}

/// Prints a single task with formatting
void _printTask(Task task) {
  final statusIcon = _getStatusIcon(task.status);
  final priorityIcon = _getPriorityIcon(task.priority);
  final overdueIcon = task.isOverdue ? ' ⚠️' : '';
  
  print('$statusIcon $priorityIcon ${task.title}$overdueIcon');
  
  if (task.description != null && task.description!.isNotEmpty) {
    print('   📝 ${task.description}');
  }
  
  if (task.assignedTo != null) {
    print('   👤 Assigned to: ${task.assignedTo}');
  }
  
  if (task.dueDate != null) {
    final dueStr = _formatDate(task.dueDate!);
    print('   📅 Due: $dueStr');
  }
  
  if (task.tags.isNotEmpty) {
    print('   🏷️  Tags: ${task.tags.join(", ")}');
  }
  
  print('   🆔 ID: ${task.id}');
  print('');
}

/// Gets the appropriate icon for a task status
String _getStatusIcon(TaskStatus status) {
  switch (status) {
    case TaskStatus.pending:
      return '⭕';
    case TaskStatus.inProgress:
      return '🔄';
    case TaskStatus.completed:
      return '✅';
    case TaskStatus.cancelled:
      return '❌';
  }
}

/// Gets the appropriate icon for a task priority
String _getPriorityIcon(TaskPriority priority) {
  switch (priority) {
    case TaskPriority.low:
      return '🔵';
    case TaskPriority.normal:
      return '🟢';
    case TaskPriority.high:
      return '🟡';
    case TaskPriority.critical:
      return '🔴';
  }
}

/// Formats a DateTime for display
String _formatDate(DateTime date) {
  final now = DateTime.now();
  final difference = date.difference(now);
  
  if (difference.inDays < 0) {
    return '${date.day}/${date.month}/${date.year} (${-difference.inDays} days ago)';
  } else if (difference.inDays == 0) {
    return 'Today';
  } else if (difference.inDays == 1) {
    return 'Tomorrow';
  } else {
    return '${date.day}/${date.month}/${date.year} (in ${difference.inDays} days)';
  }
}

/// Creates sample data for demonstration
Future<void> _createSampleData(TaskService taskService, UserRepository userRepository) async {
  // Create sample users
  final user1 = User(
    id: 'user_1',
    name: 'Alice Developer',
    email: 'alice@example.com',
    createdAt: DateTime.now().subtract(const Duration(days: 30)),
  );
  
  final user2 = User(
    id: 'user_2',
    name: 'Bob Manager',
    email: 'bob@example.com',
    createdAt: DateTime.now().subtract(const Duration(days: 20)),
  );
  
  await userRepository.createUser(user1);
  await userRepository.createUser(user2);

  // Create sample tasks
  await taskService.createTask(
    title: 'Setup development environment',
    description: 'Install Dart SDK, VS Code, and configure workspace',
    priority: TaskPriority.high,
    assignedTo: 'user_1',
    tags: ['setup', 'development'],
  );

  await taskService.createTask(
    title: 'Learn Dart basics',
    description: 'Complete modules 1-5 of the Dart learning path',
    priority: TaskPriority.normal,
    assignedTo: 'user_1',
    dueDate: DateTime.now().add(const Duration(days: 7)),
    tags: ['learning', 'dart'],
  );

  await taskService.createTask(
    title: 'Review project requirements',
    description: 'Go through the project specification and create task breakdown',
    priority: TaskPriority.normal,
    assignedTo: 'user_2',
    tags: ['planning', 'requirements'],
  );

  await taskService.createTask(
    title: 'Buy groceries',
    description: 'Milk, bread, eggs, and vegetables for the week',
    priority: TaskPriority.low,
    dueDate: DateTime.now().subtract(const Duration(days: 1)), // Overdue!
    tags: ['personal', 'shopping'],
  );

  final completedTask = await taskService.createTask(
    title: 'Read Dart documentation',
    description: 'Go through the official Dart language tour',
    priority: TaskPriority.normal,
    assignedTo: 'user_1',
    tags: ['learning', 'documentation'],
  );

  // Mark one task as completed
  await taskService.completeTask(completedTask.id);
}