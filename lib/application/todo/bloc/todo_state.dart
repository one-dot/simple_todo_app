part of 'todo_bloc.dart';

//TODO: Consider to use Equatable
/// Represents the state of the Todo list.
@immutable
sealed class TodoState {
  const TodoState();
}

/// Base state class for all Todo states.
final class TodoInitial extends TodoState {
  const TodoInitial();
}

/// State indicating that Todos are being loaded.
final class TodoLoading extends TodoState {
  const TodoLoading();
}

/// State when Todos are successfully loaded.
final class TodoLoaded extends TodoState {
  final List<Todo> todos;

  const TodoLoaded(this.todos);
}

/// State for error handling
final class TodoError extends TodoState {
  final String message;

  const TodoError(this.message);
}
