import 'package:todo_app/src/core/errors/exceptions.dart';

import '../../domain/entities/todo_entity.dart';

class TodoModel extends TodoEntity {
  const TodoModel({
    required super.title,
    required super.status,
    required super.id,
  });

  factory TodoModel.fromJson(Map<String, dynamic> json) {
    try {
      return TodoModel(
        title: json['title'],
        status: json['status'],
        id: json['id'],
      );
    } catch (e) {
      throw ModelException(message: 'TodoModel Error: $e');
    }
  }
}
