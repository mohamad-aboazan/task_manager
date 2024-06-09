class CreateTaskDto {
  String content;
  String projectId;
  String description;
  String dueDatetime;
  List<String> labels;
  int priority;

  CreateTaskDto({
    required this.content,
    required this.description,
    required this.projectId,
    required this.dueDatetime,
    required this.labels,
    required this.priority,
  });

  factory CreateTaskDto.fromJson(Map<String, dynamic> json) {
    return CreateTaskDto(
      content: json['content'],
      description: json['description'],
      projectId: json['projectId'],
      dueDatetime: json['dueDatetime'],
      labels: List<String>.from(json['labels']),
      priority: json['priority'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'content': content,
      'description': description,
      'project_id': projectId,
      'due_datetime': dueDatetime,
      'labels': labels,
      'priority': priority,
    };
  }
}
