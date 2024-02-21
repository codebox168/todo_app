import 'dart:developer';

import 'package:equatable/equatable.dart';
import 'package:todo_app/src/core/errors/failures.dart';

abstract class AppException extends Equatable {
  final String code;
  final String message;

  const AppException({required this.code, required this.message});

  Failure toFailure();

  @override
  List<Object?> get props => [code, message];
}

class UnknowException extends AppException {
  const UnknowException({super.code = "00", required super.message});

  @override
  Failure toFailure() {
    log("${super.code}: ${super.message}");
    return UnknowFailure(code: code);
  }
}

class ModelException extends AppException {
  const ModelException({super.code = "01", required super.message});

  @override
  Failure toFailure() {
    log("${super.code}: ${super.message}");
    return ModelFailure(code: code);
  }
}

class DBServiceException extends AppException {
  const DBServiceException({super.code = "02", required super.message});

  @override
  Failure toFailure() {
    log("${super.code}: ${super.message}");
    return DBServiceFailure(code: code);
  }
}

class TodoExistException extends AppException {
  const TodoExistException({
    super.code = "03",
    super.message = 'Todo is already exist.',
  });

  @override
  Failure toFailure() {
    return TodoExistFailure(code: code, message: message);
  }
}
