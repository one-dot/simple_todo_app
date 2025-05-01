part of 'todo_bloc.dart';

//TODO: Consider to use Equatable
/// Represents the state of the Todo list.
@immutable
sealed class TodoState {}

/// Base state class for all Todo states.
final class TodoInitial extends TodoState {}

/// State indicating that Todos are being loaded.
final class TodoLoading extends TodoState {}

/// State when Todos are successfully loaded.
final class TodoLoaded extends TodoState {
  final List<Todo> todos;

  TodoLoaded(this.todos);
}

/// Optional: state for error handling (not aktiv genutzt im Bloc oben)
final class TodoError extends TodoState {
  final String message;

  TodoError(this.message);
}
