import 'package:fpdart/fpdart.dart';
import 'package:simple_todo_app/core/todo_failure.dart';
import 'package:simple_todo_app/domain/entities/todo.dart';
import 'package:simple_todo_app/domain/repositories/todo_repository.dart';
import 'package:simple_todo_app/infrastructure/datasources/todo_local_datasource.dart';
import 'package:simple_todo_app/infrastructure/models/todo_model.dart';

/// Concrete implementation of [TodoRepository] using Hive as local storage.
class TodoRepositoryImpl implements TodoRepository {
  final TodoLocalDatasource localDatasource;

  TodoRepositoryImpl(this.localDatasource);

  @override
  Future<Either<TodoFailure, List<Todo>>> getAllTodos() async {
    try {
      final models = await localDatasource.getAllTodos();
      final todos = models.map((e) => e.toEntity()).toList();
      return Right(todos);
    } catch (e) {
      return Left(StorageFailure('Failed to load todos: $e'));
    }
  }

  @override
  Future<Either<TodoFailure, void>> addTodo(Todo todo) async {
    try {
      final model = TodoModel.fromEntity(todo);
      await localDatasource.addTodo(model);
      return const Right(null);
    } catch (e) {
      return Left(StorageFailure('Failed to add todo: $e'));
    }
  }

  @override
  Future<Either<TodoFailure, void>> deleteTodo(String id) async {
    try {
      await localDatasource.deleteTodo(id);
      return const Right(null);
    } catch (e) {
      return Left(StorageFailure('Failed to delete todo: $e'));
    }
  }

  @override
  Future<Either<TodoFailure, void>> deleteAllTodos() async {
    try {
      await localDatasource.deleteAllTodos();
      return const Right(null);
    } catch (e) {
      return Left(StorageFailure('Failed to delete all todos: $e'));
    }
  }

  @override
  Future<Either<TodoFailure, void>> deleteCompletedTodos() async {
    try {
      await localDatasource.deleteCompletedTodos();
      return const Right(null);
    } catch (e) {
      return Left(StorageFailure('Failed to delete completed todos: $e'));
    }
  }

  @override
  Future<Either<TodoFailure, void>> toggleCompleteTodo(String id) async {
    try {
      await localDatasource.toggleComplete(id);
      return const Right(null);
    } catch (e) {
      return Left(StorageFailure('Failed to toggle complete: $e'));
    }
  }
}
