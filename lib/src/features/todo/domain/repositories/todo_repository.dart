import 'package:dartz/dartz.dart';

import '../../../../core/errors/failures.dart';
import '../params/param_get.dart';
import '../params/param_add.dart';
import '../params/param_remove.dart';
import '../params/param_update.dart';
import '../../domain/entities/todo_entity.dart';

abstract class TodoRepository {
  Future<Either<Failure, Set<TodoEntity>>> get({
    required ParamGet param,
  });

  Future<Either<Failure, Set<TodoEntity>>> add({
    required ParamAdd param,
  });

  Future<Either<Failure, Set<TodoEntity>>> remove({
    required ParamRemove param,
  });

  Future<Either<Failure, Set<TodoEntity>>> update({
    required ParamUpdate param,
  });
}
