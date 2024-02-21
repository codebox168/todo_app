import 'package:todo_app/src/features/todo/domain/params/param_add.dart';
import 'package:todo_app/src/features/todo/domain/params/param_get.dart';
import 'package:todo_app/src/features/todo/domain/params/param_remove.dart';
import 'package:todo_app/src/features/todo/domain/params/param_update.dart';

import '../models/todo_model.dart';

abstract class TodoLocalDatasource {
  Future<Set<TodoModel>> get({
    required ParamGet param,
  });

  Future<Set<TodoModel>> add({
    required ParamAdd param,
  });

  Future<Set<TodoModel>> remove({
    required ParamRemove param,
  });

  Future<Set<TodoModel>> update({
    required ParamUpdate param,
  });
}
