part of 'comment_cubit.dart';

abstract class CommentState {}

class InitialState extends CommentState {}

class CreateCommentState extends CommentState {
  BaseResponse<Comment> baseResponse;
  CreateCommentState({required this.baseResponse});
}

class UpdateCommentState extends CommentState {
  BaseResponse baseResponse;
  UpdateCommentState({required this.baseResponse});
}

class GetCommentsState extends CommentState {
  BaseResponse<List<Comment>> baseResponse;
  GetCommentsState({required this.baseResponse});
}

class DeleteCommentState extends CommentState {
  BaseResponse<String> baseResponse;
  DeleteCommentState({required this.baseResponse});
}
