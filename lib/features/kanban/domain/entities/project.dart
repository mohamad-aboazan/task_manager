class Project {
  String? id;
  String? parentId;
  int? order;
  String? color;
  String? name;
  int? commentCount;
  bool? isShared;
  bool? isFavorite;
  bool? isInboxProject;
  bool? isTeamInbox;
  String? url;
  String? viewStyle;

  Project.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    parentId = json['parent_id'];
    order = json['order'];
    color = json['color'];
    name = json['name'];
    commentCount = json['comment_count'];
    isShared = json['is_shared'];
    isFavorite = json['is_favorite'];
    isInboxProject = json['is_inbox_project'];
    isTeamInbox = json['is_team_inbox'];
    url = json['url'];
    viewStyle = json['view_style'];
  }
}
