import 'package:fpdart/fpdart.dart';
import 'package:simple_todo_app/domain/entities/todo.dart';
import 'package:simple_todo_app/domain/repositories/todo_repository.dart';
import 'package:simple_todo_app/infrastructure/datasources/todo_local_datasource.dart';
import 'package:simple_todo_app/infrastructure/models/todo_model.dart';

/// Concrete implementation of [TodoRepository] using Hive as local storage.
class TodoRepositoryImpl implements TodoRepository {
  final TodoLocalDatasource localDatasource;

  TodoRepositoryImpl(this.localDatasource);

  @override
  Future<Either<Exception, List<Todo>>> getAllTodos() async {
    try {
      final models = await localDatasource.getAllTodos();
      final todos = models.map((e) => e.toEntity()).toList();
      return Right(todos);
    } catch (e) {
      return Left(Exception('Failed to load todos: $e'));
    }
  }

  @override
  Future<Either<Exception, void>> addTodo(Todo todo) async {
    try {
      final model = TodoModel.fromEntity(todo);
      await localDatasource.addTodo(model);
      return const Right(null);
    } catch (e) {
      return Left(Exception('Failed to add todo: $e'));
    }
  }

  @override
  Future<Either<Exception, void>> deleteTodo(String id) async {
    try {
      await localDatasource.deleteTodo(id);
      return const Right(null);
    } catch (e) {
      return Left(Exception('Failed to delete todo: $e'));
    }
  }

  @override
  Future<Either<Exception, void>> deleteAllTodos() async {
    try {
      await localDatasource.deleteAllTodos();
      return const Right(null);
    } catch (e) {
      return Left(Exception('Failed to delete all todos: $e'));
    }
  }

  @override
  Future<Either<Exception, void>> deleteCompletedTodos() async {
    try {
      await localDatasource.deleteCompletedTodos();
      return const Right(null);
    } catch (e) {
      return Left(Exception('Failed to delete completed todos: $e'));
    }
  }

  @override
  Future<Either<Exception, void>> toggleCompleteTodo(String id) async {
    try {
      await localDatasource.toggleComplete(id);
      return const Right(null);
    } catch (e) {
      return Left(Exception('Failed to toggle complete: $e'));
    }
  }
}
