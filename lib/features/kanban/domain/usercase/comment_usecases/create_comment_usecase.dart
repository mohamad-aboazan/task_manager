import 'package:task_manager_app/features/kanban/data/dto/create_comment_dto.dart';
import 'package:task_manager_app/features/kanban/domain/repository/comment_repository.dart';

class CreateCommentUsecase {
  final CommentRepository repository;

  CreateCommentUsecase({required this.repository});

  Future execute({required CreateCommentDto createCommentDto}) async {
    return await repository.createComment(createCommentDto);
  }
}
