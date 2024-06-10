import 'package:task_manager_app/features/kanban/domain/repository/comment_repository.dart';

class DeleteCommentUsecase {
  final CommentRepository repository;

  DeleteCommentUsecase({required this.repository});

  Future execute({required String id}) async {
    return await repository.deleteComment(id);
  }
}
