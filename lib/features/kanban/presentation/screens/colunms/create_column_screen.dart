import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:task_manager_app/core/entities/base_state.dart';
import 'package:task_manager_app/core/sharedwidgets/app_snackbar.dart';
import 'package:task_manager_app/core/utils/validation.dart';
import 'package:task_manager_app/features/kanban/data/dto/create_column_dto.dart';
import 'package:task_manager_app/features/kanban/presentation/cubit/column_cubit/column_cubit.dart';
import 'package:task_manager_app/features/kanban/presentation/widgets/dialog/color_picker_dialog.dart';

///======================================================================================================
/// Screen for creating a new column in the Kanban board.
///
/// This screen allows users to input the name and choose the color of the new column. Upon successful
/// creation of the column, it fetches the updated list of columns to reflect the changes.
///
/// Features:
///   - Input field for column name.
///   - Color picker for selecting the column color.
///
/// Dependencies:
///   - `ColumnBloc`: Used to create a new column and fetch updated columns data.
///   - `ColorPickerDialog`: Custom dialog for picking colors.
///   - `AppSnackBar`: Custom widget for displaying snack bars.
///
/// Routes:
///   - This screen can be accessed from the home screen by tapping the "Create New Column" button.
///======================================================================================================

class CreateColumnScreen extends StatefulWidget {
  const CreateColumnScreen({super.key});

  @override
  State<CreateColumnScreen> createState() => _CreateColumnScreenState();
}

class _CreateColumnScreenState extends State<CreateColumnScreen> {
  final _formKey = GlobalKey<FormState>();
  TextEditingController columnController = TextEditingController();
  int _selectedColor = 0xff884dff; // Default color

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Create New Column'.tr())),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              //========================== Column name input ============================
              TextFormField(
                controller: columnController,
                validator: (value) => Validation.isEmptyValidation(value),
                decoration: InputDecoration(labelText: 'Column Name'.tr()),
              ),
              const SizedBox(height: 16.0),
              //========================== Column color input ============================
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
                        'Choose Column Color: '.tr(),
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
                child: BlocBuilder<ColumnBloc, ColumnState>(
                  buildWhen: (previous, current) {
                    if (current is CreateColumnState) {
                      switch (current.baseResponse.status) {
                        case Status.success:
                          context.read<ColumnBloc>().getColumns();
                          AppSnackBar.show(context: context, message: "Added Successfully".tr(), status: SnackBarStatus.success);

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
                          context.read<ColumnBloc>().createColumn(CreateColumnDto(color: _selectedColor, name: columnController.text));
                        }
                      },
                      child: state is CreateColumnState && state.baseResponse.status == Status.loading ? const CircularProgressIndicator() : const Text("Create"),
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
