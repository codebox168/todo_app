import 'package:equatable/equatable.dart';

abstract class Failure extends Equatable {
  final String code;
  final String message;

  const Failure({required this.code, this.message = 'Something when wrong'});

  @override
  List<Object?> get props => [code, message];
}

class UnknowFailure extends Failure {
  const UnknowFailure({required super.code});
}

class ModelFailure extends Failure {
  const ModelFailure({required super.code});
}

class DBServiceFailure extends Failure {
  const DBServiceFailure({required super.code});
}

class TodoExistFailure extends Failure {
  const TodoExistFailure({required super.code, super.message});
}
