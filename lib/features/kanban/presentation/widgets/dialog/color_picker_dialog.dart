import 'package:flutter/material.dart';
import 'package:task_manager_app/core/route/route.dart';
import 'package:task_manager_app/core/utils/todoist_colors.dart';

class ColorPickerDialog {
  // These are the colors that todoist api allows you to use
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
