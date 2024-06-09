import 'package:task_manager_app/features/kanban/data/dto/create_column_dto.dart';
import 'package:task_manager_app/features/kanban/domain/repository/column_repository.dart';

class CreateColumnUsecase {
  final ColumnRepository repository;

  CreateColumnUsecase({required this.repository});

  Future execute({required CreateColumnDto createColumnDto}) async {
    return await repository.createColumn(createColumnDto);
  }
}
