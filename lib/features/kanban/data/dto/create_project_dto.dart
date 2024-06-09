import 'package:task_manager_app/core/utils/todoist_colors.dart';

class CreateProjectDto {
  String? name;
  int? color;

  CreateProjectDto({
    this.name,
    this.color,
  });

  factory CreateProjectDto.fromJson(Map<String, dynamic> json) {
    return CreateProjectDto(
      name: json['name'],
      color: json['color'],
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['name'] = name;
    data['color'] = TodoistColors.getColorName(color ?? 0);
    return data;
  }
}
