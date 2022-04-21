import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:get_it/get_it.dart';
import 'package:hive/hive.dart';
import 'package:http/http.dart' as http;

import '../../features/number_trivia/data/models/number_trivia_model.dart';
import '../../features/number_trivia/data/repositories/number_trivia_repository_impl.dart';
import '../../features/number_trivia/data/sourses/number_trivia_local_data_source.dart';
import '../../features/number_trivia/data/sourses/number_trivia_remote_data_source.dart';
import '../../features/number_trivia/domain/repositories/number_repository.dart';
import '../../features/number_trivia/domain/usecases/get_concrete_number_trivia.dart';
import '../../features/number_trivia/domain/usecases/get_random_number_trivia.dart';
import '../../features/number_trivia/presentation/bloc/number_trivia_bloc.dart';
import '../platform/network_info.dart';

final sl = GetIt.I;

void appInit() {
  sl
    ..registerFactory(
      () => NumberTriviaBloc(
        getConcreteNumberTrivia: sl(),
        getRandomNumberTrivia: sl(),
        inputConverter: sl(),
      ),
    )
    ..registerLazySingleton(() => GetConcreteNumberTrivia(sl()))
    ..registerLazySingleton(() => GetRandomNumberTrivia(sl()))
    ..registerLazySingleton<NumberTriviaRepository>(
      () => NumberTriviaRepositoryImpl(
        remoteDataSource: sl(),
        localDataSource: sl(),
        networkInfo: sl(),
      ),
    )
    ..registerLazySingleton<NumberTriviaLocalDataSource>(
      () => NumberTriviaLocalDataSourceImpl(sl()),
    )
    ..registerLazySingleton<NumberTriviaRemoteDataSource>(
      () => NumberTriviaRemoteDataSourceImpl(sl()),
    )
    ..registerLazySingleton<NetworkInfo>(
      () => NetworkInfoImpl(sl()),
    )
    ..registerLazySingleton<Box<NumberTriviaModel>>(
      () => Hive.box<NumberTriviaModel>('NumberTrivia'),
    )
    ..registerLazySingleton<http.Client>(http.Client.new)
    ..registerLazySingleton<Connectivity>(Connectivity.new);
}
