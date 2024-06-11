import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:task_manager_app/core/entities/base_state.dart';
import 'package:task_manager_app/core/route/route.dart';
import 'package:task_manager_app/core/sharedwidgets/app_snackbar.dart';
import 'package:task_manager_app/core/sharedwidgets/date_time_picker.dart';
import 'package:task_manager_app/core/utils/date_converter.dart';
import 'package:task_manager_app/core/utils/validation.dart';
import 'package:task_manager_app/features/kanban/data/dto/create_task_dto.dart';
import 'package:task_manager_app/features/kanban/domain/entities/column.dart';
import 'package:task_manager_app/features/kanban/presentation/cubit/column_cubit/column_cubit.dart';
import 'package:task_manager_app/features/kanban/presentation/cubit/project_cubit/project_cubit.dart';
import 'package:task_manager_app/features/kanban/presentation/cubit/task_cubit/task_cubit.dart';
import 'package:task_manager_app/features/kanban/presentation/widgets/priority_dropdown_widget.dart';
import 'package:task_manager_app/features/kanban/presentation/widgets/reminder_switch_widget.dart';

///======================================================================================================
/// Widget for creating a new task.
///
/// This screen allows users to create a new task by providing various details such as title, description,
/// start date and time, duration, progress, priority, and reminder settings.
///
/// Users can input the following information:
///   - Title: The title of the task.
///   - Description: A description of the task.
///   - Start Date and Time: The start date and time of the task.
///   - Duration: The duration of the task.
///   - Unit: The unit of the duration (minute or day).
///   - Task Progress: The progress of the task, selected from available columns.
///   - Priority: The priority of the task, selected from a dropdown menu.
///   - Reminder: Toggle switch to enable or disable reminders for the task.
///
/// Upon successful creation of the task, users are shown a success message, and the screen navigates back
/// to the previous screen. In case of an error during task creation, an error message is displayed.
///
/// Parameters:
///   - `context`: The build context used to navigate to other screens and access dependencies.
///   - `columnEntity`: The column entity representing the progress of the task.
///======================================================================================================

class CreateTaskScreen extends StatefulWidget {
  ColumnEntity? columnEntity;
  CreateTaskScreen({super.key, this.columnEntity});

  @override
  State<CreateTaskScreen> createState() => _CreateTaskScreenState();
}

class _CreateTaskScreenState extends State<CreateTaskScreen> {
  final _formKey = GlobalKey<FormState>();
  TextEditingController contentController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();
  TextEditingController dateTimeController = TextEditingController();
  TextEditingController durationController = TextEditingController();
  TextEditingController unitController = TextEditingController();
  TextEditingController progressController = TextEditingController();
  TextEditingController priorityController = TextEditingController();
  bool reminder = true;
  @override
  void initState() {
    progressController.text = widget.columnEntity?.name ?? '';
    priorityController.text = "2";
    unitController.text = "minute";
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Create Task')),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Form(
          key: _formKey,
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                //========================== Content input ============================
                TextFormField(
                  controller: contentController,
                  validator: (value) => Validation.isEmptyValidation(value),
                  decoration: const InputDecoration(labelText: 'Title'),
                ),
                const SizedBox(height: 20),
                //========================== Description input ============================
                TextFormField(
                  controller: descriptionController,
                  maxLines: 100,
                  minLines: 1,
                  validator: (value) => Validation.isEmptyValidation(value),
                  decoration: const InputDecoration(labelText: 'Description'),
                ),
                const SizedBox(height: 20),
                //========================== Description input ============================
                TextFormField(
                  controller: dateTimeController,
                  readOnly: true,
                  onTap: () async {
                    dateTimeController.text = await AppDateTimePicker.show(context);
                  },
                  validator: (value) => Validation.isEmptyValidation(value),
                  decoration: const InputDecoration(labelText: 'Start date and time', suffixIcon: Icon(Icons.date_range_rounded)),
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
                ReminderSwitchwidget(onChanged: (value) => reminder = value, reminder: reminder),
                const SizedBox(height: 40),
                //========================== Create button ============================
                SizedBox(
                  width: MediaQuery.of(context).size.width,
                  height: 50,
                  child: BlocBuilder<TaskBloc, TaskState>(
                    buildWhen: (previous, current) {
                      if (current is CreateTaskState) {
                        switch (current.baseResponse.status) {
                          case Status.success:
                            AppSnackBar.show(context: context, message: "Added Successfully", status: SnackBarStatus.success);

                            AppRoutes.pop(context);
                            break;

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
                            context.read<TaskBloc>().createTask(
                                  CreateTaskDto(
                                      projectId: context.read<ProjectBloc>().currentProject?.id ?? '',
                                      content: contentController.text,
                                      description: descriptionController.text,
                                      dueDatetime: DateConverter.formatDateTime(DateConverter.parseDateTime(dateTimeController.text)),
                                      labels: [progressController.text],
                                      priority: int.parse(
                                        priorityController.text,
                                      ),
                                      duration: int.parse(durationController.text),
                                      durationUnit: unitController.text,
                                      reminder: reminder),
                                );
                          }
                        },
                        child: state is CreateTaskState && state.baseResponse.status == Status.loading ? const CircularProgressIndicator() : const Text("Create"),
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
