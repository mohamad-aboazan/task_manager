import 'package:task_manager_app/core/utils/todoist_colors.dart';

class ColumnEntity {
  String? id;
  String? name;
  int? color;
  int? order;
  bool? isFavorite;

  ColumnEntity({this.id, this.name, this.color, this.order, this.isFavorite});

  ColumnEntity.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    color = TodoistColors.getColorCode(json['color']);
    order = json['order'];
    isFavorite = json['is_favorite'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['id'] = id;
    data['name'] = name;
    data['color'] = color;
    data['order'] = order;
    data['is_favorite'] = isFavorite;
    return data;
  }
}
