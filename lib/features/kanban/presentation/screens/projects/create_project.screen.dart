import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:task_manager_app/core/entities/base_state.dart';
import 'package:task_manager_app/core/route/route.dart';
import 'package:task_manager_app/core/sharedwidgets/app_snackbar.dart';
import 'package:task_manager_app/core/utils/validation.dart';
import 'package:task_manager_app/features/kanban/presentation/screens/home/home_screen.dart';
import 'package:task_manager_app/features/kanban/data/dto/create_project_dto.dart';
import 'package:task_manager_app/features/kanban/presentation/cubit/project_cubit/project_cubit.dart';
import 'package:task_manager_app/features/kanban/presentation/cubit/theme_cubit/theme_cubit.dart';
import 'package:task_manager_app/features/kanban/presentation/widgets/dialog/color_picker_dialog.dart';

class CreateProjectScreen extends StatefulWidget {
  const CreateProjectScreen({super.key});

  @override
  State<CreateProjectScreen> createState() => _CreateProjectScreenState();
}

class _CreateProjectScreenState extends State<CreateProjectScreen> {
  final _formKey = GlobalKey<FormState>();
  TextEditingController projectNameController = TextEditingController();
  int _selectedColor = 0xff884dff; // Default color

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Create Project')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                //========================== prject name input ============================
                TextFormField(
                  controller: projectNameController,
                  validator: (value) => Validation.isEmptyValidation(value),
                  decoration: const InputDecoration(labelText: 'Project Name'),
                ),
                const SizedBox(height: 16.0),
                //========================== prject color input ============================
                StatefulBuilder(builder: (context, setStateColor) {
                  return InkWell(
                    onTap: () {
                      ColorPickerDialog.show(
                        context,
                        onColorChanged: (int color) {
                          setStateColor(() {
                            _selectedColor = color;
                          });
                        },
                      );
                    },
                    child: Row(
                      children: [
                        Text(
                          'Choose Base Color for Project Gradien : ',
                          style: Theme.of(context).textTheme.bodyLarge,
                        ),
                        const SizedBox(width: 10),
                        CircleAvatar(
                          backgroundColor: Color(_selectedColor),
                          radius: 16,
                        ),
                      ],
                    ),
                  );
                }),
                const SizedBox(height: 16.0),
                //========================== Create button ============================
                SizedBox(
                  width: MediaQuery.of(context).size.width,
                  height: 50,
                  child: BlocBuilder<ProjectBloc, ProjectState>(
                    buildWhen: (previous, current) {
                      if (current is CreateProjectState) {
                        switch (current.baseResponse.status) {
                          case Status.success:
                            AppRoutes.pushAndRemoveUntil(context, const HomeScreen());
                            context.read<ThemeBloc>().changeTheme(color: Color(_selectedColor));

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
                            context.read<ProjectBloc>().createProject(CreateProjectDto(color: _selectedColor, name: projectNameController.text));
                          }
                        },
                        child: state is CreateProjectState && state.baseResponse.status == Status.loading ? const CircularProgressIndicator() : const Text("Create"),
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
