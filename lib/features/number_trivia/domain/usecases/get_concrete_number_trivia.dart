import 'package:dartz/dartz.dart';
import 'package:flutter/material.dart';
import 'package:test_driven_development/features/number_trivia/domain/repositories/number_repository.dart';
import 'package:test_driven_development/features/number_trivia/number_trivia.dart';

import '../../../../core/error/failures.dart';

class GetConcreteNumberTrivia {
  GetConcreteNumberTrivia(this.repository);

  final NumberTriviaRepository repository;

  Future<Either<Failure, NumBerTrivia>> call({required int number}) async {
    return repository.getConcreateNumberTrivia(number);
  }
}
