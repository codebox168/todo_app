import 'package:dartz/dartz.dart';
import 'package:todo_app/src/core/errors/failures.dart';

abstract class Usecase<Param, ReturnType> {
  Future<Either<Failure, ReturnType>> call({required Param param});
}
