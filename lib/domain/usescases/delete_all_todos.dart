import 'package:fpdart/fpdart.dart';
import 'package:simple_todo_app/domain/repositories/todo_repository.dart';

/// Use case for deleting all stored Todos.
class DeleteDodo {
  final TodoRepository repository;

  DeleteDodo({required this.repository});

  /// Deletes all Todos from the repository.
  ///
  /// Returns [Right<void>] on success, or [Left<Exception>] on failure.
  Future<Either<Exception, void>> call() {
    return repository.deleteAllTodos();
  }
}
