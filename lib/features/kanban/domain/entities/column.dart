import 'package:task_manager_app/core/utils/todoist_colors.dart';

class ColumnEntity {
  String? id;
  String? name;
  int? color;
  int? order;
  bool? isFavorite;

  ColumnEntity.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    color = TodoistColors.getColorCode(json['color']);
    order = json['order'];
    isFavorite = json['is_favorite'];
  }
}
