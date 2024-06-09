import 'package:bloc/bloc.dart';
import 'package:task_manager_app/core/entities/base_state.dart';
import 'package:task_manager_app/features/kanban/data/dto/create_column_dto.dart';
import 'package:task_manager_app/features/kanban/domain/entities/column.dart';
import 'package:task_manager_app/features/kanban/domain/usercase/column_usecases/create_column_usecase.dart';
import 'package:task_manager_app/features/kanban/domain/usercase/column_usecases/get_column_usecase.dart';
import 'package:task_manager_app/features/kanban/domain/usercase/task_usecases/get_tasks_usecase.dart';

part "column_state.dart";

class ColumnBloc extends Cubit<ColumnState> {
  final GetColumnsUsecase getColumnsUsecase;
  final CreateColumnUsecase createColumnUsecase;
  final GetTasksUsecase getTasksUsecase;

  ColumnBloc({required this.getColumnsUsecase, required this.createColumnUsecase, required this.getTasksUsecase}) : super(InitialState());
  List<ColumnEntity> colunmEntities = [];
  void getColumns() async {
    try {
      emit(GetColumnsState(baseResponse: BaseResponse.loading()));
      List<ColumnEntity> columns = await getColumnsUsecase.execute();
      colunmEntities = columns;
      emit(GetColumnsState(baseResponse: BaseResponse.success(columns)));
    } catch (e) {
      emit(GetColumnsState(baseResponse: BaseResponse.error(e.toString())));
    }
  }

  void createColumn(CreateColumnDto createColumnDto) async {
    try {
      emit(CreateColumnState(baseResponse: BaseResponse.loading()));
      ColumnEntity column = await createColumnUsecase.execute(createColumnDto: createColumnDto);
      emit(CreateColumnState(baseResponse: BaseResponse.success(column)));
    } catch (e) {
      emit(CreateColumnState(baseResponse: BaseResponse.error(e.toString())));
    }
  }
}
