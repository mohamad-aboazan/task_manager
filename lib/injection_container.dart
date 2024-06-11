import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:task_manager_app/core/network/network_info.dart';
import 'package:task_manager_app/core/services/api_service.dart';
import 'package:task_manager_app/core/services/local_notification_service.dart';
import 'package:task_manager_app/features/kanban/data/datasources/local/task_local_data_source.dart';
import 'package:task_manager_app/features/kanban/data/datasources/local/task_log_local_data_source.dart';
import 'package:task_manager_app/features/kanban/data/datasources/remote/column_remote_data_source.dart';
import 'package:task_manager_app/features/kanban/data/datasources/remote/comment_remote_data_sourc.dart';
import 'package:task_manager_app/features/kanban/data/datasources/remote/project_remote_data_source.dart';
import 'package:task_manager_app/features/kanban/data/datasources/remote/task_remote_data_source.dart';
import 'package:task_manager_app/features/kanban/data/repositories_imp/column_repository_imp.dart';
import 'package:task_manager_app/features/kanban/data/repositories_imp/comment_repository_imp.dart';
import 'package:task_manager_app/features/kanban/data/repositories_imp/project_repository_imp.dart';
import 'package:task_manager_app/features/kanban/data/repositories_imp/task_log_repository_imp.dart';
import 'package:task_manager_app/features/kanban/data/repositories_imp/task_repository_imp.dart';
import 'package:task_manager_app/features/kanban/domain/repository/column_repository.dart';
import 'package:task_manager_app/features/kanban/domain/repository/comment_repository.dart';
import 'package:task_manager_app/features/kanban/domain/repository/project_repository.dart';
import 'package:task_manager_app/features/kanban/domain/repository/task_log_repository.dart';
import 'package:task_manager_app/features/kanban/domain/repository/task_repository.dart';
import 'package:task_manager_app/features/kanban/domain/usercase/column_usecases/create_column_usecase.dart';
import 'package:task_manager_app/features/kanban/domain/usercase/column_usecases/get_column_usecase.dart';
import 'package:task_manager_app/features/kanban/domain/usercase/comment_usecases/create_comment_usecase.dart';
import 'package:task_manager_app/features/kanban/domain/usercase/comment_usecases/delete_comment_usecase.dart';
import 'package:task_manager_app/features/kanban/domain/usercase/comment_usecases/get_comments_usecase.dart';
import 'package:task_manager_app/features/kanban/domain/usercase/comment_usecases/update_comment_usecase.dart';
import 'package:task_manager_app/features/kanban/domain/usercase/project_usecases/create_project_usecase.dart';
import 'package:task_manager_app/features/kanban/domain/usercase/project_usecases/get_project_usecase.dart';
import 'package:task_manager_app/features/kanban/domain/usercase/project_usecases/get_projects_usecase.dart';
import 'package:task_manager_app/features/kanban/domain/usercase/task_log_usecase/get_task_logs_uescas.dart';
import 'package:task_manager_app/features/kanban/domain/usercase/task_log_usecase/new_task_log_uescase.dart';
import 'package:task_manager_app/features/kanban/domain/usercase/task_usecases/create_task_usecase.dart';
import 'package:task_manager_app/features/kanban/domain/usercase/task_usecases/get_task_usecase.dart';
import 'package:task_manager_app/features/kanban/domain/usercase/task_usecases/get_tasks_usecase.dart';
import 'package:task_manager_app/features/kanban/domain/usercase/task_usecases/delete_task_usecase.dart';
import 'package:task_manager_app/features/kanban/domain/usercase/task_usecases/update_task_usecase.dart';
import 'package:task_manager_app/features/kanban/presentation/cubit/column_cubit/column_cubit.dart';
import 'package:task_manager_app/features/kanban/presentation/cubit/comment_cubit/comment_cubit.dart';
import 'package:task_manager_app/features/kanban/presentation/cubit/notification_cubit/notification_cubit.dart';
import 'package:task_manager_app/features/kanban/presentation/cubit/project_cubit/project_cubit.dart';
import 'package:task_manager_app/features/kanban/presentation/cubit/task_cubit/task_cubit.dart';
import 'package:task_manager_app/features/kanban/presentation/cubit/settings_cubit/settings_cubit.dart';
import 'package:task_manager_app/features/kanban/presentation/cubit/timer_cubit/timer_cubit.dart';

final sl = GetIt.instance;

