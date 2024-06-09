import 'package:flutter/material.dart';
import 'package:task_manager_app/core/utils/constant.dart';

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
