import 'package:get_it/get_it.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:simple_todo_app/application/todo/bloc/todo_bloc.dart';
import 'package:simple_todo_app/domain/repositories/todo_repository.dart';
import 'package:simple_todo_app/domain/usescases/add_todo.dart';
import 'package:simple_todo_app/domain/usescases/delete_all_todos.dart';
import 'package:simple_todo_app/domain/usescases/delete_completed_todos.dart';
import 'package:simple_todo_app/domain/usescases/delete_todo.dart';
import 'package:simple_todo_app/domain/usescases/get_all_todos.dart';
import 'package:simple_todo_app/domain/usescases/toggle_complete_todo.dart';
import 'package:simple_todo_app/infrastructure/datasources/todo_local_datasource.dart';
import 'package:simple_todo_app/infrastructure/models/todo_model.dart';
import 'package:simple_todo_app/infrastructure/repositories/todo_repository_impl.dart';

final sl = GetIt.instance;

Future<void> init() async {
  // Hive
  await Hive.initFlutter();
  Hive.registerAdapter(TodoModelAdapter());

  // Data Sources
  sl.registerLazySingleton(() => TodoLocalDatasource());

  // Repository
  // sl.registerLazySingleton(() => TodoRepositoryImpl(sl()));
  sl.registerLazySingleton<TodoRepository>(() => TodoRepositoryImpl(sl<TodoLocalDatasource>()));

  // Use Cases
  sl.registerLazySingleton(() => AddTodo(repository: sl()));
  sl.registerLazySingleton(() => DeleteTodo(repository: sl()));
  sl.registerLazySingleton(() => GetAllTodos(repository: sl()));
  sl.registerLazySingleton(() => DeleteAllTodos(repository: sl()));
  sl.registerLazySingleton(() => DeleteCompletedTodos(repository: sl()));
  sl.registerLazySingleton(() => ToggleCompleteTodo(repository: sl()));

  // Bloc als Factory (jedes Widget bekommt eine eigene Instanz)
  sl.registerFactory(
    () => TodoBloc(
      getAllTodos: sl(),
      addTodo: sl(),
      deleteTodo: sl(),
      deleteAllTodos: sl(),
      deleteCompletedTodos: sl(),
      toggleCompleteTodo: sl(),
    ),
  );
}
