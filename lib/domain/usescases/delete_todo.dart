import 'package:fpdart/fpdart.dart';
import 'package:simple_todo_app/core/todo_failure.dart';
import 'package:simple_todo_app/domain/repositories/todo_repository.dart';

/// Use case for deleting a single Todo by its ID.
class DeleteTodo {
  final TodoRepository repository;

  DeleteTodo({required this.repository});

  /// Deletes the Todo with the given [id].
  ///
  /// Returns [Right<void>] on success, or [Left<Exception>] on failure.
  Future<Either<TodoFailure, void>> call(String id) {
    return repository.deleteTodo(id);
  }
}
