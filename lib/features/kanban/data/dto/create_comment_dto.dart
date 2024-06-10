class CreateCommentDto {
  String? taskId;
  String? content;

  CreateCommentDto({this.taskId, this.content});

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['task_id'] = taskId;
    data['content'] = content;
    return data;
  }
}
