/// Sample test for the Task Service
/// 
/// This file demonstrates how to write unit tests for the foundation library
/// and serves as an example for learners to understand testing patterns.

import 'package:test/test.dart';
import '../flutter_prep/minimal_foundation/lib/foundation.dart';

void main() {
  group('TaskService Tests', () {
    late TaskService taskService;
    late InMemoryTaskRepository taskRepository;
    late InMemoryUserRepository userRepository;

    setUp(() {
      taskRepository = InMemoryTaskRepository();
      userRepository = InMemoryUserRepository();
      taskService = TaskService(
        taskRepository: taskRepository,
        userRepository: userRepository,
      );
    });

    group('Task Creation', () {
      test('should create a task with valid data', () async {
        // Act
        final task = await taskService.createTask(
          title: 'Test Task',
          description: 'This is a test task',
          priority: TaskPriority.high,
        );

        // Assert
        expect(task.title, equals('Test Task'));
        expect(task.description, equals('This is a test task'));
        expect(task.priority, equals(TaskPriority.high));
        expect(task.status, equals(TaskStatus.pending));
        expect(task.id, isNotEmpty);
        expect(task.createdAt, isNotNull);
      });

      test('should throw exception when title is empty', () async {
        // Act & Assert
        expect(
          () => taskService.createTask(title: ''),
          throwsA(isA<TaskServiceException>()),
        );
      });

      test('should throw exception when title is only whitespace', () async {
        // Act & Assert
        expect(
          () => taskService.createTask(title: '   '),
          throwsA(isA<TaskServiceException>()),
        );
      });

      test('should throw exception when due date is in the past', () async {
        // Act & Assert
        expect(
          () => taskService.createTask(
            title: 'Test Task',
            dueDate: DateTime.now().subtract(const Duration(days: 1)),
          ),
          throwsA(isA<TaskServiceException>()),
        );
      });
    });

    group('Task Retrieval', () {
      test('should return empty list when no tasks exist', () async {
        // Act
        final tasks = await taskService.getAllTasks();

        // Assert
        expect(tasks, isEmpty);
      });

      test('should return all created tasks', () async {
        // Arrange
        await taskService.createTask(title: 'Task 1');
        await taskService.createTask(title: 'Task 2');

        // Act
        final tasks = await taskService.getAllTasks();

        // Assert
        expect(tasks, hasLength(2));
        expect(tasks.map((t) => t.title), containsAll(['Task 1', 'Task 2']));
      });

      test('should return null when task not found', () async {
        // Act
        final task = await taskService.getTaskById('nonexistent');

        // Assert
        expect(task, isNull);
      });

      test('should throw exception when task ID is empty', () async {
        // Act & Assert
        expect(
          () => taskService.getTaskById(''),
          throwsA(isA<TaskServiceException>()),
        );
      });
    });

    group('Task Status Management', () {
      test('should complete a pending task', () async {
        // Arrange
        final task = await taskService.createTask(title: 'Test Task');

        // Act
        final completedTask = await taskService.completeTask(task.id);

        // Assert
        expect(completedTask.status, equals(TaskStatus.completed));
        expect(completedTask.updatedAt, isNotNull);
        expect(completedTask.isCompleted, isTrue);
      });

      test('should start a pending task', () async {
        // Arrange
        final task = await taskService.createTask(title: 'Test Task');

        // Act
        final startedTask = await taskService.startTask(task.id);

        // Assert
        expect(startedTask.status, equals(TaskStatus.inProgress));
        expect(startedTask.updatedAt, isNotNull);
        expect(startedTask.isInProgress, isTrue);
      });

      test('should throw exception when completing non-existent task', () async {
        // Act & Assert
        expect(
          () => taskService.completeTask('nonexistent'),
          throwsA(isA<TaskServiceException>()),
        );
      });

      test('should throw exception when completing already completed task', () async {
        // Arrange
        final task = await taskService.createTask(title: 'Test Task');
        await taskService.completeTask(task.id);

        // Act & Assert
        expect(
          () => taskService.completeTask(task.id),
          throwsA(isA<TaskServiceException>()),
        );
      });
    });

    group('Task Assignment', () {
      test('should assign task to existing user', () async {
        // Arrange
        final user = User(
          id: 'user_1',
          name: 'Test User',
          email: 'test@example.com',
          createdAt: DateTime.now(),
        );
        await userRepository.createUser(user);
        
        final task = await taskService.createTask(title: 'Test Task');

        // Act
        final assignedTask = await taskService.assignTask(task.id, user.id);

        // Assert
        expect(assignedTask.assignedTo, equals(user.id));
        expect(assignedTask.updatedAt, isNotNull);
      });

      test('should throw exception when assigning to non-existent user', () async {
        // Arrange
        final task = await taskService.createTask(title: 'Test Task');

        // Act & Assert
        expect(
          () => taskService.assignTask(task.id, 'nonexistent_user'),
          throwsA(isA<TaskServiceException>()),
        );
      });
    });

    group('Task Search', () {
      test('should find tasks by title', () async {
        // Arrange
        await taskService.createTask(title: 'Buy groceries');
        await taskService.createTask(title: 'Walk the dog');
        await taskService.createTask(title: 'Buy milk');

        // Act
        final results = await taskService.searchTasks('buy');

        // Assert
        expect(results, hasLength(2));
        expect(results.map((t) => t.title), containsAll(['Buy groceries', 'Buy milk']));
      });

      test('should find tasks by description', () async {
        // Arrange
        await taskService.createTask(
          title: 'Shopping',
          description: 'Buy groceries for the week',
        );
        await taskService.createTask(
          title: 'Exercise',
          description: 'Go for a run',
        );

        // Act
        final results = await taskService.searchTasks('groceries');

        // Assert
        expect(results, hasLength(1));
        expect(results.first.title, equals('Shopping'));
      });

      test('should return all tasks when search query is empty', () async {
        // Arrange
        await taskService.createTask(title: 'Task 1');
        await taskService.createTask(title: 'Task 2');

        // Act
        final results = await taskService.searchTasks('');

        // Assert
        expect(results, hasLength(2));
      });
    });

    group('Task Statistics', () {
      test('should return correct statistics', () async {
        // Arrange
        final task1 = await taskService.createTask(title: 'Task 1');
        final task2 = await taskService.createTask(title: 'Task 2');
        await taskService.createTask(title: 'Task 3');
        
        await taskService.startTask(task1.id);
        await taskService.completeTask(task2.id);

        // Act
        final stats = await taskService.getTaskStatistics();

        // Assert
        expect(stats.total, equals(3));
        expect(stats.pending, equals(1));
        expect(stats.inProgress, equals(1));
        expect(stats.completed, equals(1));
        expect(stats.overdue, equals(0));
      });

      test('should return zero statistics when no tasks exist', () async {
        // Act
        final stats = await taskService.getTaskStatistics();

        // Assert
        expect(stats.total, equals(0));
        expect(stats.pending, equals(0));
        expect(stats.inProgress, equals(0));
        expect(stats.completed, equals(0));
        expect(stats.overdue, equals(0));
      });
    });

    group('Overdue Tasks', () {
      test('should identify overdue tasks', () async {
        // Arrange
        await taskService.createTask(
          title: 'Overdue Task',
          dueDate: DateTime.now().subtract(const Duration(days: 1)),
        );
        await taskService.createTask(
          title: 'Future Task',
          dueDate: DateTime.now().add(const Duration(days: 1)),
        );
        await taskService.createTask(title: 'No Due Date');

        // Act
        final overdueTasks = await taskService.getOverdueTasks();

        // Assert
        expect(overdueTasks, hasLength(1));
        expect(overdueTasks.first.title, equals('Overdue Task'));
        expect(overdueTasks.first.isOverdue, isTrue);
      });

      test('should not include completed tasks as overdue', () async {
        // Arrange
        final task = await taskService.createTask(
          title: 'Completed Overdue Task',
          dueDate: DateTime.now().subtract(const Duration(days: 1)),
        );
        await taskService.completeTask(task.id);

        // Act
        final overdueTasks = await taskService.getOverdueTasks();

        // Assert
        expect(overdueTasks, isEmpty);
      });
    });
  });
}