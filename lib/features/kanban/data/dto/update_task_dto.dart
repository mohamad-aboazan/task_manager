class UpdateTaskDto {
  String? content;
  String? description;
  Due? due;
  List<String>? labels;
  int? priority;

  UpdateTaskDto({
    this.content,
    this.description,
    this.due,
    this.labels,
    this.priority,
  });

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {};
    if (content != null) data['content'] = content;
    if (description != null) data['description'] = description;
    if (due != null) data['due'] = due!.toJson();
    if (labels != null) data['labels'] = labels;
    if (priority != null) data['priority'] = priority;
    return data;
  }
}

class Due {
  String? datetime;

  Due({this.datetime});

  factory Due.fromJson(Map<String, dynamic> json) {
    return Due(
      datetime: json['datetime'],
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {};
    if (datetime != null) data['datetime'] = datetime;
    return data;
  }
}
