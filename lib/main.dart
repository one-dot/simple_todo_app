import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'injection_container.dart' as di;
import 'application/todo/bloc/todo_bloc.dart';
import 'presentation/pages/todo_page.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Init Hive, register adapters, DI
  await di.init();

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Clean Todo App',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple), useMaterial3: true),
      home: BlocProvider(create: (_) => di.sl<TodoBloc>()..add(LoadTodos()), child: const TodoPage()),
    );
  }
}
