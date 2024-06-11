import 'package:task_manager_app/core/services/api_service.dart';
import 'package:task_manager_app/core/utils/endpoints.dart';
import 'package:task_manager_app/features/kanban/data/dto/create_comment_dto.dart';
import 'package:task_manager_app/features/kanban/data/dto/update_comment_dto.dart';
import 'package:task_manager_app/features/kanban/domain/entities/comment.dart';

/// ============================================================================================
/// Remote data source for managing comments.
///
/// This data source handles operations related to comments through remote API calls using the `ApiService`.
///
/// Dependencies:
///   - `ApiService`: Service for making API calls.
///   - `Endpoints`: Utility class for defining API endpoints.
///
/// Abstract Methods:
///   - `getComments`: Fetches comments for a specific task from the remote API.
///   - `createComment`: Creates a new comment for a task via the remote API.
///   - `updateComment`: Updates an existing comment via the remote API.
///   - `deleteComment`: Deletes a comment via the remote API.
///
/// Usage:
///   - Implement the `CommentRemoteDataSource` abstract class with the required methods.
///   - Utilize `ApiService` to make HTTP requests to the appropriate endpoints for comment management.
///
/// ============================================================================================

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
