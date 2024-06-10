import 'package:bloc/bloc.dart';
import 'package:task_manager_app/core/entities/base_state.dart';
import 'package:task_manager_app/features/kanban/data/dto/create_comment_dto.dart';
import 'package:task_manager_app/features/kanban/data/dto/update_comment_dto.dart';
import 'package:task_manager_app/features/kanban/domain/entities/comment.dart';
import 'package:task_manager_app/features/kanban/domain/usercase/comment_usecases/create_comment_usecase.dart';
import 'package:task_manager_app/features/kanban/domain/usercase/comment_usecases/delete_comment_usecase.dart';
import 'package:task_manager_app/features/kanban/domain/usercase/comment_usecases/get_comments_usecase.dart';
import 'package:task_manager_app/features/kanban/domain/usercase/comment_usecases/update_comment_usecase.dart';

part "comment_state.dart";

class CommentBloc extends Cubit<CommentState> {
  final GetCommentsUsecase _getCommentsUsecase;
  final CreateCommentUsecase _createCommentUsecase;
  final UpdateCommentUsecase _updateCommentUsecase;
  final DeleteCommentUsecase _deleteCommentUsecase;

  CommentBloc(this._createCommentUsecase, this._updateCommentUsecase, this._getCommentsUsecase, this._deleteCommentUsecase) : super(InitialState());

  void createComment(CreateCommentDto createCommentDto) async {
    try {
      emit(CreateCommentState(baseResponse: BaseResponse.loading()));
      Comment comment = await _createCommentUsecase.execute(createCommentDto: createCommentDto);
      emit(CreateCommentState(baseResponse: BaseResponse.success(comment)));
    } catch (e) {
      emit(CreateCommentState(baseResponse: BaseResponse.error(e.toString())));
    }
  }

  void updateComment({required String id, required UpdateCommentDto updateCommentDto}) async {
    try {
      emit(UpdateCommentState(baseResponse: BaseResponse.loading()));
      Comment comment = await _updateCommentUsecase.execute(id: id, updateCommentDto: updateCommentDto);
      emit(UpdateCommentState(baseResponse: BaseResponse.success(comment)));
    } catch (e) {
      emit(UpdateCommentState(baseResponse: BaseResponse.error(e.toString())));
    }
  }

  void deleteComment(Comment comment) async {
    try {
      emit(DeleteCommentState(baseResponse: BaseResponse.loading()));
      await _deleteCommentUsecase.execute(id: comment.id!);
      emit(DeleteCommentState(baseResponse: BaseResponse.success(comment.id!)));
    } catch (e) {
      emit(DeleteCommentState(baseResponse: BaseResponse.error(e.toString())));
    }
  }

  void getComments(String taskId) async {
    try {
      emit(GetCommentsState(baseResponse: BaseResponse.loading()));
      List<Comment> comments = await _getCommentsUsecase.execute(taskId: taskId);
      emit(GetCommentsState(baseResponse: BaseResponse.success(comments)));
    } catch (e) {
      emit(GetCommentsState(baseResponse: BaseResponse.error(e.toString())));
    }
  }
}
