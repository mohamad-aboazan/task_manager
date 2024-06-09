class CreateTaskDto {
  String content;
  String project_id;
  String description;
  Due due;
  List<String> labels;
  int priority;

  CreateTaskDto({
    required this.content,
    required this.description,
    required this.project_id,
    required this.due,
    required this.labels,
    required this.priority,
  });

  factory CreateTaskDto.fromJson(Map<String, dynamic> json) {
    return CreateTaskDto(
      content: json['content'],
      description: json['description'],
      project_id: json['project_id'],
      due: Due.fromJson(json['due']),
      labels: List<String>.from(json['labels']),
      priority: json['priority'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'content': content,
      'description': description,
      'project_id': project_id,
      'due': due.toJson(),
      'labels': labels,
      'priority': priority,
    };
  }
}

class Due {
  String datetime;

  Due({
    required this.datetime,
  });

  factory Due.fromJson(Map<String, dynamic> json) {
    return Due(
      datetime: json['datetime'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'datetime': datetime,
    };
  }
}
