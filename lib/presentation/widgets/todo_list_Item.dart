import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:simple_todo_app/application/todo/bloc/todo_bloc.dart';
import 'package:simple_todo_app/domain/entities/todo.dart';

/// A single visual representation of a [Todo] item.
///
/// Displays the task title with a checkbox to toggle completion
/// and a delete button that triggers the deletion of the task.
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
        trailing: IconButton(
          icon: const Icon(Icons.delete),
          onPressed: () {
            // 1. Delete the todo via BLoC
            bloc.add(DeleteTodoEvent(todo.id));
            // 2. Show snackbar with Undo option
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: const Text('Task deleted'),
                backgroundColor: Colors.blue,
                padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 20),
                action: SnackBarAction(
                  textColor: Colors.white,
                  label: 'Undo',
                  onPressed: () {
                    // 3. If undo is pressed, re-add the same Todo via BLoC
                    bloc.add(AddTodoEvent(todo.title, id: todo.id));
                  },
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
