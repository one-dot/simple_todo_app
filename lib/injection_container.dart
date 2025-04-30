import 'package:get_it/get_it.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:simple_todo_app/infrastructure/datasources/todo_local_datasource.dart';
import 'package:simple_todo_app/infrastructure/repositories/todo_repository_impl.dart';

final sl = GetIt.instance;

Future<void> init() async {
  // External
  await Hive.initFlutter();

  // Data Sources
  sl.registerLazySingleton(() => TodoLocalDatasource());

  // Repository
  sl.registerLazySingleton(() => TodoRepositoryImpl(sl()));
}
