import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';

import '../../../../core/error/failures.dart';
import '../../../../core/usecase/usecase.dart';
import '../entities/number_trivia.dart';
import '../repositories/number_repository.dart';

class GetConcreteNumberTrivia implements UseCase<NumBerTrivia, Params> {
  GetConcreteNumberTrivia(this.repository);

  final NumberTriviaRepository repository;

  @override
  Future<Either<Failure, NumBerTrivia>> call(Params params) async {
    return repository.getConcreateNumberTrivia(params.number);
  }
}

class Params extends Equatable {
  const Params({required this.number});

  final int number;

  @override
  List<Object?> get props => [number];
}
