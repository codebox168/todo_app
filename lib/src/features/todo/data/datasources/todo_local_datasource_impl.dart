import 'package:todo_app/src/core/errors/exceptions.dart';
import 'package:todo_app/src/core/utils/database_service.dart';
import 'package:todo_app/src/features/todo/domain/params/param_add.dart';
import 'package:todo_app/src/features/todo/domain/params/param_get.dart';
import 'package:todo_app/src/features/todo/domain/params/param_remove.dart';
import 'package:todo_app/src/features/todo/domain/params/param_update.dart';

import '../models/todo_model.dart';
import 'todo_local_datasource.dart';

class TodoLocalDatasourceImpl implements TodoLocalDatasource {
  final DatabaseService _db;
  TodoLocalDatasourceImpl({
    required DatabaseService db,
  }) : _db = db;

  @override
  Future<Set<TodoModel>> add({required ParamAdd param}) async {
    try {
      if ((await _db.findOne(
        table: 'todos',
        where: "title = ?",
        whereArgs: [param.title],
      ))
          .isNotEmpty) {
        throw const TodoExistException();
      }
      Set<TodoModel> todos = {};
      await _db.insert(
        table: 'todos',
        values: {'title': param.title, 'status': 'pending'},
      );
      final result = await _db.query(
        table: 'todos',
        columns: ['id', 'title', 'status'],
        orderBy: 'id',
      );
      for (var rawTodos in result) {
        todos.add(TodoModel.fromJson(rawTodos));
      }
      return todos;
    } on AppException {
      rethrow;
    } catch (e) {
      throw UnknowException(
        message: e.toString(),
      );
    }
  }

  @override
  Future<Set<TodoModel>> get({required ParamGet param}) async {
    try {
      Set<TodoModel> todos = {};
      final result = await _db.query(
        table: 'todos',
        columns: ['id', 'title', 'status'],
        orderBy: 'id',
      );

      for (var rawTodos in result) {
        todos.add(TodoModel.fromJson(rawTodos));
      }
      return todos;
    } on AppException {
      rethrow;
    } catch (e) {
      throw UnknowException(
        message: e.toString(),
      );
    }
  }

  @override
  Future<Set<TodoModel>> remove({required ParamRemove param}) async {
    try {
      Set<TodoModel> todos = {};
      await _db.delete(
        table: 'todos',
        where: "id = ?",
        whereArgs: [param.id],
      );
      final result = await _db.query(
        table: 'todos',
        columns: ['id', 'title', 'status'],
        orderBy: 'id',
      );
      for (var rawTodos in result) {
        todos.add(TodoModel.fromJson(rawTodos));
      }
      return todos;
    } on AppException {
      rethrow;
    } catch (e) {
      throw UnknowException(
        message: e.toString(),
      );
    }
  }

  @override
  Future<Set<TodoModel>> update({required ParamUpdate param}) async {
    try {
      if ((await _db.findOne(
        table: 'todos',
        where: "title = ? AND id != ?",
        whereArgs: [param.title, param.id],
      ))
          .isNotEmpty) {
        throw const TodoExistException();
      }
      Set<TodoModel> todos = {};
      await _db.update(
        table: 'todos',
        values: {'title': param.title, 'status': param.status},
        where: 'id = ?',
        whereArgs: [param.id],
      );
      final result = await _db.query(
        table: 'todos',
        columns: ['id', 'title', 'status'],
        orderBy: 'id',
      );
      for (var rawTodos in result) {
        todos.add(TodoModel.fromJson(rawTodos));
      }
      return todos;
    } on AppException {
      rethrow;
    } catch (e) {
      throw UnknowException(
        message: e.toString(),
      );
    }
  }
}
