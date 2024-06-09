class UpdateTaskDto {
  String? content;
  String? description;
  String? dueDatetime;
  List<String>? labels;
  int? priority;
  int? duration;
  String? durationUnit;
  UpdateTaskDto({this.content, this.description, this.dueDatetime, this.labels, this.priority, this.duration, this.durationUnit});

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {};
    if (content != null) data['content'] = content;
    if (description != null) data['description'] = description;
    if (dueDatetime != null) data['due_datetime'] = dueDatetime;
    if (labels != null) data['labels'] = labels;
    if (priority != null) data['priority'] = priority;
    if (durationUnit != null) data['duration_unit'] = durationUnit;
    if (duration != null) data['duration'] = duration;
    return data;
  }
}
