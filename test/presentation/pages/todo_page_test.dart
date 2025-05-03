import 'package:bloc_test/bloc_test.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mocktail/mocktail.dart';

import 'package:simple_todo_app/application/todo/bloc/todo_bloc.dart';
import 'package:simple_todo_app/presentation/pages/todo_page.dart';

// Widget Test: TodoPage Snackbar Error Feedback
//
// This test ensures that error feedback is visible to the user
class MockTodoBloc extends Mock implements TodoBloc {}

void main() {
  late MockTodoBloc mockBloc;

  // Because `TodoEvent` and `TodoState` are sealed classes,
  // we cannot create `Fake` classes for them like:
  // `class FakeTodoState extends Fake implements TodoState {}`
  // Sealed classes are restricted to their own library.

  // Instead, we use real instances of known subclasses (e.g. AddTodoEvent, TodoInitial)
  setUpAll(() {
    // Register fallback values for mocktail to handle `any()` calls
    registerFallbackValue(const AddTodoEvent('fallback'));
    registerFallbackValue(TodoInitial());
  });

  setUp(() {
    mockBloc = MockTodoBloc();
  });

  testWidgets('shows a snackbar when TodoError state is emitted', (WidgetTester tester) async {
    // Arrange: start with initial state
    when(() => mockBloc.state).thenReturn(TodoInitial());

    // Simulate Bloc emitting states over time:
    // 1. TodoLoading
    // 2. TodoError (should trigger snackbar)
    whenListen(mockBloc, Stream<TodoState>.fromIterable([TodoLoading(), TodoError('Failed to save the task')]));

    // Act: render the widget with the mocked Bloc
    await tester.pumpWidget(MaterialApp(home: BlocProvider<TodoBloc>.value(value: mockBloc, child: const TodoPage())));

    // Let Bloc emit new state and UI rebuild
    await tester.pump(); // process first state change
    await tester.pump(const Duration(seconds: 1)); // allow Snackbar animation

    // Assert: check that Snackbar with error message is shown
    expect(find.byType(SnackBar), findsOneWidget);
    expect(find.text('Failed to save the task'), findsOneWidget);
  });
}
