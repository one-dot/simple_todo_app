part of 'todo_bloc.dart';

/// Represents the state of the Todo list.
@immutable
sealed class TodoState extends Equatable {
  const TodoState();

  @override
  List<Object?> get props => [];
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

  @override
  List<Object?> get props => [todos];
}

/// State for error handling
final class TodoError extends TodoState {
  final String message;

  const TodoError(this.message);

  @override
  List<Object?> get props => [message];
}
