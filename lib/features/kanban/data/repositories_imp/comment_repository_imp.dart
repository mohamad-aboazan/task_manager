import 'package:task_manager_app/core/network/network_info.dart';
import 'package:task_manager_app/features/kanban/data/datasources/remote/comment_remote_data_sourc.dart';
import 'package:task_manager_app/features/kanban/data/dto/update_comment_dto.dart';
import 'package:task_manager_app/features/kanban/domain/entities/comment.dart';
import 'package:task_manager_app/features/kanban/domain/repository/comment_repository.dart';

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
