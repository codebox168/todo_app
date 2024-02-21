import 'package:dartz/dartz.dart';
import '../../../../core/errors/failures.dart';
import '../../../../core/usecase/usecase.dart';
import '../entities/todo_entity.dart';
import '../params/param_get.dart';
import '../repositories/todo_repository.dart';

class GetUsecase implements Usecase<ParamGet, Set<TodoEntity>> {
  final TodoRepository _todoRepository;

  GetUsecase({required TodoRepository todoRepository})
      : _todoRepository = todoRepository;

  @override
  Future<Either<Failure, Set<TodoEntity>>> call({required ParamGet param}) {
    return _todoRepository.get(param: param);
  }
}
