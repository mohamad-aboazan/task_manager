import 'package:task_manager_app/features/kanban/data/dto/create_task_dto.dart';
import 'package:task_manager_app/features/kanban/data/dto/update_task_dto.dart';
import 'package:task_manager_app/features/kanban/domain/entities/task.dart';

abstract class TaskRepository {
  Future<List<Task>> getTasks(String projectId);
  Future<Task> getTask(String id);
  Future<Task> createTask(CreateTaskDto createTaskDto);
  Future<Task> updateTask(String id, UpdateTaskDto updateTaskDto);
  Future<void> deleteTask(String id);
}
