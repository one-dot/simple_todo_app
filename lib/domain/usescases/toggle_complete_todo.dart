import 'package:fpdart/fpdart.dart';
import 'package:simple_todo_app/core/todo_failure.dart';
import 'package:simple_todo_app/domain/repositories/todo_repository.dart';

/// Use case for toggling the completion state of a specific Todo.
class ToggleCompleteTodo {
  final TodoRepository repository;

  ToggleCompleteTodo({required this.repository});

  /// Toggles the completed status of the Todo with the given [id].
  ///
  /// Returns [Right<void>] on success, or [Left<Exception>] on failure.
  Future<Either<TodoFailure, void>> call(String id) {
    return repository.toggleCompleteTodo(id);
  }
}
