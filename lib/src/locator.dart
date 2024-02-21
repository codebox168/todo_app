import 'package:get_it/get_it.dart';
import 'package:todo_app/src/core/utils/database_service.dart';
import 'package:todo_app/src/features/todo/data/datasources/todo_local_datasource.dart';
import 'package:todo_app/src/features/todo/data/datasources/todo_local_datasource_impl.dart';
import 'package:todo_app/src/features/todo/data/repositories/todo_repository_impl.dart';
import 'package:todo_app/src/features/todo/domain/repositories/todo_repository.dart';
import 'package:todo_app/src/features/todo/domain/usecases/add_usecase.dart';
import 'package:todo_app/src/features/todo/domain/usecases/get_usecase.dart';
import 'package:todo_app/src/features/todo/domain/usecases/remove_usecase.dart';
import 'package:todo_app/src/features/todo/domain/usecases/update_usecase.dart';
import 'package:todo_app/src/features/todo/presentation/bloc/todo_bloc.dart';

final getIt = GetIt.instance;

Future<void> setup() async {
  final DatabaseService databaseService = DatabaseServiceImpl();
  await databaseService.initialize();
  getIt
    ..registerSingleton<DatabaseService>(databaseService)
    ..registerSingleton<TodoLocalDatasource>(
      TodoLocalDatasourceImpl(db: getIt<DatabaseService>()),
    )
    ..registerSingleton<TodoRepository>(
      TodoRepositoryImpl(todoLocalDatasource: getIt<TodoLocalDatasource>()),
    )
    ..registerSingleton<AddUsecase>(
      AddUsecase(todoRepository: getIt<TodoRepository>()),
    )
    ..registerSingleton<GetUsecase>(
      GetUsecase(todoRepository: getIt<TodoRepository>()),
    )
    ..registerSingleton<RemoveUsecase>(
      RemoveUsecase(todoRepository: getIt<TodoRepository>()),
    )
    ..registerSingleton<UpdateUsecase>(
      UpdateUsecase(todoRepository: getIt<TodoRepository>()),
    )
    ..registerLazySingleton<TodoBloc>(
      () => TodoBloc(
        addUsecase: getIt<AddUsecase>(),
        getUsecase: getIt<GetUsecase>(),
        removeUsecase: getIt<RemoveUsecase>(),
        updateUsecase: getIt<UpdateUsecase>(),
      ),
    );
}
