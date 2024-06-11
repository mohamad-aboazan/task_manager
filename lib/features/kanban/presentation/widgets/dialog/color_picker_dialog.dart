import 'package:flutter/material.dart';
import 'package:task_manager_app/core/route/route.dart';
import 'package:task_manager_app/core/utils/todoist_colors.dart';

///======================================================================================================
/// Class for displaying a color picker dialog.
///
/// This class provides a dialog for the user to pick a color from a predefined set of colors. The colors
/// available for selection are those allowed by the Todoist API.
///
/// Parameters:
///   - `context`: The build context used to show the dialog.
///   - `onColorChanged`: A callback function that is called when a color is selected. It takes an integer
///     representing the selected color.
///======================================================================================================

class ColorPickerDialog {
  static void show(
    BuildContext context, {
    Function(int)? onColorChanged,
  }) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Pick a color'),
          content: Wrap(
            alignment: WrapAlignment.center,
            children: [
              for (int i = 0; i < TodoistColors.colors.length; i++)
                InkWell(
                  onTap: () {
                    onColorChanged!(TodoistColors.colors[i]);
                    AppRoutes.pop(context);
                  },
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: CircleAvatar(
                      radius: 25,
                      backgroundColor: Color(TodoistColors.colors[i]),
                    ),
                  ),
                )
            ],
          ),
        );
      },
    );
  }
}
