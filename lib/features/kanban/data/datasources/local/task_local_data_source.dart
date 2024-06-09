import 'package:hive/hive.dart';
import 'package:task_manager_app/features/kanban/data/dto/create_task_dto.dart';
import 'package:task_manager_app/features/kanban/data/dto/update_task_dto.dart';
import 'package:task_manager_app/features/kanban/domain/entities/task.dart';

abstract class TaskLocalDataSource {
  Future<List<Task?>> getTasks(String projectId);
  Future<Task?> createTask(CreateTaskDto createTaskDto);
  Future<Task?> updateTask(String id, UpdateTaskDto updateTaskDto);
  Future<Task?> getTask(String id);
}

class TaskLocalDataSourceImp implements TaskLocalDataSource {
  static const String _boxName = 'tasks';

  @override
  Future<List<Task>> getTasks(String projectId) async {
    final box = await Hive.openBox<Task>(_boxName);
    final tasks = box.values.where((task) => task.projectId == projectId).toList();
    await box.close();
    return tasks;
  }

  @override
  Future<Task?> createTask(CreateTaskDto createTaskDto) async {
    final box = await Hive.openBox<Task>(_boxName);

    final task = Task(
      creatorId: '',
      createdAt: '',
      assigneeId: '',
      assignerId: '',
      commentCount: 0,
      isCompleted: false,
      content: createTaskDto.content,
      description: createTaskDto.description,
      due: Due(
        date: createTaskDto.dueDatetime,
        isRecurring: false,
        datetime: '',
        string: '',
        timezone: '',
      ),
      duration: null,
      id: '', // Generate or assign appropriate ID
      labels: createTaskDto.labels,
      order: 0,
      priority: createTaskDto.priority,
      projectId: createTaskDto.projectId,
      sectionId: '',
      parentId: '',
      url: '',
    );

    await box.put(task.id, task);
    await box.close();
    return task;
  }

  @override
  Future<Task?> updateTask(String id, UpdateTaskDto updateTaskDto) async {
    final box = await Hive.openBox<Task>(_boxName);
    final task = box.get(id);

    if (task != null) {
      // Update task properties if provided in the UpdateTaskDto
      if (updateTaskDto.content != null) task.content = updateTaskDto.content!;
      if (updateTaskDto.description != null) task.description = updateTaskDto.description!;
      if (updateTaskDto.dueDatetime != null) {
        task.due = Due(
          date: updateTaskDto.dueDatetime,
          isRecurring: false,
          datetime: '',
          string: '',
          timezone: '',
        );
      }
      if (updateTaskDto.labels != null) task.labels = updateTaskDto.labels!;
      if (updateTaskDto.priority != null) task.priority = updateTaskDto.priority!;

      // Save the updated task back to the local database
      await box.put(id, task);
    }

    await box.close();
    return task;
  }

  @override
  Future<Task?> getTask(String id) async {
    final box = await Hive.openBox<Task>(_boxName);
    final task = box.get(id);
    await box.close();
    return task;
  }
}
