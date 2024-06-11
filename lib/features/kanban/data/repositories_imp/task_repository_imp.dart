import 'package:task_manager_app/core/network/network_info.dart';
import 'package:task_manager_app/features/kanban/data/datasources/local/task_local_data_source.dart';
import 'package:task_manager_app/features/kanban/data/datasources/remote/task_remote_data_source.dart';
import 'package:task_manager_app/features/kanban/data/dto/update_task_dto.dart';
import 'package:task_manager_app/features/kanban/domain/entities/task.dart';
import 'package:task_manager_app/features/kanban/domain/repository/task_repository.dart';

/// =================================================================================================
/// Task Repository Implementation
///
/// This class implements the `TaskRepository` interface, providing methods to interact with tasks
/// in the Kanban application. It manages communication between the domain layer and both local
/// and remote data sources for task-related operations.
///
/// Dependencies:
///   - `NetworkInfo`: Service for checking network connectivity.
///   - `TaskRemoteDataSource`: Data source for remote task operations.
///   - `TaskLocalDataSource`: Data source for local task operations.
///
/// Usage:
///   - Use instances of this class to perform operations related to tasks, such as creating,
///     updating, and deleting tasks, as well as fetching tasks by ID or project ID.
///
/// =================================================================================================

class TaskRepositoryImpl implements TaskRepository {
  final NetworkInfo networkInfo;
  final TaskRemoteDataSource taskRemoteDataSource;
  final TaskLocalDataSource taskLocalDataSource;

  TaskRepositoryImpl({required this.taskRemoteDataSource, required this.taskLocalDataSource, required this.networkInfo});

  @override
  Future<Task> createTask(createTaskDto) async {
    return await taskRemoteDataSource.createTask(createTaskDto);
  }

  @override
  Future<Task> getTask(String id) {
    throw UnimplementedError();
  }

  @override
  Future<List<Task>> getTasks(String projectId) async {
    return await taskRemoteDataSource.getTasks(projectId);
  }

  @override
  Future<Task> updateTask(String id, UpdateTaskDto updateTaskDto) async {
    return await taskRemoteDataSource.updateTask(id, updateTaskDto);
  }

  @override
  Future<void> deleteTask(String id) async {
    return await taskRemoteDataSource.deleteTask(id);
  }
}
