import 'package:fpdart/fpdart.dart';
import 'package:simple_todo_app/domain/repositories/todo_repository.dart';

/// Use case for deleting all completed Todos.
class DeleteCompletedTodos {
  final TodoRepository repository;

  DeleteCompletedTodos({required this.repository});

  /// Deletes all Todos that are marked as completed.
  ///
  /// Returns [Right<void>] on success, or [Left<Exception>] on failure.
  Future<Either<Exception, void>> call() {
    return repository.deleteCompletedTodos();
  }
}
