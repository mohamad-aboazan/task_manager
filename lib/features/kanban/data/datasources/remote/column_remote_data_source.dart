import 'package:task_manager_app/core/services/api_service.dart';
import 'package:task_manager_app/core/utils/endpoints.dart';
import 'package:task_manager_app/features/kanban/data/dto/create_column_dto.dart';
import 'package:task_manager_app/features/kanban/domain/entities/column.dart';

/// =========================================================================================================
/// Remote data source for managing columns.
///
/// This data source handles operations related to columns through remote API calls using the `ApiService`.
///
/// Dependencies:
///   - `ApiService`: Service for making API calls.
///   - `Endpoints`: Utility class for defining API endpoints.
///
/// Abstract Methods:
///   - `getColumns`: Fetches columns from the remote API.
///   - `createColumn`: Creates a new column via the remote API.
///
/// Usage:
///   - Implement the `ColumnRemoteDataSource` abstract class with the required methods.
///   - Utilize `ApiService` to make HTTP requests to the appropriate endpoints for column management.
///
///=========================================================================================================

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
