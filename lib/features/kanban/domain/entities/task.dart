import 'package:hive/hive.dart';
import 'package:task_manager_app/features/kanban/domain/entities/comment.dart';

part 'task.g.dart';

@HiveType(typeId: 0)
class Task extends HiveObject {
  @HiveField(0)
  String? creatorId;
  @HiveField(1)
  String? createdAt;
  @HiveField(2)
  String? assigneeId;
  @HiveField(3)
  String? assignerId;
  @HiveField(4)
  int? commentCount;
  @HiveField(5)
  bool? isCompleted;
  @HiveField(6)
  String? content;
  @HiveField(7)
  String? description;
  @HiveField(8)
  Due? due;
  @HiveField(9)
  Duration? duration;
  @HiveField(10)
  String? id;
  @HiveField(11)
  List<String>? labels;
  @HiveField(12)
  int? order;
  @HiveField(13)
  int? priority;
  @HiveField(14)
  String? projectId;
  @HiveField(15)
  String? sectionId;
  @HiveField(16)
  String? parentId;
  @HiveField(17)
  String? url;
  @HiveField(18)
  List<Comment>? comments;

  Task({this.creatorId, this.createdAt, this.assigneeId, this.assignerId, this.commentCount, this.isCompleted, this.content, this.description, this.due, this.duration, this.id, this.labels, this.order, this.priority, this.projectId, this.sectionId, this.parentId, this.url, this.comments});

  factory Task.fromJson(Map<String, dynamic> json) {
    return Task(
      creatorId: json['creator_id'],
      createdAt: json['created_at'],
      assigneeId: json['assignee_id'],
      assignerId: json['assigner_id'],
      commentCount: json['comment_count'],
      isCompleted: json['is_completed'],
      content: json['content'],
      description: json['description'],
      due: json['due'] != null ? Due.fromJson(json['due']) : null,
      duration: json['duration'] != null ? Duration.fromJson(json['duration']) : null,
      id: json['id'],
      labels: json['labels'].cast<String>(),
      order: json['order'],
      priority: json['priority'],
      projectId: json['project_id'],
      sectionId: json['section_id'],
      parentId: json['parent_id'],
      url: json['url'],
      comments: [],
    );
  }

  int getShortId() {
    return int.parse(id!.substring(id!.length - 3, id?.length));
  }
}

@HiveType(typeId: 1)
class Due extends HiveObject {
  @HiveField(0)
  String? date;
  @HiveField(1)
  bool? isRecurring;
  @HiveField(2)
  String? datetime;
  @HiveField(3)
  String? string;
  @HiveField(4)
  String? timezone;

  Due({this.date, this.isRecurring, this.datetime, this.string, this.timezone});

  factory Due.fromJson(Map<String, dynamic> json) {
    return Due(
      date: json['date'],
      isRecurring: json['is_recurring'],
      datetime: json['datetime'],
      string: json['string'],
      timezone: json['timezone'],
    );
  }
}

@HiveType(typeId: 2)
class Duration extends HiveObject {
  @HiveField(0)
  int? amount;
  @HiveField(1)
  String? unit;

  Duration({this.amount, this.unit});

  factory Duration.fromJson(Map<String, dynamic> json) {
    return Duration(
      amount: json['amount'],
      unit: json['unit'],
    );
  }
}
