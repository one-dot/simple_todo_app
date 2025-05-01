import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:simple_todo_app/application/todo/bloc/todo_bloc.dart';
import 'package:simple_todo_app/domain/entities/todo.dart';

class TodoListItem extends StatelessWidget {
  final Todo todo;

  const TodoListItem({super.key, required this.todo});

  @override
  Widget build(BuildContext context) {
    final bloc = context.read<TodoBloc>();

    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
      child: ListTile(
        leading: Checkbox(value: todo.isCompleted, onChanged: (_) => bloc.add(ToggleTodoCompletionEvent(todo.id))),
        title: Text(todo.title, style: TextStyle(decoration: todo.isCompleted ? TextDecoration.lineThrough : null)),
        trailing: IconButton(icon: const Icon(Icons.delete), onPressed: () => bloc.add(DeleteTodoEvent(todo.id))),
      ),
    );
  }
}
