import 'package:equatable/equatable.dart';

/// Entity representing a Todo item.
class Todo extends Equatable {
  final String id;
  final String title;
  final bool isCompleted;

  const Todo({required this.id, required this.title, required this.isCompleted});

  @override
  List<Object> get props => [id, title, isCompleted];
}
