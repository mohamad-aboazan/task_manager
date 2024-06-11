import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:task_manager_app/core/entities/base_state.dart';
import 'package:task_manager_app/core/route/route.dart';
import 'package:task_manager_app/core/services/local_notification_service.dart';
import 'package:task_manager_app/core/sharedwidgets/app_drawer.dart';
import 'package:task_manager_app/core/sharedwidgets/app_snackbar.dart';
import 'package:task_manager_app/features/kanban/data/dto/update_task_dto.dart';
import 'package:task_manager_app/features/kanban/domain/entities/task.dart' as t;
import 'package:task_manager_app/features/kanban/presentation/cubit/column_cubit/column_cubit.dart';
import 'package:task_manager_app/features/kanban/presentation/cubit/project_cubit/project_cubit.dart';
import 'package:task_manager_app/features/kanban/presentation/cubit/task_cubit/task_cubit.dart';
import 'package:task_manager_app/features/kanban/presentation/screens/colunms/create_column_screen.dart';
import 'package:task_manager_app/features/kanban/presentation/screens/notifications/notification_screen.dart';
import 'package:task_manager_app/features/kanban/presentation/widgets/column_widget.dart';

///======================================================================================================
/// Home Screen for the Kanban feature of the application.
///
/// This screen displays the current project's name as the app bar title and a list of columns
/// representing different stages of tasks in the Kanban board. It allows users to drag and drop
/// tasks between columns. Users can also navigate to the notifications screen using the
/// notifications icon in the app bar and create new columns by tapping the "Create New Column"
/// button.
///
/// Features:
///   - Displays the current project's name in the app bar.
///   - Shows a list of columns representing different stages of tasks.
///   - Allows users to drag and drop tasks between columns.
///   - Provides a button to create new columns.
///   - Allows users to navigate to the notifications screen.
///
/// Dependencies:
///   - `ColumnBloc`: Used to fetch columns data.
///   - `TaskBloc`: Used to fetch tasks data and update task information.
///   - `ProjectBloc`: Used to access the current project's information.
///   - `AppDrawer`: Custom widget for the app drawer.
///   - `NotificationsScreeon`: Screen for displaying notifications.
///
/// Routes:
///   - Notifications Screen: Navigates to the notifications screen.
///======================================================================================================

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  ScrollController horizontalScrollController = ScrollController();
  LocalNotificationService notificationService = LocalNotificationService();

  @override
  void initState() {
    context.read<ColumnBloc>().getColumns();
    context.read<TaskBloc>().getTasks(context.read<ProjectBloc>().currentProject?.id ?? '');
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        actions: [
          InkWell(
            onTap: () {
              AppRoutes.push(context, const NotificationsScreeon());
            },
            child: const Padding(
              padding: EdgeInsets.all(15),
              child: Icon(Icons.notifications),
            ),
          ),
        ],
        title: Text(
          context.read<ProjectBloc>().currentProject?.name ?? '',
          style: Theme.of(context).textTheme.titleLarge?.copyWith(fontWeight: FontWeight.bold),
        ),
      ),
      drawer: const AppDrawer(),
      body: Column(
        children: [
          Expanded(
              child: SingleChildScrollView(
            controller: horizontalScrollController,
            physics: const BouncingScrollPhysics(),
            scrollDirection: Axis.horizontal,
            child: BlocBuilder<ColumnBloc, ColumnState>(
              buildWhen: (previous, current) {
                if (current is GetColumnsState) {
                  if (current.baseResponse.status == Status.error) {
                    AppSnackBar.show(context: context, message: current.baseResponse.error.toString(), status: SnackBarStatus.error);
                  }

                  return true;
                }
                return false;
              },
              builder: (context, state) {
                if (state is GetColumnsState) {
                  if (state.baseResponse.status == Status.loading) {
                    return SizedBox(
                      width: MediaQuery.of(context).size.width,
                      child: const Center(
                        child: CircularProgressIndicator(),
                      ),
                    );
                  }
                  return Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      if (state.baseResponse.status == Status.success) ...[
                        for (int i = 0; i < state.baseResponse.data!.length; i++) ...[
                          DragTarget<t.Task>(onAcceptWithDetails: (details) {
                            TaskBloc taskBloc = context.read<TaskBloc>();
                            taskBloc.updateTask(id: details.data.id ?? '', updateTaskDto: UpdateTaskDto(labels: [state.baseResponse.data![i].name ?? '']));
                          }, builder: (BuildContext context, List<dynamic> accepted, List<dynamic> rejected) {
                            return ColumnWidget(
                              columnEntity: state.baseResponse.data![i],
                              horizontalScrollController: horizontalScrollController,
                            );
                          }),
                        ]
                      ],
                      Center(
                        child: SizedBox(
                          width: MediaQuery.of(context).size.width,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              InkWell(
                                onTap: () {
                                  AppRoutes.push(context, const CreateColumnScreen());
                                },
                                child: const Icon(Icons.add_box_rounded, size: 100),
                              ),
                              const SizedBox(height: 20),
                              Text(
                                "Create New Column".tr(),
                                style: Theme.of(context).textTheme.titleLarge?.copyWith(fontSize: 30, fontWeight: FontWeight.bold),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  );
                }
                return const SizedBox();
              },
            ),
          ))
        ],
      ),
    );
  }
}
