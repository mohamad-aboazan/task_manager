import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:task_manager_app/core/entities/base_state.dart';
import 'package:task_manager_app/core/route/route.dart';
import 'package:task_manager_app/core/sharedwdigets/app_snackbar.dart';
import 'package:task_manager_app/core/utils/date_converter.dart';
import 'package:task_manager_app/core/utils/validation.dart';
import 'package:task_manager_app/features/kanban/data/dto/update_task_dto.dart';
import 'package:task_manager_app/features/kanban/domain/entities/column.dart';
import 'package:task_manager_app/features/kanban/domain/entities/task.dart' as t;
import 'package:task_manager_app/features/kanban/presentation/cubit/column_cubit/column_cubit.dart';
import 'package:task_manager_app/features/kanban/presentation/cubit/task_cubit/task_cubit.dart';

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
  late TextEditingController progressController;
  late TextEditingController priorityController;

  @override
  void initState() {
    super.initState();
    contentController = TextEditingController(text: widget.task.content);
    descriptionController = TextEditingController(text: widget.task.description);
    dateTimeController = TextEditingController(text: DateConverter.formatHumanReadableDateTime(DateTime.parse(widget.task.due?.datetime ?? '')));
    progressController = TextEditingController(text: widget.task.labels?.first);
    priorityController = TextEditingController(text: widget.task.priority.toString());
  }

  void _editDateTimeField() async {
    final DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: DateTime.parse(widget.task.due?.datetime ?? ''),
      firstDate: DateTime.now(),
      lastDate: DateTime.now().add(const Duration(days: 365)),
    );

    if (pickedDate != null) {
      // final TimeOfDay? pickedTime = await showTimePicker(
      //   context: context,
      //   initialTime: TimeOfDay.fromDateTime(DateTime.parse(widget.task.due?.datetime ?? '')),
      // );

      // if (pickedTime != null) {
      //   final DateTime dateTime = DateTime(
      //     pickedDate.year,
      //     pickedDate.month,
      //     pickedDate.day,
      //     pickedTime.hour,
      //     pickedTime.minute,
      //   );
      //   dateTimeController.text = DateFormat('yyyy-MM-dd hh:mm a').format(dateTime);
      //   setState(() {});
      // }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('View Task')),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Form(
          key: _formKey,
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                // Content input
                TextFormField(
                  controller: contentController,
                  validator: (value) => Validation.isEmptyValidation(value),
                  decoration: const InputDecoration(labelText: 'Content'),
                ),
                const SizedBox(height: 20),
                // Description input
                TextFormField(
                  controller: descriptionController,
                  maxLines: 100,
                  minLines: 1,
                  validator: (value) => Validation.isEmptyValidation(value),
                  decoration: const InputDecoration(labelText: 'Description'),
                ),
                const SizedBox(height: 20),
                // Date and Time input
                TextFormField(
                  controller: dateTimeController,
                  readOnly: true,
                  onTap: _editDateTimeField,
                  validator: (value) => Validation.isEmptyValidation(value),
                  decoration: const InputDecoration(
                    labelText: 'Date and time',
                    suffixIcon: Icon(Icons.date_range_rounded),
                  ),
                ),
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

                DropdownMenu(
                  expandedInsets: EdgeInsets.zero,
                  controller: priorityController,
                  label: const Text("priority"),
                  dropdownMenuEntries: const [
                    DropdownMenuEntry(value: 1, label: "1"),
                    DropdownMenuEntry(value: 2, label: "2"),
                    DropdownMenuEntry(value: 3, label: "3"),
                    DropdownMenuEntry(value: 4, label: "4"),
                  ],
                ),
                const SizedBox(height: 20),
                const SizedBox(height: 20),
                // Save Changes button
                SizedBox(
                  width: MediaQuery.of(context).size.width,
                  height: 50,
                  child: BlocBuilder<TaskBloc, TaskState>(
                    buildWhen: (previous, current) {
                      if (current is UpdateTaskState) {
                        switch (current.baseResponse.status) {
                          case Status.success:
                            AppSnackBar.show(context: context, message: "Updated Successfully", status: SnackBarStatus.success);
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
                            // Uncomment and implement the update task functionality as needed.

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
                                ));
                          }
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
