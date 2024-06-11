import 'package:bloc/bloc.dart';
import 'package:task_manager_app/core/entities/base_state.dart';
import 'package:task_manager_app/features/kanban/data/dto/create_column_dto.dart';
import 'package:task_manager_app/features/kanban/domain/entities/column.dart';
import 'package:task_manager_app/features/kanban/domain/usercase/column_usecases/create_column_usecase.dart';
import 'package:task_manager_app/features/kanban/domain/usercase/column_usecases/get_column_usecase.dart';

part "column_state.dart";

/// =========================================================================================================
/// BLoC for managing columns in the Kanban application.
///
/// This BLoC is responsible for handling columns within the Kanban application. It provides functionalities
/// for creating and retrieving columns.
///
/// Features:
///   - Create and retrieve columns.
///
/// Usage:
///   - Instantiate `ColumnBloc` with required dependencies.
///   - Use methods like `createColumn`, `getColumns` to perform column operations.
///
///=========================================================================================================

class ColumnBloc extends Cubit<ColumnState> {
  final GetColumnsUsecase _getColumnsUsecase;
  final CreateColumnUsecase _createColumnUsecase;

  ColumnBloc(this._getColumnsUsecase, this._createColumnUsecase) : super(InitialState());
  List<ColumnEntity> colunmEntities = [];
  void getColumns() async {
    try {
      emit(GetColumnsState(baseResponse: BaseResponse.loading()));
      List<ColumnEntity> columns = await _getColumnsUsecase.execute();
      colunmEntities = columns;
      emit(GetColumnsState(baseResponse: BaseResponse.success(columns)));
    } catch (e) {
      emit(GetColumnsState(baseResponse: BaseResponse.error(e.toString())));
    }
  }

  void createColumn(CreateColumnDto createColumnDto) async {
    try {
      emit(CreateColumnState(baseResponse: BaseResponse.loading()));
      ColumnEntity column = await _createColumnUsecase.execute(createColumnDto: createColumnDto);
      emit(CreateColumnState(baseResponse: BaseResponse.success(column)));
    } catch (e) {
      emit(CreateColumnState(baseResponse: BaseResponse.error(e.toString())));
    }
  }
}
