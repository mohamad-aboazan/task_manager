import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:task_manager_app/core/entities/base_state.dart';
import 'package:task_manager_app/core/route/route.dart';
import 'package:task_manager_app/core/sharedwdigets/app_drawer.dart';
import 'package:task_manager_app/core/sharedwdigets/app_snackbar.dart';
import 'package:task_manager_app/features/kanban/data/dto/update_task_dto.dart';
import 'package:task_manager_app/features/kanban/domain/entities/column.dart';
import 'package:task_manager_app/features/kanban/domain/entities/task.dart';
import 'package:task_manager_app/features/kanban/presentation/cubit/column_cubit/column_cubit.dart';
import 'package:task_manager_app/features/kanban/presentation/cubit/project_cubit/project_cubit.dart';
import 'package:task_manager_app/features/kanban/presentation/cubit/task_cubit/task_cubit.dart';
import 'package:task_manager_app/features/kanban/presentation/screens/colunms/create_column_screen.dart';
import 'package:task_manager_app/features/kanban/presentation/widgets/column_widget.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key, required this.title});

  final String title;

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  ScrollController scrollController = ScrollController();
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
            controller: scrollController,
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
                          DragTarget<Task>(onAcceptWithDetails: (details) {
                            context.read<TaskBloc>().tasks.remove(details.data);
                            details.data.labels?.clear();
                            details.data.labels?.add(state.baseResponse.data![i].name ?? '');
                            context.read<TaskBloc>().tasks.add(details.data);
                            context.read<TaskBloc>().updateTask(details.data.id ?? '', UpdateTaskDto(labels: details.data.labels ?? []));
                          }, builder: (
                            BuildContext context,
                            List<dynamic> accepted,
                            List<dynamic> rejected,
                          ) {
                            return ColumnWidget(
                              columnEntity: state.baseResponse.data![i],
                              columnEntities: state.baseResponse.data,
                              scrollController: scrollController,
                              id: i,
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
                                "Create New Column",
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
