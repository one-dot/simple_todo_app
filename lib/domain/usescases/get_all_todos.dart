import 'package:fpdart/fpdart.dart';
import 'package:simple_todo_app/domain/entities/todo.dart';
import 'package:simple_todo_app/domain/repositories/todo_repository.dart';

class GetAllTodos {
  final TodoRepository repository;

  /// Use case for retrieving all saved Todos.
  GetAllTodos({required this.repository});

  /// Returns a list of all Todos from the repository.
  ///
  /// Returns [Right<List<Todo>>] on success, or [Left<Exception>] on failure.
  Future<Either<Exception, List<Todo>>> call() {
    return repository.getAllTodos();
  }
}
