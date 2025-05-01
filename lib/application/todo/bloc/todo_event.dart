part of 'todo_bloc.dart';

/// Events that can be triggered by the UI to update the Todo state.
@immutable
sealed class TodoEvent {}

/// Loads all Todos from the data source.
final class LoadTodos extends TodoEvent {}

/// Adds a new Todo with the given title.
final class AddTodoEvent extends TodoEvent {
  final String title;

  AddTodoEvent(this.title);
}

/// Deletes a Todo by ID.
final class DeleteTodoEvent extends TodoEvent {
  final String id;

  DeleteTodoEvent(this.id);
}

/// Toggles the completion status of a Todo.
final class ToggleTodoCompletionEvent extends TodoEvent {
  final String id;

  ToggleTodoCompletionEvent(this.id);
}

/// Deletes all Todos.
final class DeleteAllTodosEvent extends TodoEvent {}

/// Deletes only completed Todos.
final class DeleteCompletedTodosEvent extends TodoEvent {}
