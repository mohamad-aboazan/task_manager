import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:task_manager_app/core/route/route.dart';
import 'package:task_manager_app/features/kanban/domain/entities/column.dart';
import 'package:task_manager_app/features/kanban/domain/entities/task.dart';
import 'package:task_manager_app/features/kanban/presentation/cubit/task_cubit/task_cubit.dart';
import 'package:task_manager_app/features/kanban/presentation/screens/tasks/create_task_screen.dart';
import 'package:task_manager_app/features/kanban/presentation/widgets/task_card_widget.dart';

class ColumnWidget extends StatefulWidget {
  final ColumnEntity columnEntity;
  ScrollController? scrollController;
  int id;

  ColumnWidget({super.key, required this.columnEntity, required this.scrollController, required this.id});

  @override
  State<ColumnWidget> createState() => _ColumnWidgetState();
}

class _ColumnWidgetState extends State<ColumnWidget> {
  late ScrollController _scrollController;
  late ScrollController _horizontalScrollController;
  double scrollingOffset = 0;
  @override
  void initState() {
    super.initState();

    _scrollController = ScrollController();
    _horizontalScrollController = ScrollController();
  }

  @override
  void dispose() {
    _scrollController.dispose();
    _horizontalScrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(30),
      decoration: BoxDecoration(
          color: Colors.grey.shade200,
          boxShadow: [
            BoxShadow(
              blurRadius: 10,
              spreadRadius: 1,
              color: Theme.of(context).colorScheme.onSurface.withOpacity(0.5),
            )
          ],
          borderRadius: BorderRadius.circular(20)),
      width: 310,
      child: BlocBuilder<TaskBloc, TaskState>(
        builder: (context, state) {
          List<Task> tasks = context
              .read<TaskBloc>()
              .tasks
              .where(
                (task) => task.labels!.contains(widget.columnEntity.name),
              )
              .toList();
          return Column(
            children: [
              Container(
                width: MediaQuery.of(context).size.width,
                padding: const EdgeInsets.symmetric(horizontal: 15),
                height: 50,
                decoration: BoxDecoration(
                  color: Color(widget.columnEntity.color ?? 0),
                  borderRadius: const BorderRadius.only(topLeft: Radius.circular(20), topRight: Radius.circular(20)),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(widget.columnEntity.name.toString(), style: Theme.of(context).textTheme.titleMedium),
                    Text("${tasks.length}/${context.read<TaskBloc>().tasks.length}", style: Theme.of(context).textTheme.titleMedium),
                  ],
                ),
              ),
              Expanded(
                child: SingleChildScrollView(
                  controller: _scrollController,
                  child: SingleChildScrollView(
                    controller: _horizontalScrollController,
                    scrollDirection: Axis.horizontal,
                    child: Column(
                      children: [
                        for (int i = 0; i < tasks.length; i++)
                          Draggable<Task>(
                            data: tasks[i],
                            affinity: Axis.horizontal,
                            hitTestBehavior: HitTestBehavior.opaque,
                            childWhenDragging: Opacity(
                              opacity: 0.3,
                              child: TaskCard(task: tasks[i]),
                            ),
                            onDragCompleted: () {},
                            onDragStarted: () {
                              setState(() {
                                scrollingOffset = widget.scrollController!.offset;
                              });
                            },
                            onDragEnd: (details) {
                              widget.scrollController!.jumpTo(
                                scrollingOffset,
                              );
                            },
                            onDragUpdate: (details) {
                              // // Handle horizontal scrolling
                              if (widget.scrollController!.hasClients) {
                                widget.scrollController!.jumpTo(
                                  widget.scrollController!.offset + details.delta.dx,
                                );
                              }
                            },
                            feedback: Opacity(
                              opacity: 0.8,
                              child: TaskCard(task: tasks[i]),
                            ),
                            child: TaskCard(task: tasks[i]),
                          ),
                      ],
                    ),
                  ),
                ),
              ),
              SizedBox(
                width: MediaQuery.of(context).size.width,
                child: TextButton.icon(
                  onPressed: () {
                    AppRoutes.push(
                        context,
                        CreateTaskScreen(
                          columnEntity: widget.columnEntity,
                        ));
                  },
                  label: Text(
                    "Add New Task",
                    style: Theme.of(context).textTheme.titleMedium?.copyWith(
                          color: Color(widget.columnEntity.color ?? 0),
                        ),
                  ),
                  icon: Icon(Icons.add, color: Color(widget.columnEntity.color ?? 0)),
                ),
              )
            ],
          );
        },
      ),
    );
  }
}
