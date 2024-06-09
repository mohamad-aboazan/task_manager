import 'package:flutter/material.dart';
import 'package:task_manager_app/core/route/route.dart';
import 'package:task_manager_app/features/kanban/domain/entities/task.dart';
import 'package:task_manager_app/features/kanban/presentation/screens/tasks/view_task_screen.dart';
import 'package:task_manager_app/features/kanban/presentation/widgets/card/task_card_widget.dart';

class DraggableTaskCard extends StatefulWidget {
  Task task;
  ScrollController? scrollController;
  DraggableTaskCard({super.key, required this.task, required this.scrollController});

  @override
  State<DraggableTaskCard> createState() => _DraggableTaskCardState();
}

class _DraggableTaskCardState extends State<DraggableTaskCard> {
  double scrollingOffset = 0;
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => AppRoutes.push(context, ViewTaskScreen(task: widget.task)),
      child: Draggable<Task>(
        data: widget.task,
        affinity: Axis.horizontal,
        hitTestBehavior: HitTestBehavior.opaque,
        childWhenDragging: Opacity(
          opacity: 0.3,
          child: TaskCard(task: widget.task),
        ),
        onDragCompleted: () {},
        onDragStarted: () {
          scrollingOffset = widget.scrollController!.offset;
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
          child: TaskCard(task: widget.task),
        ),
        child: TaskCard(task: widget.task),
      ),
    );
  }
}
