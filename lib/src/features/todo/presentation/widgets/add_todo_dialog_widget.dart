import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo_app/src/features/todo/domain/params/param_add.dart';
import 'package:todo_app/src/features/todo/presentation/bloc/todo_bloc.dart';
import 'package:todo_app/src/locator.dart';

class AddTodoDialogWidget extends StatefulWidget {
  const AddTodoDialogWidget({super.key});

  @override
  State<AddTodoDialogWidget> createState() => _AddTodoDialogWidgetState();
}

class _AddTodoDialogWidgetState extends State<AddTodoDialogWidget> {
  final TextEditingController _todoTextEditingController =
      TextEditingController();

  String errorMsg = '';

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('Add Todo'),
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
                } else {
                  context.read<TodoBloc>().add(AddTodo(
                      param: ParamAdd(title: _todoTextEditingController.text)));
                }
              },
            )
          ],
        ),
      ),
    );
  }
}
