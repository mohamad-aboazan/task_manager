import 'package:task_manager_app/core/network/network_info.dart';
import 'package:task_manager_app/features/kanban/data/datasources/remote/comment_remote_data_sourc.dart';
import 'package:task_manager_app/features/kanban/data/dto/update_comment_dto.dart';
import 'package:task_manager_app/features/kanban/domain/entities/comment.dart';
import 'package:task_manager_app/features/kanban/domain/repository/comment_repository.dart';

/// =================================================================================================
/// Comment Repository Implementation
///
/// This class implements the `CommentRepository` interface, providing methods to interact with
/// comments in the Kanban application. It manages communication between the domain layer and
/// remote data source for comment-related operations.
///
/// Dependencies:
///   - `NetworkInfo`: Service for checking network connectivity.
///   - `CommentRemoteDataSource`: Data source for remote comment operations.
///
/// Usage:
///   - Use instances of this class to perform operations related to comments, such as creating,
///     updating, fetching, and deleting comments.
///
/// =================================================================================================

class CommentRepositoryImpl implements CommentRepository {
  final NetworkInfo networkInfo;
  final CommentRemoteDataSource commentRemoteDataSource;

  CommentRepositoryImpl({required this.commentRemoteDataSource, required this.networkInfo});

  @override
  Future<Comment> createComment(createCommentDto) async {
    return await commentRemoteDataSource.createComment(createCommentDto);
  }

  @override
  Future<Comment> updateComment(String id, UpdateCommentDto updateCommentDto) async {
    return await commentRemoteDataSource.updateComment(id, updateCommentDto);
  }

  @override
  Future<List<Comment>> getComments(String taskId) async {
    return await commentRemoteDataSource.getComments(taskId);
  }

  @override
  Future<void> deleteComment(String id) async {
    return await commentRemoteDataSource.deleteComment(id);
  }
}
