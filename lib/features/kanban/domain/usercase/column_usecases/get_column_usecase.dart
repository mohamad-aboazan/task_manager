import 'package:task_manager_app/features/kanban/domain/entities/column.dart';
import 'package:task_manager_app/features/kanban/domain/repository/column_repository.dart';

class GetColumnsUsecase {
  final ColumnRepository repository;

  GetColumnsUsecase({required this.repository});

  Future<List<ColumnEntity>> execute() async {
    return await repository.getColumns();
  }
}
