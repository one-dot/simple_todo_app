import 'package:bloc/bloc.dart';
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

//TODO Consider using the uuid package to generate random IDs
//TODO Consider to extend error handling
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
      result.match((l) => emit(TodoError('Failed to load todos')), (todos) => emit(TodoLoaded(todos)));
    });

    on<AddTodoEvent>((event, emit) async {
      final newTodo = Todo(
        id: DateTime.now().millisecondsSinceEpoch.toString(),
        title: event.title,
        isCompleted: false,
      );
      final result = await addTodo(newTodo);
      result.match((l) => null, (_) => add(LoadTodos()));
    });

    on<DeleteTodoEvent>((event, emit) async {
      final result = await deleteTodo(event.id);
      result.match((l) => null, (_) => add(LoadTodos()));
    });

    on<ToggleTodoCompletionEvent>((event, emit) async {
      final result = await toggleCompleteTodo(event.id);
      result.match((l) => null, (_) => add(LoadTodos()));
    });

    on<DeleteAllTodosEvent>((event, emit) async {
      final result = await deleteAllTodos();
      result.match((l) => null, (_) => add(LoadTodos()));
    });

    on<DeleteCompletedTodosEvent>((event, emit) async {
      final result = await deleteCompletedTodos();
      result.match((l) => null, (_) => add(LoadTodos()));
    });
  }
}
