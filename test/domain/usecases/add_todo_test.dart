import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:fpdart/fpdart.dart';
import 'package:simple_todo_app/core/todo_failure.dart';
import 'package:simple_todo_app/domain/entities/todo.dart';
import 'package:simple_todo_app/domain/usescases/add_todo.dart';

import '../../mock/mock_todo_repository.dart';

void main() {
  late AddTodo usecase;
  late MockTodoRepository mockRepo;

  setUp(() {
    mockRepo = MockTodoRepository();
    usecase = AddTodo(repository: mockRepo);
  });

  final testTodo = Todo(id: '123', title: 'Testaufgabe', isCompleted: false);

  test('should call repository and return Right(void) on success', () async {
    // Arrange
    when(() => mockRepo.addTodo(testTodo)).thenAnswer((_) async => const Right(null));

    // Act
    final result = await usecase(testTodo);

    // Assert
    expect(result, equals(const Right(null)));
    verify(() => mockRepo.addTodo(testTodo)).called(1);
  });

  test('should return Left(TodoFailure) when repository fails', () async {
    // Arrange
    final failure = StorageFailure('Fehler beim Speichern');
    when(() => mockRepo.addTodo(testTodo)).thenAnswer((_) async => Left(failure));

    // Act
    final result = await usecase(testTodo);

    // Assert
    expect(result, equals(Left(failure)));
    verify(() => mockRepo.addTodo(testTodo)).called(1);
  });
}
