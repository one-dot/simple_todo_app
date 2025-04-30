// https://pub.dev/documentation/hive/latest/
// https://www.youtube.com/watch?v=xN_OTO5EYKY
// command: flutter pub run build_runner build

import 'package:hive/hive.dart';
import 'package:simple_todo_app/domain/entities/todo.dart';

part 'todo_model.g.dart';

/// Hive model representing a Todo item for local storage.
@HiveType(typeId: 0)
class TodoModel extends HiveObject {
  @HiveField(0)
  final String id;

  @HiveField(1)
  final String title;

  @HiveField(2)
  final bool isCompleted;

  TodoModel({required this.id, required this.title, required this.isCompleted});

  /// Converts a domain [Todo] entity into a [TodoModel].
  factory TodoModel.fromEntity(Todo todo) {
    return TodoModel(id: todo.id, title: todo.title, isCompleted: todo.isCompleted);
  }

  /// Converts this [TodoModel] into a domain [Todo] entity.
  Todo toEntity() {
    return Todo(id: id, title: title, isCompleted: isCompleted);
  }
}
