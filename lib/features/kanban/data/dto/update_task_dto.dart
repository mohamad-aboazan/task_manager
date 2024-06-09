class UpdateTaskDto {
  String? content;
  String? description;
  String? dueDatetime;
  List<String>? labels;
  int? priority;

  UpdateTaskDto({
    this.content,
    this.description,
    this.dueDatetime,
    this.labels,
    this.priority,
  });

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {};
    if (content != null) data['content'] = content;
    if (description != null) data['description'] = description;
    if (dueDatetime != null) data['due_datetime'] = dueDatetime;
    if (labels != null) data['labels'] = labels;
    if (priority != null) data['priority'] = priority;
    return data;
  }
}
