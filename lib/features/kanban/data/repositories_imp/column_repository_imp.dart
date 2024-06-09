import 'package:task_manager_app/core/network/network_info.dart';
import 'package:task_manager_app/features/kanban/data/datasources/remote/column_remote_data_source.dart';
import 'package:task_manager_app/features/kanban/data/dto/create_column_dto.dart';
import 'package:task_manager_app/features/kanban/domain/entities/column.dart';
import 'package:task_manager_app/features/kanban/domain/repository/column_repository.dart';

class ColumnRepositoryImpl implements ColumnRepository {
  final NetworkInfo networkInfo;
  final ColumnRemoteDataSource columnRemoteDataSource;

  ColumnRepositoryImpl({required this.columnRemoteDataSource, required this.networkInfo});

  @override
  Future<ColumnEntity> createColumn(CreateColumnDto createColumnDto) async {
    return await columnRemoteDataSource.createColumn(createColumnDto);
  }

  @override
  Future<List<ColumnEntity>> getColumns() async {
    return await columnRemoteDataSource.getColumns();
  }
}
