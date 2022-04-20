part of 'number_trivia_bloc.dart';

abstract class NumberTriviaState extends Equatable {
  const NumberTriviaState();
}

class EmptyState extends NumberTriviaState {
  @override
  List<Object> get props => [];
}

class LoadingState extends NumberTriviaState {
  @override
  List<Object> get props => [];
}

class SuccessState extends NumberTriviaState {
  const SuccessState(this.trivia);

  final NumBerTrivia trivia;

  @override
  List<Object> get props => [trivia];
}

class ErrorState extends NumberTriviaState {
  const ErrorState(this.message);

  final String message;

  @override
  List<Object> get props => [message];
}
