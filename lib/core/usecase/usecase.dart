import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';

import '../error/failures.dart';

// ignore: one_member_abstracts
abstract class UseCase<T, P> {
  Future<Either<Failure, T>> call(P p);
}

class NoParams extends Equatable {
  @override
  List<Object?> get props => throw UnimplementedError();
}
