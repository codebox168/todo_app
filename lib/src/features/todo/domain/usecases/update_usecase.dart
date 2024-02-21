import 'package:dartz/dartz.dart';
import '../../../../core/errors/failures.dart';
import '../../../../core/usecase/usecase.dart';
import '../entities/todo_entity.dart';
import '../params/param_update.dart';
import '../repositories/todo_repository.dart';

class UpdateUsecase implements Usecase<ParamUpdate, Set<TodoEntity>> {
  final TodoRepository _todoRepository;

  UpdateUsecase({required TodoRepository todoRepository})
      : _todoRepository = todoRepository;

  @override
  Future<Either<Failure, Set<TodoEntity>>> call({required ParamUpdate param}) {
    return _todoRepository.update(param: param);
  }
}
