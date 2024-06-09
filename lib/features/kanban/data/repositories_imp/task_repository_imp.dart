import 'package:task_manager_app/core/network/network_info.dart';
import 'package:task_manager_app/features/kanban/data/datasources/task_remote_data_source.dart';
import 'package:task_manager_app/features/kanban/data/dto/update_task_dto.dart';
import 'package:task_manager_app/features/kanban/domain/entities/task.dart';
import 'package:task_manager_app/features/kanban/domain/repository/task_repository.dart';

class TaskRepositoryImpl implements TaskRepository {
  final NetworkInfo networkInfo;
  final TaskRemoteDataSource taskRemoteDataSource;

  TaskRepositoryImpl({required this.taskRemoteDataSource, required this.networkInfo});

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
}
