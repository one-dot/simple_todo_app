import 'package:fpdart/fpdart.dart';
import 'package:simple_todo_app/core/todo_failure.dart';
import 'package:simple_todo_app/domain/entities/todo.dart';
import 'package:simple_todo_app/domain/repositories/todo_repository.dart';

/// Use case for adding a new Todo item
class AddTodo {
  final TodoRepository repository;

  AddTodo({required this.repository});

  /// Adds the given [todo] to the repository.
  ///
  /// Returns [Right<void>] on success, or [Left<Exception>] if an error occurs.
  Future<Either<TodoFailure, void>> call(Todo todo) {
    return repository.addTodo(todo);
  }
}
