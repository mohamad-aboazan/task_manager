import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:task_manager_app/core/entities/base_state.dart';
import 'package:task_manager_app/core/route/route.dart';
import 'package:task_manager_app/core/sharedwidgets/app_snackbar.dart';
import 'package:task_manager_app/core/sharedwidgets/date_time_picker.dart';
import 'package:task_manager_app/core/utils/date_converter.dart';
import 'package:task_manager_app/core/utils/log_content.dart';
import 'package:task_manager_app/core/utils/validation.dart';
import 'package:task_manager_app/features/kanban/data/dto/create_comment_dto.dart';
import 'package:task_manager_app/features/kanban/data/dto/update_task_dto.dart';
import 'package:task_manager_app/features/kanban/domain/entities/column.dart';
import 'package:task_manager_app/features/kanban/domain/entities/task.dart' as t;
import 'package:task_manager_app/features/kanban/presentation/cubit/column_cubit/column_cubit.dart';
import 'package:task_manager_app/features/kanban/presentation/cubit/comment_cubit/comment_cubit.dart';
import 'package:task_manager_app/features/kanban/presentation/cubit/notification_cubit/notification_cubit.dart';
import 'package:task_manager_app/features/kanban/presentation/cubit/task_cubit/task_cubit.dart';
import 'package:task_manager_app/features/kanban/presentation/widgets/comment_widget.dart';
import 'package:task_manager_app/features/kanban/presentation/widgets/reminder_switch_widget.dart';
import 'package:task_manager_app/features/kanban/presentation/widgets/task_popup_menu_widget.dart';
import 'package:task_manager_app/features/kanban/presentation/widgets/timer_widget.dart';
import 'package:task_manager_app/features/kanban/presentation/widgets/priority_dropdown_widget.dart';

class ViewTaskScreen extends StatefulWidget {
  final t.Task task;
  List<ColumnEntity>? colunmEntities;
  ViewTaskScreen({super.key, required this.task, this.colunmEntities});

  @override
  State<ViewTaskScreen> createState() => _ViewTaskScreenState();
}

