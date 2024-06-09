
import 'package:task_manager_app/core/services/api_service.dart';
import 'package:task_manager_app/core/utils/endpoints.dart';
import 'package:task_manager_app/features/kanban/data/dto/create_column_dto.dart';
import 'package:task_manager_app/features/kanban/domain/entities/column.dart';

abstract class ColumnRemoteDataSource {
  Future<List<ColumnEntity>> getColumns();
  Future<ColumnEntity> createColumn(CreateColumnDto createColumnDto);
}

class ColumnRemoteDataSourceImp implements ColumnRemoteDataSource {
  final ApiService apiService;
  ColumnRemoteDataSourceImp({required this.apiService});

  @override
  Future<ColumnEntity> createColumn(CreateColumnDto createColumnDto) async {
    var responseData = await apiService.post(Endpoints.Labels, createColumnDto.toJson());
    ColumnEntity column = ColumnEntity.fromJson(responseData);
    return column;
  }

  @override
  Future<List<ColumnEntity>> getColumns() async {
    var responseData = await apiService.get(Endpoints.Labels);
    List<ColumnEntity> columns = responseData.map((e) => ColumnEntity.fromJson(e)).toList().cast<ColumnEntity>();
    return columns;
  }
}
