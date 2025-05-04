import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';
import 'package:simple_todo_app/domain/entities/todo.dart';
import 'package:simple_todo_app/domain/usescases/add_todo.dart';
import 'package:simple_todo_app/domain/usescases/delete_all_todos.dart';
import 'package:simple_todo_app/domain/usescases/delete_completed_todos.dart';
import 'package:simple_todo_app/domain/usescases/delete_todo.dart';
import 'package:simple_todo_app/domain/usescases/get_all_todos.dart';
import 'package:simple_todo_app/domain/usescases/toggle_complete_todo.dart';

part 'todo_event.dart';
part 'todo_state.dart';

class TodoBloc extends Bloc<TodoEvent, TodoState> {
  final GetAllTodos getAllTodos;
  final AddTodo addTodo;
  final DeleteTodo deleteTodo;
  final DeleteAllTodos deleteAllTodos;
  final DeleteCompletedTodos deleteCompletedTodos;
  final ToggleCompleteTodo toggleCompleteTodo;

  TodoBloc({
    required this.getAllTodos,
    required this.addTodo,
    required this.deleteTodo,
    required this.deleteAllTodos,
    required this.deleteCompletedTodos,
    required this.toggleCompleteTodo,
  }) : super(TodoInitial()) {
    on<LoadTodos>((event, emit) async {
      emit(TodoLoading());
      final result = await getAllTodos();
      result.match((failure) => emit(TodoError(failure.message)), (todos) => emit(TodoLoaded(todos)));
    });

    on<AddTodoEvent>((event, emit) async {
      // If an ID is provided, reuse it (e.g. during an undo operation).
      // Otherwise, generate a fresh ID for a new Todo item.
      final newTodo = Todo(
        id: event.id ?? DateTime.now().millisecondsSinceEpoch.toString(),
        title: event.title,
        isCompleted: false,
      );

      final result = await addTodo(newTodo);

      // Refresh the UI by reloading the Todo list after adding
      result.match((failure) => emit(TodoError(failure.message)), (_) => add(LoadTodos()));
    });

    on<DeleteTodoEvent>((event, emit) async {
      final result = await deleteTodo(event.id);
      result.match((failure) => emit(TodoError(failure.message)), (_) => add(LoadTodos()));
    });

    on<ToggleTodoCompletionEvent>((event, emit) async {
      final result = await toggleCompleteTodo(event.id);
      result.match((failure) => emit(TodoError(failure.message)), (_) => add(LoadTodos()));
    });

    on<DeleteAllTodosEvent>((event, emit) async {
      final result = await deleteAllTodos();
      result.match((failure) => emit(TodoError(failure.message)), (_) => add(LoadTodos()));
    });

    on<DeleteCompletedTodosEvent>((event, emit) async {
      final result = await deleteCompletedTodos();
      result.match((failure) => emit(TodoError(failure.message)), (_) => add(LoadTodos()));
    });
  }
}
