import 'package:task_manager_app/core/services/api_service.dart';
import 'package:task_manager_app/core/utils/endpoints.dart';
import 'package:task_manager_app/features/kanban/data/dto/create_comment_dto.dart';
import 'package:task_manager_app/features/kanban/data/dto/update_comment_dto.dart';
import 'package:task_manager_app/features/kanban/domain/entities/comment.dart';

abstract class CommentRemoteDataSource {
  Future<List<Comment>> getComments(String taskId);
  Future<Comment> createComment(CreateCommentDto createCommentDto);
  Future<Comment> updateComment(String id, UpdateCommentDto updateCommentDto);
  Future<void> deleteComment(String id);
}

class CommentRemoteDataSourceImp implements CommentRemoteDataSource {
  final ApiService apiService;
  CommentRemoteDataSourceImp({required this.apiService});

  @override
  Future<Comment> createComment(CreateCommentDto createCommentDto) async {
    var responseData = await apiService.post(Endpoints.COMMENTS, createCommentDto.toJson());
    Comment comment = Comment.fromJson(responseData);
    return comment;
  }

  @override
  Future<Comment> updateComment(String id, UpdateCommentDto updateCommentDto) async {
    var responseData = await apiService.post("${Endpoints.COMMENTS}/$id", updateCommentDto.toJson());
    Comment comment = Comment.fromJson(responseData);
    return comment;
  }

  @override
  Future<List<Comment>> getComments(String taskId) async {
    var responseData = await apiService.get('${Endpoints.COMMENTS}?task_id=$taskId');
    List<Comment> comments = responseData.map((e) => Comment.fromJson(e)).toList().cast<Comment>();
    return comments;
  }

  @override
  Future<void> deleteComment(String id) async {
    await apiService.delete('${Endpoints.COMMENTS}/$id');
  }
}
