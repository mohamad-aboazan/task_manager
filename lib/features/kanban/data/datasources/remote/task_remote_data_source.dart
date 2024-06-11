import 'package:task_manager_app/core/services/api_service.dart';
import 'package:task_manager_app/core/utils/endpoints.dart';
import 'package:task_manager_app/features/kanban/data/dto/create_task_dto.dart';
import 'package:task_manager_app/features/kanban/data/dto/update_task_dto.dart';
import 'package:task_manager_app/features/kanban/domain/entities/task.dart';

/// =================================================================================================
/// Remote data source for managing tasks.
///
/// This data source handles operations related to tasks through remote API calls using the `ApiService`.
///
/// Dependencies:
///   - `ApiService`: Service for making API calls.
///   - `Endpoints`: Utility class for defining API endpoints.
///
/// Abstract Methods:
///   - `getTasks`: Fetches all tasks associated with a project from the remote API.
///   - `createTask`: Creates a new task via the remote API.
///   - `updateTask`: Updates an existing task via the remote API.
///   - `getTask`: Fetches a specific task by ID from the remote API.
///   - `deleteTask`: Deletes a task with the specified ID from the remote API.
///
/// Usage:
///   - Implement the `TaskRemoteDataSource` abstract class with the required methods.
///   - Utilize `ApiService` to make HTTP requests to the appropriate endpoints for task management.
///
/// =================================================================================================

abstract class TaskRemoteDataSource {
  Future<List<Task>> getTasks(String projectId);
  Future<Task> createTask(CreateTaskDto createTaskDto);
  Future<Task> updateTask(String id, UpdateTaskDto updateTaskDto);
  Future<Task> getTask(String id);
  Future<void> deleteTask(String id);
}

class TaskRemoteDataSourceImp implements TaskRemoteDataSource {
  final ApiService apiService;
  TaskRemoteDataSourceImp({required this.apiService});

  @override
  Future<Task> createTask(CreateTaskDto createTaskDto) async {
    var responseData = await apiService.post(Endpoints.TASKS, createTaskDto.toJson());
    Task task = Task.fromJson(responseData);
    return task;
  }

  @override
  Future<Task> updateTask(String id, UpdateTaskDto updateTaskDto) async {
    var responseData = await apiService.post("${Endpoints.TASKS}/$id", updateTaskDto.toJson());
    Task task = Task.fromJson(responseData);
    return task;
  }

  @override
  Future<Task> getTask(String id) {
    throw UnimplementedError();
  }

  @override
  Future<List<Task>> getTasks(String projectId) async {
    var responseData = await apiService.get('${Endpoints.TASKS}?project_id=$projectId');
    List<Task> tasks = responseData.map((e) => Task.fromJson(e)).toList().cast<Task>();
    return tasks;
  }

  @override
  Future<void> deleteTask(String id) async {
    await apiService.delete('${Endpoints.TASKS}/$id');
  }
}
