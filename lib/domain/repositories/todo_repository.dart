import 'package:fpdart/fpdart.dart';
import 'package:simple_todo_app/core/todo_failure.dart';
import 'package:simple_todo_app/domain/entities/todo.dart';

abstract class TodoRepository {
  Future<Either<TodoFailure, List<Todo>>> getAllTodos();
  Future<Either<TodoFailure, void>> addTodo(Todo todo);
  Future<Either<TodoFailure, void>> deleteTodo(String id);
  Future<Either<TodoFailure, void>> deleteAllTodos();
  Future<Either<TodoFailure, void>> deleteCompletedTodos();
  Future<Either<TodoFailure, void>> toggleCompleteTodo(String id);
}
