import 'package:bloc/core/providers/auth_provider.dart';
import 'package:bloc/domain/usecases/register_login.dart';
import 'package:get_it/get_it.dart';

import 'package:bloc/data/datasource/remote/auth_data_source.dart';
import 'package:bloc/data/repositories/auth_repository_impl.dart';
import 'package:bloc/domain/repositories/auth_repository.dart';
import 'package:bloc/domain/usecases/login_usecase.dart';

final sl = GetIt.instance;

Future<void> initDependencies() async {
  // DataSource
  sl.registerLazySingleton<AuthDataSource>(() => AuthDataSource());

  // Repository
  sl.registerLazySingleton<AuthRepository>(
    () => AuthRepositoryImpl(authDataSource: sl()),
  );

  // UseCases
  sl.registerLazySingleton(() => LoginUseCase(sl()));
  sl.registerLazySingleton(() => RegisterUseCase(sl()));

  // Providers
  sl.registerFactory(
    () => AuthProvider(
      loginUseCase: sl(),
      registerUseCase: sl(),
    ),
  );
}