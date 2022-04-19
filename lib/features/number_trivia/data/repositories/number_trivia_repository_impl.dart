import 'package:dartz/dartz.dart';
import '../../../../core/error/failures.dart';
import '../../../../core/platform/network_info.dart';
import '../../domain/entities/number_trivia.dart';
import '../../domain/repositories/number_repository.dart';
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
    await networkInfo.isConnected;
    return const Right<Failure, NumBerTrivia>(
      NumBerTrivia(text: 'text', number: 1),
    );
  }

  @override
  Future<Either<Failure, NumBerTrivia>> getRandomTrivia() {
    throw UnimplementedError();
  }
}
