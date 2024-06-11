import 'package:flutter/material.dart';
import 'package:task_manager_app/core/utils/constant.dart';

///======================================================================================================
/// Widget for displaying a dropdown menu to select task priority.
///
/// This widget provides a dropdown menu for selecting the priority of a task. It takes a `TextEditingController`
/// as a parameter to control the selected priority value. The dropdown menu items are populated with priority
/// icons and labels from the `Constant.priorityIcons` list.
///
/// Parameters:
///   - `priorityController`: A `TextEditingController` to control the selected priority value.
///======================================================================================================

class PriorityDropdownWidget extends StatefulWidget {
  TextEditingController priorityController;
  PriorityDropdownWidget({super.key, required this.priorityController});

  @override
  State<PriorityDropdownWidget> createState() => _PriorityDropdownWidgetState();
}

class _PriorityDropdownWidgetState extends State<PriorityDropdownWidget> {
  @override
  Widget build(BuildContext context) {
    return StatefulBuilder(builder: (context, setstateDropdown) {
      return DropdownMenu(
        expandedInsets: EdgeInsets.zero,
        controller: widget.priorityController,
        leadingIcon: Constant.priorityIcons[int.parse(widget.priorityController.text) - 1],
        label: const Text("priority"),
        onSelected: (value) {
          setstateDropdown(() {});
        },
        dropdownMenuEntries: [
          for (int i = 0; i < Constant.priorityIcons.length; i++) ...[
            DropdownMenuEntry(value: i + 1, label: "${i + 1}", leadingIcon: Constant.priorityIcons[i]),
          ]
        ],
      );
    });
  }
}
