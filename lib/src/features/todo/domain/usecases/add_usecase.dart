import 'package:dartz/dartz.dart';
import '../../../../core/errors/failures.dart';
import '../../../../core/usecase/usecase.dart';
import '../entities/todo_entity.dart';
import '../params/param_add.dart';
import '../repositories/todo_repository.dart';

class AddUsecase implements Usecase<ParamAdd, Set<TodoEntity>> {
  final TodoRepository _todoRepository;

  AddUsecase({required TodoRepository todoRepository})
      : _todoRepository = todoRepository;

  @override
  Future<Either<Failure, Set<TodoEntity>>> call({required ParamAdd param}) {
    return _todoRepository.add(param: param);
  }
}
