import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo_app/src/features/todo/presentation/bloc/todo_bloc.dart';
import 'package:todo_app/src/features/todo/presentation/widgets/add_todo_dialog_widget.dart';
import 'package:todo_app/src/features/todo/presentation/widgets/todo_item_widget.dart';

class TodoPage extends StatelessWidget {
  const TodoPage({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Todo App for Vtech'),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          showDialog(
            context: context,
            builder: (BuildContext context) {
              return const AddTodoDialogWidget();
            },
          );
        },
        child: const Icon(Icons.add),
      ),
      body: BlocBuilder<TodoBloc, TodoState>(
        buildWhen: (previous, current) => current.runtimeType != TodoError,
        builder: (context, state) {
          return state.todos.isEmpty
              ? const Center(child: Text('No todo found!'))
              : ListView.builder(
                  itemCount: state.todos.length,
                  itemBuilder: (context, index) {
                    return TodoItemWidget(
                      todo: state.todos.elementAt(index),
                    );
                  },
                );
        },
      ),
    );
  }
}
