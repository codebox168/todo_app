import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo_app/src/features/todo/presentation/bloc/todo_bloc.dart';
import 'package:todo_app/src/features/todo/presentation/pages/todo_page.dart';
import 'package:todo_app/src/locator.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await setup();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider<TodoBloc>(
      create: (context) => getIt<TodoBloc>()..add(GetTodo()),
      child: const MaterialApp(
        home: TodoPage(),
      ),
    );
  }
}
