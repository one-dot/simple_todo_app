import 'package:fpdart/fpdart.dart';
import 'package:simple_todo_app/domain/entities/todo.dart';

abstract class TodoRepository {
  Future<Either<Exception, List<Todo>>> getAllTodos();
  Future<Either<Exception, void>> addTodo(Todo todo);
  Future<Either<Exception, void>> deleteTodo(String id);
  Future<Either<Exception, void>> deleteAllTodos();
  Future<Either<Exception, void>> deleteCompletedTodos();
  Future<Either<Exception, void>> toggleCompleteTodo(String id);
}
