import 'package:task_manager_app/features/kanban/data/dto/create_column_dto.dart';
import 'package:task_manager_app/features/kanban/domain/entities/column.dart';

abstract class ColumnRepository {
  Future<List<ColumnEntity>> getColumns();
  Future<void> createColumn(CreateColumnDto createColumnDto);
}
