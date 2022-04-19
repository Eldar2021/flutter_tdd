import 'package:equatable/equatable.dart';

abstract class Failure extends Equatable {
  const Failure([
    // ignore: avoid_unused_constructor_parameters
    List properties = const <dynamic>[],
  ]) : super();
}

class ServerFailure extends Failure {

  @override
  List<Object?> get props => [];
}

class CacheFailure extends Failure {
  
  @override
  List<Object?> get props => [];
}
