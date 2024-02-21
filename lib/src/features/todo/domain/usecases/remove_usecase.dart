import 'package:dartz/dartz.dart';
import '../../../../core/errors/failures.dart';
import '../../../../core/usecase/usecase.dart';
import '../entities/todo_entity.dart';
import '../params/param_remove.dart';
import '../repositories/todo_repository.dart';

class RemoveUsecase implements Usecase<ParamRemove, Set<TodoEntity>> {
  final TodoRepository _todoRepository;

  RemoveUsecase({required TodoRepository todoRepository})
      : _todoRepository = todoRepository;

  @override
  Future<Either<Failure, Set<TodoEntity>>> call({required ParamRemove param}) {
    return _todoRepository.remove(param: param);
  }
}
