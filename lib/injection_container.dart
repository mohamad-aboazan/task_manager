import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:task_manager_app/core/network/network_info.dart';
import 'package:task_manager_app/core/services/api_service.dart';
import 'package:task_manager_app/features/kanban/data/datasources/remote/column_remote_data_source.dart';
import 'package:task_manager_app/features/kanban/data/datasources/remote/project_remote_data_source.dart';
import 'package:task_manager_app/features/kanban/data/datasources/remote/task_remote_data_source.dart';
import 'package:task_manager_app/features/kanban/data/repositories_imp/column_repository_imp.dart';
import 'package:task_manager_app/features/kanban/data/repositories_imp/project_repository_imp.dart';
import 'package:task_manager_app/features/kanban/data/repositories_imp/task_repository_imp.dart';
import 'package:task_manager_app/features/kanban/domain/repository/column_repository.dart';
import 'package:task_manager_app/features/kanban/domain/repository/project_repository.dart';
import 'package:task_manager_app/features/kanban/domain/repository/task_repository.dart';
import 'package:task_manager_app/features/kanban/domain/usercase/column_usecases/create_column_usecase.dart';
import 'package:task_manager_app/features/kanban/domain/usercase/column_usecases/get_column_usecase.dart';
import 'package:task_manager_app/features/kanban/domain/usercase/project_usecases/create_project_usecase.dart';
import 'package:task_manager_app/features/kanban/domain/usercase/project_usecases/get_project_usecase.dart';
import 'package:task_manager_app/features/kanban/domain/usercase/project_usecases/get_projects_usecase.dart';
import 'package:task_manager_app/features/kanban/domain/usercase/task_usecases/create_task_usecase.dart';
import 'package:task_manager_app/features/kanban/domain/usercase/task_usecases/get_task_usecase.dart';
import 'package:task_manager_app/features/kanban/domain/usercase/task_usecases/get_tasks_usecase.dart';
import 'package:task_manager_app/features/kanban/domain/usercase/task_usecases/update_task_usecase.dart';
import 'package:task_manager_app/features/kanban/presentation/cubit/column_cubit/column_cubit.dart';
import 'package:task_manager_app/features/kanban/presentation/cubit/project_cubit/project_cubit.dart';
import 'package:task_manager_app/features/kanban/presentation/cubit/task_cubit/task_cubit.dart';
import 'package:task_manager_app/features/kanban/presentation/cubit/theme_cubit/theme_cubit.dart';
import 'package:task_manager_app/features/kanban/presentation/cubit/timer_cubit/timer_cubit.dart';

final sl = GetIt.instance;

Future<void> setup() async {
  //Bloc
  sl.registerFactory(() => ProjectBloc(createProjectUsecase: sl(), getProjectUsecase: sl(), getProjectsUsecase: sl()));
  sl.registerFactory(() => ColumnBloc(createColumnUsecase: sl(), getColumnsUsecase: sl(), getTasksUsecase: sl()));
  sl.registerFactory(() => TaskBloc(getTaskUsecase: sl(), getTasksUsecase: sl(), createTaskUsecase: sl(), updateTaskUsecase: sl()));
  sl.registerFactory(() => ThemeBloc());
  sl.registerFactory(() => TimerBloc());

  //Usecases
  sl.registerLazySingleton(() => GetProjectsUsecase(repository: sl())); // project
  sl.registerLazySingleton(() => GetProjectUsecase(repository: sl())); // project
  sl.registerLazySingleton(() => CreateProjectUsecase(repository: sl())); // project
  sl.registerLazySingleton(() => GetColumnsUsecase(repository: sl())); // Column
  sl.registerLazySingleton(() => CreateColumnUsecase(repository: sl())); // Column
  sl.registerLazySingleton(() => CreateTaskUsecase(repository: sl())); // Task
  sl.registerLazySingleton(() => UpdateTaskUsecase(repository: sl())); // Task
  sl.registerLazySingleton(() => GetTaskUsecase(repository: sl())); // Task
  sl.registerLazySingleton(() => GetTasksUsecase(repository: sl())); // Task

  // repository
  sl.registerLazySingleton<ProjectRepository>(() => ProjectRepositoryImpl(projectRemoteDataSource: sl(), networkInfo: sl()));
  sl.registerLazySingleton<ColumnRepository>(() => ColumnRepositoryImpl(columnRemoteDataSource: sl(), networkInfo: sl()));
  sl.registerLazySingleton<TaskRepository>(() => TaskRepositoryImpl(taskRemoteDataSource: sl(), networkInfo: sl()));

  // Datasources
  sl.registerLazySingleton<ProjectRemoteDataSource>(() => ProjectRemoteDataSourceImp(apiService: sl()));
  sl.registerLazySingleton<ColumnRemoteDataSource>(() => ColumnRemoteDataSourceImp(apiService: sl()));
  sl.registerLazySingleton<TaskRemoteDataSource>(() => TaskRemoteDataSourceImp(apiService: sl()));

  // Datasources

  sl.registerLazySingleton(() => ApiService(dio: sl()));

  // Core
  sl.registerLazySingleton<NetworkInfo>(() => NetworkInfoImpl(sl()));
  // External

  final sharedPreferences = await SharedPreferences.getInstance();
  sl.registerLazySingleton(() => sharedPreferences);
  sl.registerLazySingleton(() => Dio());
  sl.registerLazySingleton(() => Connectivity());
}
