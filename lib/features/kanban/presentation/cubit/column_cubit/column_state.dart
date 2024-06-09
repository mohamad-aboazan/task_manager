part of 'column_cubit.dart';

abstract class ColumnState {}

class InitialState extends ColumnState {}

class CreateColumnState extends ColumnState {
  BaseResponse<ColumnEntity> baseResponse;
  CreateColumnState({required this.baseResponse});
}

class GetColumnsState extends ColumnState {
  BaseResponse<List<ColumnEntity>> baseResponse;
  GetColumnsState({required this.baseResponse});
}
