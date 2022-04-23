part of 'numbertriviacubit_cubit.dart';

abstract class NumbertriviacubitState extends Equatable {
  const NumbertriviacubitState();

  @override
  List<Object> get props => [];
}

class EmptyState extends NumbertriviacubitState {
  @override
  List<Object> get props => [];
}

class LoadingState extends NumbertriviacubitState {
  @override
  List<Object> get props => [];
}

class SuccessState extends NumbertriviacubitState {
  const SuccessState(this.trivia);

  final NumBerTrivia trivia;

  @override
  List<Object> get props => [trivia];
}

class ErrorState extends NumbertriviacubitState {
  const ErrorState(this.message);

  final String message;

  @override
  List<Object> get props => [message];
}
