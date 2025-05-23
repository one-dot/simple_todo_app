import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:simple_todo_app/core/theme/app_theme.dart';
import 'injection_container.dart' as di;
import 'application/todo/bloc/todo_bloc.dart';
import 'presentation/pages/todo_page.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Only allow portrait orientation
  await SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);

  // Init Hive, register adapters, DI
  await di.init();

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Simple Todo App',
      debugShowCheckedModeBanner: false,
      theme: appTheme,
      home: BlocProvider(create: (_) => di.sl<TodoBloc>()..add(LoadTodos()), child: const TodoPage()),
    );
  }
}