/// =================================================================================================
/// The `setup` function initializes the dependency injection container using GetIt.
/// It registers all the necessary dependencies including Blocs, UseCases, Repositories,
/// DataSources, Services, and External libraries required for the application.
///
/// This function should be called once at the start of the application to set up
/// all the dependencies.
/// =================================================================================================

Future<void> setup() async {
  //Bloc
  sl.registerFactory(() => ProjectBloc(
        createProjectUsecase: sl(),
        getProjectUsecase: sl(),
        getProjectsUsecase: sl(),
      ));
  sl.registerFactory(() => ColumnBloc(sl(), sl()));
  sl.registerFactory(() => TaskBloc(sl(), sl(), sl(), sl(), sl(), sl(), sl()));
  sl.registerFactory(() => CommentBloc(sl(), sl(), sl(), sl()));
  sl.registerFactory(() => NotificationBloc(sl()));
  sl.registerFactory(() => SettingsBloc(sl()));
  sl.registerFactory(() => TimerBloc());

  //Usecases
  sl.registerLazySingleton(() => GetProjectsUsecase(repository: sl())); // project
  sl.registerLazySingleton(() => GetProjectUsecase(repository: sl())); // project
  sl.registerLazySingleton(() => CreateProjectUsecase(repository: sl())); // project
  sl.registerLazySingleton(() => GetColumnsUsecase(repository: sl())); // Column
  sl.registerLazySingleton(() => CreateColumnUsecase(repository: sl())); // Column
  sl.registerLazySingleton(() => CreateTaskUsecase(repository: sl())); // Task
  sl.registerLazySingleton(() => UpdateTaskUsecase(repository: sl())); // Task
  sl.registerLazySingleton(() => DeleteTaskUsecase(repository: sl())); // Task
  sl.registerLazySingleton(() => GetTaskUsecase(repository: sl())); // Task
  sl.registerLazySingleton(() => GetTasksUsecase(repository: sl())); // Task
  sl.registerLazySingleton(() => GetCommentsUsecase(repository: sl())); // Comment
  sl.registerLazySingleton(() => CreateCommentUsecase(repository: sl())); // Comment
  sl.registerLazySingleton(() => UpdateCommentUsecase(repository: sl())); // Comment
  sl.registerLazySingleton(() => DeleteCommentUsecase(repository: sl())); // Comment
  sl.registerLazySingleton(() => NewTaskLogUsecase(repository: sl())); // Task Log
  sl.registerLazySingleton(() => GetTasksLogsUescas(repository: sl())); // Task Log

  // repository
  sl.registerLazySingleton<ProjectRepository>(() => ProjectRepositoryImpl(projectRemoteDataSource: sl(), networkInfo: sl()));
  sl.registerLazySingleton<ColumnRepository>(() => ColumnRepositoryImpl(columnRemoteDataSource: sl(), networkInfo: sl()));
  sl.registerLazySingleton<TaskRepository>(() => TaskRepositoryImpl(taskRemoteDataSource: sl(), taskLocalDataSource: sl(), networkInfo: sl()));
  sl.registerLazySingleton<CommentRepository>(() => CommentRepositoryImpl(commentRemoteDataSource: sl(), networkInfo: sl()));
  sl.registerLazySingleton<TaskLogRepository>(() => TaskLogRepositoryImp(taskLogLocalDataSource: sl()));

  // remote Datasources
  sl.registerLazySingleton<ProjectRemoteDataSource>(() => ProjectRemoteDataSourceImp(apiService: sl()));
  sl.registerLazySingleton<ColumnRemoteDataSource>(() => ColumnRemoteDataSourceImp(apiService: sl()));
  sl.registerLazySingleton<TaskRemoteDataSource>(() => TaskRemoteDataSourceImp(apiService: sl()));
  sl.registerLazySingleton<CommentRemoteDataSource>(() => CommentRemoteDataSourceImp(apiService: sl()));

  // local Datasources
  sl.registerLazySingleton<TaskLocalDataSource>(() => TaskLocalDataSourceImp());
  sl.registerLazySingleton<TaskLogLocalDataSource>(() => TaskLogLocalDataSourceImp());

  // Services
  sl.registerLazySingleton(() => ApiService(dio: sl()));
  sl.registerLazySingleton(() => LocalNotificationService());

  // Core
  sl.registerLazySingleton<NetworkInfo>(() => NetworkInfoImpl(sl()));
  // External

  final sharedPreferences = await SharedPreferences.getInstance();
  sl.registerLazySingleton(() => sharedPreferences);
  sl.registerLazySingleton(() => Dio());
  sl.registerLazySingleton(() => Connectivity());
}
