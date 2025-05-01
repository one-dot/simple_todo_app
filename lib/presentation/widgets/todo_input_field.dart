import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:simple_todo_app/application/todo/bloc/todo_bloc.dart';

class TodoInputField extends StatefulWidget {
  const TodoInputField({super.key});

  @override
  State<TodoInputField> createState() => _TodoInputFieldState();
}

class _TodoInputFieldState extends State<TodoInputField> {
  final controller = TextEditingController();

  void _addTask(BuildContext context) {
    final text = controller.text.trim();
    if (text.isNotEmpty) {
      context.read<TodoBloc>().add(AddTodoEvent(text));
      controller.clear();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: TextField(
            controller: controller,
            decoration: InputDecoration(
              hintText: 'Add a new task',
              prefixIcon: const Icon(Icons.search),
              border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
            ),
            onSubmitted: (_) => _addTask(context),
          ),
        ),
        const SizedBox(width: 8),
        IconButton(onPressed: () => _addTask(context), icon: const Icon(Icons.add)),
      ],
    );
  }
}
