import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:simple_todo_app/application/todo/bloc/todo_bloc.dart';

class ClearButtons extends StatelessWidget {
  const ClearButtons({super.key});

  @override
  Widget build(BuildContext context) {
    final bloc = context.read<TodoBloc>();

    return Column(
      children: [
        ElevatedButton(
          onPressed: () => bloc.add(DeleteCompletedTodosEvent()),
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.green,
            minimumSize: const Size(double.infinity, 50),
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
          ),
          child: const Text('Clear Done'),
        ),
        const SizedBox(height: 12),
        ElevatedButton(
          onPressed: () => bloc.add(DeleteAllTodosEvent()),
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.red,
            minimumSize: const Size(double.infinity, 50),
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
          ),
          child: const Text('Clear All'),
        ),
      ],
    );
  }
}
