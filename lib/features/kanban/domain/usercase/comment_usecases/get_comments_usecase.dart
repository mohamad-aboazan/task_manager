import 'package:task_manager_app/features/kanban/domain/entities/comment.dart';
import 'package:task_manager_app/features/kanban/domain/repository/comment_repository.dart';

class GetCommentsUsecase {
  final CommentRepository repository;

  GetCommentsUsecase({required this.repository});

  Future<List<Comment>> execute({required String taskId}) async {
    return await repository.getComments(taskId);
  }
}
