class CreateTaskDto {
  String content;
  String projectId;
  String description;
  String dueDatetime;
  List<String> labels;
  int priority;
  int duration;
  String durationUnit;

  CreateTaskDto({required this.content, required this.description, required this.projectId, required this.dueDatetime, required this.labels, required this.priority, required this.duration, required this.durationUnit});

  Map<String, dynamic> toJson() {
    return {
      'content': content,
      'description': description,
      'project_id': projectId,
      'due_datetime': dueDatetime,
      'labels': labels,
      'priority': priority,
      'duration': duration,
      "duration_unit": durationUnit,
    };
  }
}
