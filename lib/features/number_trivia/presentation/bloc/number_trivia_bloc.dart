import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../../../../core/error/failures.dart';
import '../../../../core/usecase/usecase.dart';
import '../../../../core/utils/input_convert.dart';
import '../../domain/entities/number_trivia.dart';
import '../../domain/usecases/get_concrete_number_trivia.dart';
import '../../domain/usecases/get_random_number_trivia.dart';

part 'number_trivia_event.dart';
part 'number_trivia_state.dart';

class NumberTriviaBloc extends Bloc<NumberTriviaEvent, NumberTriviaState> {
  NumberTriviaBloc({
    required this.getConcreteNumberTrivia,
    required this.getRandomNumberTrivia,
    required this.inputConverter,
  }) : super(EmptyState()) {
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

    on<NumberTriviaEvent>((event, emit) {});
    on<GetConcreteNumber>((event, emit) async {
      final either = inputConverter.stringToInt(event.numberString);
      // ignore: cascade_invocations
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
    });
    on<GetRandomNumber>((event, emit) async {
      emit(LoadingState());
      final errorOrSuccess = await getRandomNumberTrivia(
        NoParams(),
      );

      errorOrSuccess.fold(
        (l) => emit(ErrorState(_getErrorMassage(l))),
        (r) => emit(SuccessState(r)),
      );
    });
  }

  final GetConcreteNumberTrivia getConcreteNumberTrivia;
  final GetRandomNumberTrivia getRandomNumberTrivia;
  final InputConverter inputConverter;
}
