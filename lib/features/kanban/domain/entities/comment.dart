import 'package:hive/hive.dart';

part 'comment.g.dart';

@HiveType(typeId: 0)
class Comment extends HiveObject {
  @HiveField(0)
  String? content;

  @HiveField(1)
  String? id;

  @HiveField(2)
  String? postedAt;

  @HiveField(3)
  String? projectId;

  @HiveField(4)
  String? taskId;

  Comment({
    this.content,
    this.id,
    this.postedAt,
    this.projectId,
    this.taskId,
  });

  Comment.fromJson(Map<String, dynamic> json) {
    content = json['content'];
    id = json['id'];
    postedAt = json['posted_at'];
    projectId = json['project_id'];
    taskId = json['task_id'];
  }

  Map<String, dynamic> toJson() {
    return {
      'content': content,
      'id': id,
      'posted_at': postedAt,
      'project_id': projectId,
      'task_id': taskId,
    };
  }
}
