import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:task_manager_app/app.dart';
import 'package:task_manager_app/core/utils/assets.dart';
import 'package:task_manager_app/core/utils/constant.dart';
import 'package:task_manager_app/features/kanban/presentation/cubit/column_cubit/column_cubit.dart';
import 'package:task_manager_app/features/kanban/presentation/cubit/comment_cubit/comment_cubit.dart';
import 'package:task_manager_app/features/kanban/presentation/cubit/notification_cubit/notification_cubit.dart';
import 'package:task_manager_app/features/kanban/presentation/cubit/project_cubit/project_cubit.dart';
import 'package:task_manager_app/features/kanban/presentation/cubit/task_cubit/task_cubit.dart';
import 'package:task_manager_app/features/kanban/presentation/cubit/settings_cubit/settings_cubit.dart';
import 'package:task_manager_app/features/kanban/presentation/cubit/timer_cubit/timer_cubit.dart';
import 'injection_container.dart' as di;

/// The main entry point of the application.
///
/// This function initializes various components of the application such as Hive,
/// Flutter Native Splash, and dependency injection container using GetIt.
///
/// It then configures and runs the application by wrapping the `MyApp` widget
/// with `MultiBlocProvider` to provide all the necessary BLoCs to the widget tree.
///
/// Note: In large projects, BLoCs are not injected at the root of the widget tree,
/// but rather injected where they are needed, for better organization and management.

Future<void> main() async {
  WidgetsBinding widgetsBinding = WidgetsFlutterBinding.ensureInitialized();
  await Hive.initFlutter();
  await EasyLocalization.ensureInitialized();
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
        BlocProvider(create: (_) => di.sl<SettingsBloc>()),
      ],
      child: EasyLocalization(
        supportedLocales: const [Locale(Constant.en), Locale(Constant.de)],
        path: AppAssets.TRANSLATION_FOLDER,
        fallbackLocale: const Locale(Constant.en),
        saveLocale: true,
        child: const MyApp(),
      ),
    ),
  );
}
