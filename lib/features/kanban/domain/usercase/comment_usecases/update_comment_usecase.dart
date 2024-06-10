import 'package:task_manager_app/features/kanban/data/dto/update_comment_dto.dart';
import 'package:task_manager_app/features/kanban/domain/repository/comment_repository.dart';

class UpdateCommentUsecase {
  final CommentRepository repository;

  UpdateCommentUsecase({required this.repository});

  Future execute({required String id, required UpdateCommentDto updateCommentDto}) async {
    return await repository.updateComment(id, updateCommentDto);
  }
}
