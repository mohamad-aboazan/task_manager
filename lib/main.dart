import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:task_manager_app/app.dart';
import 'package:task_manager_app/features/kanban/presentation/cubit/column_cubit/column_cubit.dart';
import 'package:task_manager_app/features/kanban/presentation/cubit/comment_cubit/comment_cubit.dart';
import 'package:task_manager_app/features/kanban/presentation/cubit/notification_cubit/notification_cubit.dart';
import 'package:task_manager_app/features/kanban/presentation/cubit/project_cubit/project_cubit.dart';
import 'package:task_manager_app/features/kanban/presentation/cubit/task_cubit/task_cubit.dart';
import 'package:task_manager_app/features/kanban/presentation/cubit/theme_cubit/theme_cubit.dart';
import 'package:task_manager_app/features/kanban/presentation/cubit/timer_cubit/timer_cubit.dart';
import 'injection_container.dart' as di;

Future<void> main() async {
  WidgetsBinding widgetsBinding = WidgetsFlutterBinding.ensureInitialized();
  await Hive.initFlutter();
  FlutterNativeSplash.preserve(widgetsBinding: widgetsBinding);
  await di.setup();
  runApp(
    MultiBlocProvider(
      providers: [
        BlocProvider(create: (_) => di.sl<ProjectBloc>()),
        BlocProvider(create: (_) => di.sl<ColumnBloc>()),
        BlocProvider(create: (_) => di.sl<TaskBloc>()),
        BlocProvider(create: (_) => di.sl<CommentBloc>()),
        BlocProvider(create: (_) => di.sl<TimerBloc>()),
        BlocProvider(create: (_) => di.sl<NotificationBloc>()),
        BlocProvider(create: (_) => di.sl<ThemeBloc>()),
      ],
      child: const MyApp(),
    ),
  );
}
