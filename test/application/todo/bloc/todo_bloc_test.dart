import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:fpdart/fpdart.dart';
import 'package:simple_todo_app/application/todo/bloc/todo_bloc.dart';
import 'package:simple_todo_app/domain/entities/todo.dart';
import 'package:simple_todo_app/domain/usescases/add_todo.dart';
import 'package:simple_todo_app/domain/usescases/delete_all_todos.dart';
import 'package:simple_todo_app/domain/usescases/delete_completed_todos.dart';
import 'package:simple_todo_app/domain/usescases/delete_todo.dart';
import 'package:simple_todo_app/domain/usescases/get_all_todos.dart';
import 'package:simple_todo_app/domain/usescases/toggle_complete_todo.dart';

class MockAddTodo extends Mock implements AddTodo {}

class MockGetAllTodos extends Mock implements GetAllTodos {}

class MockDeleteTodo extends Mock implements DeleteTodo {}

class MockDeleteAllTodos extends Mock implements DeleteAllTodos {}

class MockDeleteCompletedTodos extends Mock implements DeleteCompletedTodos {}

class MockToggleCompleteTodo extends Mock implements ToggleCompleteTodo {}

void main() {
  // BLoC Test: TodoBloc handles AddTodoEvent correctly
  //
  // This test verifies that when an `AddTodoEvent` is dispatched to the `TodoBloc`,
  late TodoBloc bloc;
  late MockAddTodo mockAddTodo;
  late MockGetAllTodos mockGetAllTodos;
  late MockDeleteTodo mockDeleteTodo;
  late MockDeleteAllTodos mockDeleteAllTodos;
  late MockDeleteCompletedTodos mockDeleteCompletedTodos;
  late MockToggleCompleteTodo mockToggleCompleteTodo;

  const testTodo = Todo(id: '1', title: 'Test', isCompleted: false);

  setUpAll(() {
    // Register fallback for Todo class to allow mocktail's `any()` to work
    registerFallbackValue(testTodo);
  });

  setUp(() {
    mockAddTodo = MockAddTodo();
    mockGetAllTodos = MockGetAllTodos();
    mockDeleteTodo = MockDeleteTodo();
    mockDeleteAllTodos = MockDeleteAllTodos();
    mockDeleteCompletedTodos = MockDeleteCompletedTodos();
    mockToggleCompleteTodo = MockToggleCompleteTodo();

    // Create the BLoC with all mocked dependencies
    bloc = TodoBloc(
      addTodo: mockAddTodo,
      getAllTodos: mockGetAllTodos,
      deleteTodo: mockDeleteTodo,
      deleteAllTodos: mockDeleteAllTodos,
      deleteCompletedTodos: mockDeleteCompletedTodos,
      toggleCompleteTodo: mockToggleCompleteTodo,
    );
  });

  blocTest<TodoBloc, TodoState>(
    'emits [TodoLoading, TodoLoaded] when AddTodoEvent is added successfully',
    build: () {
      // Mock successful use case results
      when(() => mockAddTodo(testTodo)).thenAnswer((_) async => const Right(null));

      when(() => mockGetAllTodos()).thenAnswer((_) async => const Right([testTodo]));

      return bloc;
    },
    act: (bloc) => bloc.add(const AddTodoEvent('Test', id: '1')),

    // Expect the correct order of state emissions
    expect:
        () => [
          TodoLoading(),
          TodoLoaded([testTodo]),
        ],

    // Verify the correct methods were called
    verify: (_) {
      verify(() => mockAddTodo(testTodo)).called(1);
      verify(() => mockGetAllTodos()).called(1);
    },
  );
}
