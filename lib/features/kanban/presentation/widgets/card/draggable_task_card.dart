import 'package:flutter/material.dart';
import 'package:task_manager_app/core/route/route.dart';
import 'package:task_manager_app/features/kanban/domain/entities/task.dart';
import 'package:task_manager_app/features/kanban/presentation/screens/tasks/view_task_screen.dart';
import 'package:task_manager_app/features/kanban/presentation/widgets/card/task_card_widget.dart';

///======================================================================================================
/// Widget for displaying a draggable task card.
///
/// This widget represents a task card that can be dragged horizontally. It contains a task and provides
/// navigation to view the task details when tapped. When dragged, it updates the horizontal scrolling
/// position of the parent scroll controller.
///
/// Parameters:
///   - `task`: The task to display on the card.
///   - `horizontalScrollController`: The horizontal scroll controller for handling dragging.
///======================================================================================================

class DraggableTaskCard extends StatefulWidget {
  Task task;
  ScrollController? horizontalScrollController;
  DraggableTaskCard({super.key, required this.task, required this.horizontalScrollController});

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
        onDragStarted: () {
          scrollingOffset = widget.horizontalScrollController!.offset;
        },
        onDragEnd: (details) {
          widget.horizontalScrollController!.jumpTo(
            scrollingOffset,
          );
        },
        onDragUpdate: (details) {
          // Handle horizontal scrolling
          if (widget.horizontalScrollController!.hasClients) {
            widget.horizontalScrollController!.jumpTo(
              widget.horizontalScrollController!.offset + details.delta.dx,
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
