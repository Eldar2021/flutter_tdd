part of 'number_trivia_bloc.dart';

abstract class NumberTriviaEvent extends Equatable {
  const NumberTriviaEvent();
}

class GetConcreteNumber extends NumberTriviaEvent {
  const GetConcreteNumber(this.numberString);

  final String numberString;

  @override
  List<Object> get props => [numberString];
}

class GetRandomNumber extends NumberTriviaEvent {
  @override
  List<Object> get props => [];
}
