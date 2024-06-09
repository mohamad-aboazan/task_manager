import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:task_manager_app/core/entities/base_state.dart';
import 'package:task_manager_app/core/route/route.dart';
import 'package:task_manager_app/core/sharedwdigets/app_snackbar.dart';
import 'package:task_manager_app/core/utils/validation.dart';
import 'package:task_manager_app/features/kanban/data/dto/create_task_dto.dart';
import 'package:task_manager_app/features/kanban/domain/entities/column.dart';
import 'package:task_manager_app/features/kanban/presentation/cubit/column_cubit/column_cubit.dart';
import 'package:task_manager_app/features/kanban/presentation/cubit/project_cubit/project_cubit.dart';
import 'package:task_manager_app/features/kanban/presentation/cubit/task_cubit/task_cubit.dart';

class CreateTaskScreen extends StatefulWidget {
  List<ColumnEntity>? colunmEntities;
  ColumnEntity? columnEntity;
  CreateTaskScreen({super.key, this.colunmEntities, this.columnEntity});

  @override
  State<CreateTaskScreen> createState() => _CreateTaskScreenState();
}

class _CreateTaskScreenState extends State<CreateTaskScreen> {
  final _formKey = GlobalKey<FormState>();
  TextEditingController contentController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();
  TextEditingController progressController = TextEditingController();
  TextEditingController priorityController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Create Task')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
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
                  decoration: const InputDecoration(labelText: 'Content'),
                ),
                const SizedBox(height: 16.0),
                //========================== Description input ============================
                TextFormField(
                  controller: descriptionController,
                  maxLines: 100,
                  minLines: 1,
                  validator: (value) => Validation.isEmptyValidation(value),
                  decoration: const InputDecoration(labelText: 'Description'),
                ),
                const SizedBox(height: 16.0),
                //========================== Progress input ============================
                DropdownMenu(
                    expandedInsets: EdgeInsets.zero,
                    controller: progressController,
                    label: const Text("Task Progress"),
                    initialSelection: widget.columnEntity?.name.toString(),
                    dropdownMenuEntries: widget.colunmEntities!
                        .map(
                          (e) => DropdownMenuEntry(value: e.name, label: e.name.toString()),
                        )
                        .toList()),
                const SizedBox(height: 16.0),
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
                const SizedBox(height: 16.0),

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
                                    project_id: context.read<ProjectBloc>().currentProject?.id ?? '',
                                    content: contentController.text,
                                    description: descriptionController.text,
                                    due: Due(datetime: "datetime"),
                                    labels: [progressController.text],
                                    priority: int.parse(
                                      priorityController.text,
                                    ),
                                  ),
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
