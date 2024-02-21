import 'package:dartz/dartz.dart';

import '../../../../core/errors/failures.dart';
import '../../../../core/errors/exceptions.dart';
import '../../domain/entities/todo_entity.dart';
import '../../domain/repositories/todo_repository.dart';
import '../datasources/todo_local_datasource.dart';
import '../../domain/params/param_get.dart';
import '../../domain/params/param_add.dart';
import '../../domain/params/param_remove.dart';
import '../../domain/params/param_update.dart';

class TodoRepositoryImpl implements TodoRepository {
  final TodoLocalDatasource _todoLocalDatasource;

  TodoRepositoryImpl({
    required TodoLocalDatasource todoLocalDatasource,
  }) : _todoLocalDatasource = todoLocalDatasource;

  @override
  Future<Either<Failure, Set<TodoEntity>>> get({
    required ParamGet param,
  }) async {
    try {
      final result = await _todoLocalDatasource.get(param: param);
      return Right(result);
    } on AppException catch (e) {
      return Left(e.toFailure());
    } catch (e) {
      return Left(
        UnknowException(
          message: "TodoRepository Error: $e",
        ).toFailure(),
      );
    }
  }

  @override
  Future<Either<Failure, Set<TodoEntity>>> add({
    required ParamAdd param,
  }) async {
    try {
      final result = await _todoLocalDatasource.add(param: param);
      return Right(result);
    } on AppException catch (e) {
      return Left(e.toFailure());
    } catch (e) {
      return Left(
        UnknowException(
          message: "TodoRepository Error: $e",
        ).toFailure(),
      );
    }
  }

  @override
  Future<Either<Failure, Set<TodoEntity>>> remove({
    required ParamRemove param,
  }) async {
    try {
      final result = await _todoLocalDatasource.remove(param: param);
      return Right(result);
    } on AppException catch (e) {
      return Left(e.toFailure());
    } catch (e) {
      return Left(
        UnknowException(
          message: "TodoRepository Error: $e",
        ).toFailure(),
      );
    }
  }

  @override
  Future<Either<Failure, Set<TodoEntity>>> update({
    required ParamUpdate param,
  }) async {
    try {
      final result = await _todoLocalDatasource.update(param: param);
      return Right(result);
    } on AppException catch (e) {
      return Left(e.toFailure());
    } catch (e) {
      return Left(
        UnknowException(
          message: "TodoRepository Error: $e",
        ).toFailure(),
      );
    }
  }
}
