// ignore_for_file: cascade_invocations

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../../../../core/error/failures.dart';
import '../../../../core/usecase/usecase.dart';
import '../../../../core/utils/input_convert.dart';
import '../../domain/entities/number_trivia.dart';
import '../../domain/usecases/get_concrete_number_trivia.dart';
import '../../domain/usecases/get_random_number_trivia.dart';

part 'numbertriviacubit_state.dart';

class NumbertriviacubitCubit extends Cubit<NumbertriviacubitState> {
  NumbertriviacubitCubit({
    required this.getConcreteNumberTrivia,
    required this.getRandomNumberTrivia,
    required this.inputConverter,
  }) : super(EmptyState());
  
  final GetConcreteNumberTrivia getConcreteNumberTrivia;
  final GetRandomNumberTrivia getRandomNumberTrivia;
  final InputConverter inputConverter;

  String _getErrorMassage(Failure failure) {
    switch (failure.runtimeType) {
      case ServerFailure:
        return 'server error';
      case CacheFailure:
        return 'cache error';
      default:
        return 'some error';
    }
  }

  Future<void> getConcreteNumber(String text) async {
    final either = inputConverter.stringToInt(text);
    either.fold(
      (l) => emit(const ErrorState('error state')),
      (r) async {
        emit(LoadingState());
        final errorOrSuccess = await getConcreteNumberTrivia(
          Params(number: r),
        );

        errorOrSuccess.fold(
          (l) => emit(ErrorState(_getErrorMassage(l))),
          (r) => emit(SuccessState(r)),
        );
      },
    );
  }

  Future<void> getRandomNumber() async {
    emit(LoadingState());
    final errorOrSuccess = await getRandomNumberTrivia(
      NoParams(),
    );

    errorOrSuccess.fold(
      (l) => emit(ErrorState(_getErrorMassage(l))),
      (r) => emit(SuccessState(r)),
    );
  }
}
