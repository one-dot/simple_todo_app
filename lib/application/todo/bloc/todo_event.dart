part of 'todo_bloc.dart';

/// Events that can be triggered by the UI to update the Todo state.
@immutable
sealed class TodoEvent {
  const TodoEvent();
}

/// Loads all Todos from the data source.
final class LoadTodos extends TodoEvent {
  const LoadTodos();
}

/// Adds a new Todo with the given title.
///
/// If [id] is provided, it will be used instead of generating a new one.
/// This is useful for restoring a deleted Todo via an Undo action.
final class AddTodoEvent extends TodoEvent {
  final String title;
  final String? id; // Optional

  const AddTodoEvent(this.title, {this.id});
}

/// Deletes a Todo by ID.
final class DeleteTodoEvent extends TodoEvent {
  final String id;

  const DeleteTodoEvent(this.id);
}

/// Toggles the completion status of a Todo.
final class ToggleTodoCompletionEvent extends TodoEvent {
  final String id;

  const ToggleTodoCompletionEvent(this.id);
}

/// Deletes all Todos.
final class DeleteAllTodosEvent extends TodoEvent {
  const DeleteAllTodosEvent();
}

/// Deletes only completed Todos.
final class DeleteCompletedTodosEvent extends TodoEvent {
  const DeleteCompletedTodosEvent();
}
