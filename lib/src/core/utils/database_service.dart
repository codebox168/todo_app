import 'package:sqflite/sqflite.dart';
import 'package:todo_app/src/core/errors/exceptions.dart';

abstract class DatabaseService {
  Future<void> initialize();
  Future<List<Map<String, Object?>>> query({
    required String table,
    List<String>? columns,
    String? orderBy,
  });

  Future<List<Map<String, Object?>>> findOne({
    required String table,
    List<String>? columns,
    String? where,
    List<Object?>? whereArgs,
  });

  Future<void> insert({
    required String table,
    required Map<String, Object?> values,
  });
  Future<void> update({
    required String table,
    required Map<String, Object?> values,
    String? where,
    List<Object?>? whereArgs,
  });
  Future<void> delete({
    required String table,
    String? where,
    List<Object?>? whereArgs,
  });
}

class DatabaseServiceImpl implements DatabaseService {
  Database? _database;
  @override
  Future<void> initialize() async {
    try {
      final databasesPath = await getDatabasesPath();
      String path = '$databasesPath/todo.db';
      _database = await openDatabase(
        path,
        version: 1,
        onCreate: (Database db, int version) async {
          await db.execute(
              'CREATE TABLE todos (id INTEGER PRIMARY KEY, title TEXT, status TEXT)');
        },
      );
    } catch (e) {
      throw DBServiceException(message: 'Db initialize error: $e');
    }
  }

  @override
  Future<void> delete({
    required String table,
    String? where,
    List<Object?>? whereArgs,
  }) async {
    try {
      await _database?.delete(
        table,
        where: where,
        whereArgs: whereArgs,
      );
    } catch (e) {
      throw DBServiceException(message: 'Db delete error: $e');
    }
  }

  @override
  Future<List<Map<String, Object?>>> query({
    required String table,
    List<String>? columns,
    String? orderBy,
  }) async {
    try {
      final result = await _database?.query(
        table,
        columns: columns,
        orderBy: orderBy,
      );
      return result ?? [];
    } catch (e) {
      throw DBServiceException(message: 'Db query error: $e');
    }
  }

  @override
  Future<void> insert({
    required String table,
    required Map<String, Object?> values,
  }) async {
    try {
      await _database?.insert(
        table,
        values,
      );
    } catch (e) {
      throw DBServiceException(message: 'Db insert error: $e');
    }
  }

  @override
  Future<void> update({
    required String table,
    required Map<String, Object?> values,
    String? where,
    List<Object?>? whereArgs,
  }) async {
    try {
      await _database?.update(
        table,
        values,
        where: where,
        whereArgs: whereArgs,
      );
    } catch (e) {
      throw DBServiceException(message: 'Db update error: $e');
    }
  }

  @override
  Future<List<Map<String, Object?>>> findOne({
    required String table,
    List<String>? columns,
    String? where,
    List<Object?>? whereArgs,
  }) async {
    try {
      final result = await _database?.query(
        table,
        columns: columns,
        where: where,
        whereArgs: whereArgs,
        limit: 1,
      );
      return result ?? [];
    } catch (e) {
      throw DBServiceException(message: 'Db findOne error: $e');
    }
  }
}
