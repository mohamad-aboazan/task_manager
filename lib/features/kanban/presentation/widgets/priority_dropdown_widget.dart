import 'package:flutter/material.dart';

class PriorityDropdownWidget extends StatefulWidget {
  TextEditingController priorityController;
  PriorityDropdownWidget({super.key, required this.priorityController});

  @override
  State<PriorityDropdownWidget> createState() => _PriorityDropdownWidgetState();
}

class _PriorityDropdownWidgetState extends State<PriorityDropdownWidget> {
  List<Widget> priorityIcons = const [
    Icon(
      Icons.keyboard_double_arrow_up_rounded,
      color: Colors.greenAccent,
    ),
    Icon(
      Icons.keyboard_arrow_up_rounded,
      color: Colors.lightGreenAccent,
    ),
    Icon(
      Icons.keyboard_arrow_down_rounded,
      color: Colors.amber,
    ),
    Icon(
      Icons.keyboard_double_arrow_down_rounded,
      color: Colors.red,
    )
  ];
  @override
  Widget build(BuildContext context) {
    return StatefulBuilder(builder: (context, setstateDropdown) {
      return DropdownMenu(
        expandedInsets: EdgeInsets.zero,
        controller: widget.priorityController,
        leadingIcon: priorityIcons[int.parse(widget.priorityController.text)-1],
        label: const Text("priority"),
        onSelected: (value) {
          setstateDropdown(() {});
        },
        dropdownMenuEntries: [
          for (int i = 0; i < priorityIcons.length; i++) ...[
            DropdownMenuEntry(value: i + 1, label: "${i + 1}", leadingIcon: priorityIcons[i]),
          ]
        ],
      );
    });
  }
}
