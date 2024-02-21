part of 'todo_bloc.dart';

sealed class TodoState extends Equatable {
  final Set<TodoEntity> todos;

  const TodoState({required this.todos});

  @override
  List<Object> get props => [];
}

class TodoInitial extends TodoState {
  const TodoInitial({super.todos = const {}});
}

class TodoLoading extends TodoState {
  const TodoLoading({super.todos = const {}});
}

class TodoLoaded extends TodoState {
  const TodoLoaded({required super.todos});
}

class TodoError extends TodoState {
  final Failure failure;

  const TodoError({required this.failure, super.todos = const {}});
  @override
  List<Object> get props => [failure];
}
