part of 'todo_bloc.dart';

sealed class TodoEvent extends Equatable {
  const TodoEvent();

  @override
  List<Object> get props => [];
}

class AddTodo extends TodoEvent {
  final ParamAdd param;

  const AddTodo({required this.param});
  @override
  List<Object> get props => [param];
}

class GetTodo extends TodoEvent {}

class RemoveTodo extends TodoEvent {
  final ParamRemove param;

  const RemoveTodo({required this.param});
  @override
  List<Object> get props => [param];
}

class UpdateTodo extends TodoEvent {
  final ParamUpdate param;

  const UpdateTodo({required this.param});
  @override
  List<Object> get props => [param];
}
