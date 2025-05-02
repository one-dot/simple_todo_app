import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:simple_todo_app/application/todo/bloc/todo_bloc.dart';
import 'package:simple_todo_app/presentation/widgets/show_confirm_dialog.dart';

/// Buttons for clearing completed or all Todos.
///
/// Each button shows a confirmation dialog before firing the actual event.
/// This prevents accidental data loss and improves user safety.
class ClearButtons extends StatelessWidget {
  const ClearButtons({super.key});

  @override
  Widget build(BuildContext context) {
    final bloc = context.read<TodoBloc>();

    return Column(
      children: [
        /// Button to clear only completed tasks.
        /// Shows confirmation before triggering [DeleteCompletedTodosEvent].
        ElevatedButton(
          onPressed: () async {
            final confirm = await showConfirmDialog(
              context: context,
              title: 'Clear Completed Tasks',
              content: 'Are you sure you want to delete all completed tasks?',
              confirmText: 'Delete',
              cancelText: 'Cancel',
            );
            if (confirm) {
              bloc.add(DeleteCompletedTodosEvent());
            }
          },
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.green,
            minimumSize: const Size(double.infinity, 50),
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
          ),
          child: const Text('Clear Done'),
        ),
        const SizedBox(height: 12),

        /// Button to clear all tasks.
        /// Shows confirmation before triggering [DeleteAllTodosEvent].
        ElevatedButton(
          onPressed: () async {
            final confirm = await showConfirmDialog(
              context: context,
              title: 'Clear All Tasks',
              content: 'This will delete all tasks. Are you sure?',
              confirmText: 'Delete All',
              cancelText: 'Cancel',
            );
            if (confirm) {
              bloc.add(DeleteAllTodosEvent());
            }
          },
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
