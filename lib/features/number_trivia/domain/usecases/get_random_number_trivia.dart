import 'package:dartz/dartz.dart';

import '../../../../core/error/failures.dart';
import '../../../../core/usecase/usecase.dart';
import '../entities/number_trivia.dart';
import '../repositories/number_repository.dart';

class GetRandomNumberTrivia implements UseCase<NumBerTrivia, NoParams> {
  GetRandomNumberTrivia(this.repository);

  final NumberTriviaRepository repository;

  @override
  Future<Either<Failure, NumBerTrivia>> call(NoParams p) async {
    return repository.getRandomTrivia();
  }
}
