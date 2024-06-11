import 'package:task_manager_app/core/network/network_info.dart';
import 'package:task_manager_app/features/kanban/data/datasources/remote/column_remote_data_source.dart';
import 'package:task_manager_app/features/kanban/data/dto/create_column_dto.dart';
import 'package:task_manager_app/features/kanban/domain/entities/column.dart';
import 'package:task_manager_app/features/kanban/domain/repository/column_repository.dart';

/// =================================================================================================
/// Implementation of the column repository.
///
/// This repository implements the `ColumnRepository` interface and interacts with the remote data
/// source (`ColumnRemoteDataSource`) to perform column-related operations.
///
/// Dependencies:
///   - `NetworkInfo`: Utility class for checking network connectivity.
///   - `ColumnRemoteDataSource`: Remote data source for column-related operations.
///
/// Abstract Methods Implemented:
///   - `createColumn`: Creates a new column by delegating the task to the remote data source.
///   - `getColumns`: Retrieves a list of columns by delegating the task to the remote data source.
///
/// Usage:
///   - Implement the `ColumnRepository` interface with required methods.
///   - Inject dependencies such as `NetworkInfo` and `ColumnRemoteDataSource` into the repository.
///   - Utilize the repository methods to interact with column data.
///
/// =================================================================================================

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
