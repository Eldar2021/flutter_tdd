import 'dart:async';

import 'package:dartz/dartz.dart';

import '../../../../core/error/exceptions.dart';
import '../../../../core/error/failures.dart';
import '../../../../core/platform/network_info.dart';
import '../../domain/entities/number_trivia.dart';
import '../../domain/repositories/number_repository.dart';
import '../models/number_trivia_model.dart';
import '../sourses/number_trivia_local_data_source.dart';
import '../sourses/number_trivia_remote_data_source.dart';

class NumberTriviaRepositoryImpl implements NumberTriviaRepository {
  NumberTriviaRepositoryImpl({
    required this.remoteDataSource,
    required this.localDataSource,
    required this.networkInfo,
  });

  final NumberTriviaRemoteDataSource remoteDataSource;
  final NumberTriviaLocalDataSource localDataSource;
  final NetworkInfo networkInfo;

  @override
  Future<Either<Failure, NumBerTrivia>> getConcreateNumberTrivia(
    int number,
  ) async {
    return _getTrivia(() async {
      return remoteDataSource.getConcreteNumberTrivia(number);
    });
  }

  @override
  Future<Either<Failure, NumBerTrivia>> getRandomTrivia() async {
    return _getTrivia(() async {
      return remoteDataSource.getRandomNumberTrivia();
    });
  }

  Future<Either<Failure, NumBerTrivia>> _getTrivia(
    Future<NumberTriviaModel> Function() getConcreteOrRandon,
  ) async {
    if (await networkInfo.isConnected) {
      try {
        final remoteTrivia = await getConcreteOrRandon();
        await localDataSource.cacheNumberTrivia(remoteTrivia);
        return Right(remoteTrivia);
      } on ServerException {
        return Left(ServerFailure());
      }
    } else {
      try {
        final localTrivia = await localDataSource.getLastNumberTrivia();
        return Right(localTrivia);
      } on CacheException {
        return Left(CacheFailure());
      }
    }
  }
}
