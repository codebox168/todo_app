import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo_app/src/features/todo/domain/entities/todo_entity.dart';
import 'package:todo_app/src/features/todo/domain/params/param_remove.dart';
import 'package:todo_app/src/features/todo/domain/params/param_update.dart';
import 'package:todo_app/src/features/todo/presentation/bloc/todo_bloc.dart';
import 'package:todo_app/src/features/todo/presentation/widgets/update_todo_dialog_widget.dart';

class TodoItemWidget extends StatelessWidget {
  const TodoItemWidget({super.key, required this.todo});
  final TodoEntity todo;
  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(
        todo.title,
        style: TextStyle(
          decoration: todo.status == 'pending'
              ? TextDecoration.none
              : TextDecoration.lineThrough,
        ),
      ),
      trailing: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          IconButton(
            onPressed: () {
              context.read<TodoBloc>().add(
                    UpdateTodo(
                      param: ParamUpdate(
                        id: todo.id,
                        title: todo.title,
                        status: todo.status == 'completed'
                            ? 'pending'
                            : 'completed',
                      ),
                    ),
                  );
            },
            icon: Icon(
              todo.status == 'completed'
                  ? Icons.check_box
                  : Icons.check_box_outline_blank,
            ),
          ),
          IconButton(
            onPressed: () {
              showDialog(
                context: context,
                builder: (BuildContext context) {
                  return UpdateTodoDialogWidget(
                    todoEntity: todo,
                  );
                },
              );
            },
            icon: const Icon(Icons.edit),
          ),
          IconButton(
            onPressed: () {
              context
                  .read<TodoBloc>()
                  .add(RemoveTodo(param: ParamRemove(id: todo.id)));
            },
            icon: const Icon(Icons.delete),
          ),
        ],
      ),
    );
  }
}
