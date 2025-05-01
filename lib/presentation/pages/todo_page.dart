import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:simple_todo_app/application/todo/bloc/todo_bloc.dart';
import 'package:simple_todo_app/presentation/widgets/Todo_List_Item.dart';
import 'package:simple_todo_app/presentation/widgets/clear_buttons.dart';
import 'package:simple_todo_app/presentation/widgets/todo_input_field.dart';

class TodoPage extends StatelessWidget {
  const TodoPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('To-Do List')),
      body: Column(
        children: [
          const Padding(padding: EdgeInsets.all(12), child: TodoInputField()),
          Expanded(
            child: BlocBuilder<TodoBloc, TodoState>(
              builder: (context, state) {
                if (state is TodoLoading) {
                  return const Center(child: CircularProgressIndicator());
                } else if (state is TodoLoaded) {
                  if (state.todos.isEmpty) {
                    return const Center(child: Text('No tasks yet.'));
                  }
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
