import 'package:task_manager_app/features/kanban/data/dto/create_comment_dto.dart';
import 'package:task_manager_app/features/kanban/data/dto/update_comment_dto.dart';
import 'package:task_manager_app/features/kanban/domain/entities/comment.dart';

abstract class CommentRepository {
  Future<List<Comment>> getComments(String taskId);
  Future<Comment> createComment(CreateCommentDto createCommentDto);
  Future<Comment> updateComment(String id, UpdateCommentDto updateCommentDto);
  Future<void> deleteComment(String id);
}
