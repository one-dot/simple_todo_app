import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:simple_todo_app/application/todo/bloc/todo_bloc.dart';
import 'package:simple_todo_app/presentation/widgets/Todo_List_Item.dart';
import 'package:simple_todo_app/presentation/widgets/clear_buttons.dart';
import 'package:simple_todo_app/presentation/widgets/todo_input_field.dart';

/// The main page of the Todo app that displays the input field,
/// the list of tasks, and action buttons to clear tasks.
class TodoPage extends StatelessWidget {
  const TodoPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('To-Do List')),
      body: Column(
        children: [
          // Input field and Add button to enter new todos
          const Padding(padding: EdgeInsets.all(12), child: TodoInputField()),

          // Expanded BlocBuilder to listen to TodoBloc state and show todo list
          Expanded(
            child: BlocBuilder<TodoBloc, TodoState>(
              builder: (context, state) {
                // Show loading indicator while fetching todos
                if (state is TodoLoading) {
                  return const Center(child: CircularProgressIndicator());
                }
                // Show the list of todos when loaded
                else if (state is TodoLoaded) {
                  if (state.todos.isEmpty) {
                    return const Center(child: Text('No tasks yet.'));
                  }
                  // ListView of todos with spacing between items
                  return ListView.separated(
                    itemCount: state.todos.length,
                    separatorBuilder: (_, __) => const Divider(height: 1),
                    itemBuilder: (context, index) {
                      return TodoListItem(todo: state.todos[index]);
                    },
                  );
                } else {
                  return const SizedBox.shrink();
                }
              },
            ),
          ),
          const Padding(padding: EdgeInsets.symmetric(horizontal: 12, vertical: 20), child: ClearButtons()),
        ],
      ),
    );
  }
}