class _ViewTaskScreenState extends State<ViewTaskScreen> {
  final _formKey = GlobalKey<FormState>();
  late TextEditingController contentController;
  late TextEditingController descriptionController;
  late TextEditingController dateTimeController;
  TextEditingController durationController = TextEditingController();
  TextEditingController unitController = TextEditingController();
  late TextEditingController progressController;
  late TextEditingController priorityController;
  late TextEditingController commentController;
  late bool reminder = false;
  late bool showDoneComment = false;
  late List<String>? taskHistories = [];
  @override
  void initState() {
    super.initState();
    contentController = TextEditingController(text: widget.task.content);
    descriptionController = TextEditingController(text: widget.task.description);
    dateTimeController = TextEditingController(text: DateConverter.formatHumanReadableDateTime(DateTime.parse(widget.task.due?.datetime ?? '')));
    progressController = TextEditingController(text: widget.task.labels?.first);
    priorityController = TextEditingController(text: widget.task.priority.toString());
    durationController = TextEditingController(text: widget.task.duration?.amount.toString());
    unitController = TextEditingController(text: widget.task.duration?.unit.toString());
    commentController = TextEditingController();
    context.read<NotificationBloc>().getNotificationById(id: widget.task.getShortId());
    taskHistories = context.read<TaskBloc>().getTaskHistories(widget.task.id!);
    context.read<CommentBloc>().getComments(widget.task.id!);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('View Task'),
        actions: [
          TaskPopupMenuButton(task: widget.task),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              Expanded(
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      //========================== Timer Widget ============================
                      TimerWidget(id: widget.task.id ?? ''),
                      const SizedBox(height: 40),
                      //============================ Content input ============================
                      TextFormField(
                        controller: contentController,
                        validator: (value) => Validation.isEmptyValidation(value),
                        decoration: const InputDecoration(labelText: 'Content'),
                      ),
                      const SizedBox(height: 20),
                      //============================ Description input ============================
                      TextFormField(
                        controller: descriptionController,
                        maxLines: 100,
                        minLines: 1,
                        validator: (value) => Validation.isEmptyValidation(value),
                        decoration: const InputDecoration(labelText: 'Description'),
                      ),
                      const SizedBox(height: 20),
                      //============================ Start date and time input ============================
                      TextFormField(
                        controller: dateTimeController,
                        readOnly: true,
                        onTap: () async {
                          dateTimeController.text = await AppDateTimePicker.show(context);
                        },
                        validator: (value) => Validation.isEmptyValidation(value),
                        decoration: const InputDecoration(
                          labelText: 'Start date and time',
                          suffixIcon: Icon(Icons.date_range_rounded),
                        ),
                      ),
                      const SizedBox(height: 20),
                      //========================== Duration input ============================

                      TextFormField(
                        controller: durationController,
                        validator: (value) => Validation.isEmptyValidation(value),
                        keyboardType: TextInputType.number,
                        inputFormatters: <TextInputFormatter>[FilteringTextInputFormatter.digitsOnly],
                        decoration: const InputDecoration(labelText: 'Duration', suffixIcon: Icon(Icons.timer)),
                      ),
                      const SizedBox(height: 20),
                      //========================== Unit input ============================

                      DropdownMenu(
                          expandedInsets: EdgeInsets.zero,
                          controller: unitController,
                          label: const Text("Unit"),
                          dropdownMenuEntries: ["minute", "day"]
                              .map(
                                (e) => DropdownMenuEntry(value: e, label: e),
                              )
                              .toList()),
                      const SizedBox(height: 20),
                      //========================== Progress input ============================
                      DropdownMenu(
                          expandedInsets: EdgeInsets.zero,
                          controller: progressController,
                          label: const Text("Task Progress"),
                          dropdownMenuEntries: context
                              .read<ColumnBloc>()
                              .colunmEntities
                              .map(
                                (e) => DropdownMenuEntry(value: e.name, label: e.name.toString()),
                              )
                              .toList()),
                      const SizedBox(height: 20),
                      //========================== priority input ============================
                      PriorityDropdownWidget(priorityController: priorityController),
                      const SizedBox(height: 20),
                      //========================== Reminder input ============================
                      ReminderSwitchwidget(onChanged: (value) => reminder = value),
                      const SizedBox(height: 20),
                      //========================== Comments input ============================
                      SizedBox(
                        width: MediaQuery.of(context).size.width,
                        child: Row(
                          children: [
                            const CircleAvatar(radius: 20),
                            const SizedBox(width: 20),
                            Expanded(
                              child: StatefulBuilder(builder: (context, commentSetstate) {
                                return TextFormField(
                                  controller: commentController,
                                  maxLines: 100,
                                  minLines: 1,
                                  onChanged: (value) {
                                    if (value.length == 1) {
                                      print("1");
                                      commentSetstate(() {
                                        showDoneComment = true;
                                      });
                                    } else if (value.isEmpty) {
                                      commentSetstate(() {
                                        showDoneComment = false;
                                      });
                                      print("0");
                                    }
                                  },
                                  decoration: InputDecoration(
                                    labelText: 'write a comment...',
                                    suffixIcon: showDoneComment
                                        ? IconButton(
                                            icon: const Icon(Icons.done),
                                            onPressed: () {
                                              context.read<CommentBloc>().createComment(CreateCommentDto(taskId: widget.task.id, content: commentController.text));
                                              commentController.clear();
                                            },
                                          )
                                        : null,
                                  ),
                                );
                              }),
                            ),
                          ],
                        ),
                      ),

                      //========================== Comments ============================
                      BlocBuilder<CommentBloc, CommentState>(
                        buildWhen: (previous, current) {
                          print(current);
                          if (current is CreateCommentState && current.baseResponse.status == Status.success) {
                            widget.task.comments?.add(current.baseResponse.data!);
                            context.read<TaskBloc>().newLog(taskId: widget.task.id!, taskLogType: TaskLogTypes.commentAdded, variables: {});
                          } else if (current is UpdateCommentState && current.baseResponse.status == Status.success) {
                            widget.task.comments?.removeWhere((comment) => comment.id == current.baseResponse.data.id);
                            widget.task.comments?.add(current.baseResponse.data!);
                            context.read<TaskBloc>().newLog(taskId: widget.task.id!, taskLogType: TaskLogTypes.commentUpdated, variables: {});
                          } else if (current is DeleteCommentState && current.baseResponse.status == Status.success) {
                            widget.task.comments?.removeWhere((comment) => comment.id == current.baseResponse.data);
                            context.read<TaskBloc>().newLog(taskId: widget.task.id!, taskLogType: TaskLogTypes.commentDeleted, variables: {});
                          } else if (current is GetCommentsState && current.baseResponse.status == Status.success) {
                            widget.task.comments?.addAll(current.baseResponse.data!);
                          } else if (current is CreateCommentState && current.baseResponse.status == Status.error) {
                            print(current.baseResponse.error.toString());
                          } else if (current is UpdateCommentState && current.baseResponse.status == Status.error) {
                            print(current.baseResponse.error.toString());
                          } else if (current is DeleteCommentState && current.baseResponse.status == Status.error) {
                            print(current.baseResponse.error.toString());
                          }
                          return true;
                        },
                        builder: (context, state) {
                          return Column(
                            children: [
                              for (int i = widget.task.comments!.length - 1; i >= 0; i--) ...[
                                CommentWidget(
                                  comment: widget.task.comments![i],
                                )
                              ]
                            ],
                          );
                        },
                      ),
                    ],
                  ),
                ),
              ),
              //========================== Save Changes button =======================
              Container(
                width: MediaQuery.of(context).size.width,
                height: 50,
                margin: const EdgeInsets.symmetric(vertical: 30),
                child: BlocBuilder<TaskBloc, TaskState>(
                  buildWhen: (previous, current) {
                    if (current is UpdateTaskState) {
                      switch (current.baseResponse.status) {
                        case Status.error:
                          AppSnackBar.show(context: context, message: current.baseResponse.error.toString(), status: SnackBarStatus.error);
                        default:
                      }
                      return true;
                    }
                    return false;
                  },
                  builder: (context, state) {
                    return ElevatedButton(
                      onPressed: () {
                        if (_formKey.currentState!.validate()) {
                          context.read<TaskBloc>().updateTask(
                                id: widget.task.id ?? '',
                                updateTaskDto: UpdateTaskDto(
                                  content: contentController.text,
                                  description: descriptionController.text,
                                  dueDatetime: DateConverter.formatDateTime(
                                    DateConverter.parseDateTime(dateTimeController.text),
                                  ),
                                  labels: [progressController.text],
                                  priority: int.parse(priorityController.text),
                                  duration: int.parse(durationController.text),
                                  durationUnit: unitController.text,
                                  reminder: reminder,
                                ),
                              );
                        }
                        AppRoutes.pop(context);
                      },
                      child: state is UpdateTaskState && state.baseResponse.status == Status.loading ? const CircularProgressIndicator() : const Text('Save Changes'),
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
