import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:todo_app/src/core/errors/failures.dart';
import 'package:todo_app/src/features/todo/domain/entities/todo_entity.dart';
import 'package:todo_app/src/features/todo/domain/params/param_add.dart';
import 'package:todo_app/src/features/todo/domain/params/param_get.dart';
import 'package:todo_app/src/features/todo/domain/params/param_remove.dart';
import 'package:todo_app/src/features/todo/domain/params/param_update.dart';
import 'package:todo_app/src/features/todo/domain/usecases/add_usecase.dart';
import 'package:todo_app/src/features/todo/domain/usecases/get_usecase.dart';
import 'package:todo_app/src/features/todo/domain/usecases/remove_usecase.dart';
import 'package:todo_app/src/features/todo/domain/usecases/update_usecase.dart';

part 'todo_event.dart';
part 'todo_state.dart';

class TodoBloc extends Bloc<TodoEvent, TodoState> {
  final AddUsecase _addUsecase;
  final GetUsecase _getUsecase;
  final RemoveUsecase _removeUsecase;
  final UpdateUsecase _updateUsecase;

  TodoBloc({
    required AddUsecase addUsecase,
    required GetUsecase getUsecase,
    required RemoveUsecase removeUsecase,
    required UpdateUsecase updateUsecase,
  })  : _addUsecase = addUsecase,
        _getUsecase = getUsecase,
        _removeUsecase = removeUsecase,
        _updateUsecase = updateUsecase,
        super(const TodoInitial()) {
    on<GetTodo>((event, emit) async {
      emit(TodoLoading(todos: state.todos));
      final result = await _getUsecase(param: const ParamGet());
      result.fold(
        (Failure failure) {
          return emit(TodoError(failure: failure, todos: state.todos));
        },
        (Set<TodoEntity> todos) {
          return emit(TodoLoaded(todos: todos));
        },
      );
    });
    on<AddTodo>((event, emit) async {
      emit(TodoLoading(todos: state.todos));
      final result = await _addUsecase(param: event.param);
      result.fold(
        (Failure failure) {
          return emit(TodoError(failure: failure, todos: state.todos));
        },
        (Set<TodoEntity> todos) {
          return emit(TodoLoaded(todos: todos));
        },
      );
    });
    on<UpdateTodo>((event, emit) async {
      emit(TodoLoading(todos: state.todos));
      final result = await _updateUsecase(param: event.param);
      result.fold(
        (Failure failure) {
          return emit(TodoError(failure: failure, todos: state.todos));
        },
        (Set<TodoEntity> todos) {
          return emit(TodoLoaded(todos: todos));
        },
      );
    });

    on<RemoveTodo>((event, emit) async {
      emit(TodoLoading(todos: state.todos));
      final result = await _removeUsecase(param: event.param);
      result.fold(
        (Failure failure) {
          return emit(TodoError(failure: failure, todos: state.todos));
        },
        (Set<TodoEntity> todos) {
          return emit(TodoLoaded(todos: todos));
        },
      );
    });
  }
}
