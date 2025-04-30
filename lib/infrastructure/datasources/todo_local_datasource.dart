import 'package:hive/hive.dart';
import 'package:simple_todo_app/infrastructure/models/todo_model.dart';

/// Local data source using Hive for persistent Todo storage.
class TodoLocalDatasource {
  static const String _boxName = 'todos';

  /// Returns the opened Hive box for TodoModel.
  Future<Box<TodoModel>> _getBox() async {
    return await Hive.openBox<TodoModel>(_boxName);
  }

  /// Returns all saved Todos.
  Future<List<TodoModel>> getAllTodos() async {
    final box = await _getBox();
    return box.values.toList();
  }

  /// Saves a new Todo.
  Future<void> addTodo(TodoModel todo) async {
    final box = await _getBox();
    await box.put(todo.id, todo);
  }

  /// Deletes a Todo by ID.
  Future<void> deleteTodo(String id) async {
    final box = await _getBox();
    await box.delete(id);
  }

  /// Deletes all Todos.
  Future<void> deleteAllTodos() async {
    final box = await _getBox();
    await box.clear();
  }

  /// Deletes all completed Todos.
  Future<void> deleteCompletedTodos() async {
    final box = await _getBox();
    final keysToDelete = box.values.where((todo) => todo.isCompleted).map((todo) => todo.id).toList();

    await box.deleteAll(keysToDelete);
  }

  /// Toggles the completed status of a Todo.
  Future<void> toggleComplete(String id) async {
    final box = await _getBox();
    final todo = box.get(id);
    if (todo != null) {
      final updated = TodoModel(id: todo.id, title: todo.title, isCompleted: !todo.isCompleted);
      await box.put(id, updated);
    }
  }
}
