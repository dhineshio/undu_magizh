import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:get_it/get_it.dart';
import '../../features/example/data/datasources/example_remote_datasource.dart';
import '../../features/example/data/repositories/example_repository_impl.dart';
import '../../features/example/domain/repositories/example_repository.dart';
import '../../features/example/domain/usecases/get_examples_usecase.dart';
import '../../features/example/presentation/bloc/example_bloc.dart';
import '../network/dio_client.dart';
import '../network/interceptor.dart';
import '../network/network_info.dart';
import '../network/network_info_impl.dart';

/// Dependency injection container
final sl = GetIt.instance;

/// Initialize dependencies
Future<void> initializeDependencies() async {
  // ==================== Core ====================
  
  // Network
  sl.registerLazySingleton<Connectivity>(() => Connectivity());
  sl.registerLazySingleton<NetworkInfo>(() => NetworkInfoImpl(sl()));
  sl.registerLazySingleton<LoggerInterceptor>(() => LoggerInterceptor());
  sl.registerLazySingleton<DioClient>(() => DioClient());

  // ==================== Example Feature ====================
  
  // Data sources
  sl.registerLazySingleton<ExampleRemoteDataSource>(
    () => ExampleRemoteDataSourceImpl(dioClient: sl()),
  );

  // Repositories
  sl.registerLazySingleton<ExampleRepository>(
    () => ExampleRepositoryImpl(remoteDataSource: sl()),
  );

  // Use cases
  sl.registerLazySingleton(() => GetExamplesUseCase(sl()));

  // BLoC
  sl.registerFactory(
    () => ExampleBloc(getExamplesUseCase: sl()),
  );
}
