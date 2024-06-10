import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:task_manager_app/core/entities/base_state.dart';
import 'package:task_manager_app/core/route/route.dart';
import 'package:task_manager_app/core/services/local_notification_service.dart';
import 'package:task_manager_app/core/sharedwidgets/app_snackbar.dart';
import 'package:task_manager_app/core/sharedwidgets/date_time_picker.dart';
import 'package:task_manager_app/core/utils/date_converter.dart';
import 'package:task_manager_app/core/utils/validation.dart';
import 'package:task_manager_app/features/kanban/data/dto/update_task_dto.dart';
import 'package:task_manager_app/features/kanban/domain/entities/column.dart';
import 'package:task_manager_app/features/kanban/domain/entities/task.dart' as t;
import 'package:task_manager_app/features/kanban/presentation/cubit/column_cubit/column_cubit.dart';
import 'package:task_manager_app/features/kanban/presentation/cubit/notification_cubit/notification_cubit.dart';
import 'package:task_manager_app/features/kanban/presentation/cubit/task_cubit/task_cubit.dart';
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
  late bool reminder = false;
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
    context.read<NotificationBloc>().getNotificationById(id: widget.task.getShortId());
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
                //========================== Save Changes button ==========================
                SizedBox(
                  width: MediaQuery.of(context).size.width,
                  height: 50,
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
      ),
    );
  }
}
