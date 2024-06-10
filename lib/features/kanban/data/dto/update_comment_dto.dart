class UpdateCommentDto {
  String? content;

  UpdateCommentDto({this.content});

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['content'] = content;
    return data;
  }
}
