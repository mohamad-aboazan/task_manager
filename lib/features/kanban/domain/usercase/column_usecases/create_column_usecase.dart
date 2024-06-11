import 'package:task_manager_app/features/kanban/data/dto/create_column_dto.dart';
import 'package:task_manager_app/features/kanban/domain/repository/column_repository.dart';

/// =========================================================================================================
/// Use case for creating a column.
///
/// This use case handles the creation of a column by interacting with the column repository.
///
/// Dependencies:
///   - `ColumnRepository`: Repository for managing column data.
///
/// Usage:
///   - Instantiate `CreateColumnUsecase` with the required repository dependency.
///   - Call the `execute` method and pass the `CreateColumnDto` parameter to create a column.
///
///=========================================================================================================

class CreateColumnUsecase {
  final ColumnRepository repository;

  CreateColumnUsecase({required this.repository});

  Future execute({required CreateColumnDto createColumnDto}) async {
    return await repository.createColumn(createColumnDto);
  }
}
