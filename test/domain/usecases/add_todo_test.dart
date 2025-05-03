import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:fpdart/fpdart.dart';

import 'package:simple_todo_app/core/todo_failure.dart';
import 'package:simple_todo_app/domain/entities/todo.dart';
import 'package:simple_todo_app/domain/repositories/todo_repository.dart';
import 'package:simple_todo_app/domain/usescases/add_todo.dart';

// Unit Test: AddTodo UseCase
//
// This unit test verifies the behavior of the `AddTodo` use case.
class MockTodoRepository extends Mock implements TodoRepository {}

void main() {
  late AddTodo usecase;
  late MockTodoRepository mockRepo;

  // Create a valid Todo to test with
  const testTodo = Todo(id: '123', title: 'Testaufgabe', isCompleted: false);

  setUp(() {
    mockRepo = MockTodoRepository();
    usecase = AddTodo(repository: mockRepo);
  });

  test('should call repository and return Right(void) on success', () async {
    // Arrange: mock repository success
    when(() => mockRepo.addTodo(testTodo)).thenAnswer((_) async => const Right(null));

    // Act: call the use case
    final result = await usecase(testTodo);

    // Assert: result is success, and repository was called once
    expect(result, equals(const Right(null)));
    verify(() => mockRepo.addTodo(testTodo)).called(1);
  });

  test('should return Left(TodoFailure) when repository fails', () async {
    // Arrange: mock repository failure
    final failure = StorageFailure('Fehler beim Speichern');
    when(() => mockRepo.addTodo(testTodo)).thenAnswer((_) async => Left(failure));

    // Act: call the use case
    final result = await usecase(testTodo);

    // Assert: result is failure, and repository was called once
    expect(result, equals(Left(failure)));
    verify(() => mockRepo.addTodo(testTodo)).called(1);
  });
}
