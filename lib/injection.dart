import 'package:get_it/get_it.dart';
import 'package:http/http.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'features/auth/data/datasources/auth_local_data_source_implementation.dart';
import 'features/auth/data/repositories/auth_repository_implementation.dart';
import 'features/auth/domain/repositories/auth_repository.dart';
import 'features/auth/domain/usecases/auth_usecase.dart';
import 'features/auth/presentation/bloc/user_cubit.dart';
import 'features/filters/data/datasources/filters_remote_data_source_implementation.dart';
import 'features/filters/data/repositories/filters_repository_implementation.dart';
import 'features/filters/domain/repositories/filters_repository.dart';
import 'features/filters/domain/usecases/filters_usecase.dart';
import 'features/filters/presentation/bloc/filter_cublit.dart';

final sl = GetIt.instance;

Future<void> init() async {
  // Bloc
  sl.registerFactory(
    () => UserCubit(sl()),
  );

  sl.registerFactory(
    () => FilterCubit(sl()),
  );

  // Use cases
  sl.registerLazySingleton(() => AuthUseCase(sl()));
  sl.registerLazySingleton(() => FiltersUseCase(sl()));

  // Repository
  sl.registerLazySingleton<AuthRepository>(
    () => AuthRepositoryImpl(localDataSourceImpl: sl()),
  );
  sl.registerLazySingleton<AuthLocalDataSourceImpl>(
    () => AuthLocalDataSourceImpl(sharedPreferences: sl()),
  );
  sl.registerLazySingleton<FiltersRepository>(
    () => FiltersRepositoryImpl(remoteDataSourceImpl: sl()),
  );
  sl.registerLazySingleton<FiltersRemoteDataSourceImpl>(
    () => FiltersRemoteDataSourceImpl(sl()),
  );

  // Lib
  final sharedPreferences = await SharedPreferences.getInstance();
  sl.registerLazySingleton(() => sharedPreferences);

  sl.registerLazySingleton(() => Client());
}
