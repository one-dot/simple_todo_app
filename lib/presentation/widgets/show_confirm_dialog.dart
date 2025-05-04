import 'package:flutter/material.dart';

/// Shows a confirmation dialog and returns true if user confirms.
Future<bool> showConfirmDialog({
  required BuildContext context,
  required String title,
  required String content,
  String confirmText = 'OK',
  String cancelText = 'Cancel',
}) async {
  final result = await showDialog<bool>(
    context: context,
    builder:
        (ctx) => AlertDialog(
          title: Text(title),
          content: Text(content),
          actions: [
            ElevatedButton(
              onPressed: () => Navigator.of(ctx).pop(false),
              child: Text(cancelText, style: TextStyle(color: Colors.deepPurple)),
            ),
            ElevatedButton(
              onPressed: () => Navigator.of(ctx).pop(true),
              child: Text(confirmText, style: TextStyle(color: Colors.deepPurple)),
            ),
          ],
        ),
  );

  return result == true;
}
