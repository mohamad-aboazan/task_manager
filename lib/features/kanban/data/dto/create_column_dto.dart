import 'package:task_manager_app/core/utils/todoist_colors.dart';

class CreateColumnDto {
  String? name;
  int? color;

  CreateColumnDto({
    this.name,
    this.color,
  });

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['name'] = name;
    data['color'] = TodoistColors.getColorName(color ?? 0);
    return data;
  }
}
