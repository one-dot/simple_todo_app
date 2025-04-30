import 'package:simple_todo_app/domain/entities/todo.dart';

abstract class TodoRepository {
  Future<List<Todo>> getAllTodos();
  Future<void> addTodo(Todo todo);
  Future<void> deleteTodo(String id);
  Future<void> deleteAllTodos();
  Future<void> deleteCompletedTodos();
  Future<void> toggleCompleteTodo(String id);
}
