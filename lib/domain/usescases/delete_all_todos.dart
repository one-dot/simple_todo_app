import 'package:fpdart/fpdart.dart';
import 'package:simple_todo_app/domain/repositories/todo_repository.dart';

/// Use case for deleting all stored Todos.
/// Use case for deleting all stored Todos.
class DeleteAllTodos {
  final TodoRepository repository;

  DeleteAllTodos({required this.repository});

  /// Deletes all Todos from the repository.
  ///
  /// Returns [Right<void>] on success, or [Left<Exception>] on failure.
  Future<Either<Exception, void>> call() {
    return repository.deleteAllTodos();
  }
}
