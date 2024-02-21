import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo_app/src/features/todo/domain/entities/todo_entity.dart';
import 'package:todo_app/src/features/todo/domain/params/param_update.dart';
import 'package:todo_app/src/features/todo/presentation/bloc/todo_bloc.dart';
import 'package:todo_app/src/locator.dart';

class UpdateTodoDialogWidget extends StatefulWidget {
  final TodoEntity todoEntity;
  const UpdateTodoDialogWidget({super.key, required this.todoEntity});

  @override
  State<UpdateTodoDialogWidget> createState() => _UpdateTodoDialogWidgetState();
}

class _UpdateTodoDialogWidgetState extends State<UpdateTodoDialogWidget> {
  final TextEditingController _todoTextEditingController =
      TextEditingController();
  String errorMsg = '';
  @override
  void initState() {
    _todoTextEditingController.text = widget.todoEntity.title;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('Update Todo'),
      content: BlocListener<TodoBloc, TodoState>(
        bloc: getIt<TodoBloc>(),
        listener: (BuildContext context, state) {
          if (state is TodoError) {
            setState(() {
              errorMsg = state.failure.message;
            });
          } else if (state is TodoLoaded) {
            Navigator.pop(context);
          }
        },
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextField(
              controller: _todoTextEditingController,
              autocorrect: false,
              autofocus: true,
              decoration: InputDecoration(
                hintText: 'Enter your todo',
                errorText: errorMsg,
              ),
              onEditingComplete: () {
                if (_todoTextEditingController.text == '') {
                  setState(() {
                    errorMsg = 'Please enter your todo';
                  });
                } else if (_todoTextEditingController.text ==
                    widget.todoEntity.title) {
                  Navigator.pop(context);
                } else {
                  context.read<TodoBloc>().add(
                        UpdateTodo(
                          param: ParamUpdate(
                            id: widget.todoEntity.id,
                            title: _todoTextEditingController.text,
                            status: widget.todoEntity.status,
                          ),
                        ),
                      );
                }
              },
            )
          ],
        ),
      ),
    );
  }
}
