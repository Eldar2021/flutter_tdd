import 'package:bloc_test/bloc_test.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:test_driven_development/core/error/failures.dart';
import 'package:test_driven_development/core/usecase/usecase.dart';
import 'package:test_driven_development/core/utils/input_convert.dart';
import 'package:test_driven_development/features/number_trivia/domain/entities/number_trivia.dart';
import 'package:test_driven_development/features/number_trivia/domain/usecases/get_concrete_number_trivia.dart';
import 'package:test_driven_development/features/number_trivia/domain/usecases/get_random_number_trivia.dart';
import 'package:test_driven_development/features/number_trivia/presentation/cubit/numbertriviacubit_cubit.dart';

class MockGetConcreteNumberTrivia extends Mock
    implements GetConcreteNumberTrivia {}

class MockGetRandomNumberTrivia extends Mock implements GetRandomNumberTrivia {}

class MockInputConverter extends Mock implements InputConverter {}

void main() {
  late MockGetConcreteNumberTrivia mockGetConcreteNumberTrivia;
  late MockGetRandomNumberTrivia mockGetRandomNumberTrivia;
  late MockInputConverter mockInputConverter;
  late NumbertriviacubitCubit cubit;

  setUp(() {
    mockGetConcreteNumberTrivia = MockGetConcreteNumberTrivia();
    mockGetRandomNumberTrivia = MockGetRandomNumberTrivia();
    mockInputConverter = MockInputConverter();
    cubit = NumbertriviacubitCubit(
      getConcreteNumberTrivia: mockGetConcreteNumberTrivia,
      getRandomNumberTrivia: mockGetRandomNumberTrivia,
      inputConverter: mockInputConverter,
    );
  });

  test(
    'initial state is empty',
    () {
      expect(cubit.state, EmptyState());
    },
  );

  group('get trivia concrete number', () {
    const tString = '1';
    const tInvalidStr = 'abc';
    const tParsed = 1;
    const tNumberTrivia = NumBerTrivia(text: 'text', number: 1);

    blocTest<NumbertriviacubitCubit, NumbertriviacubitState>(
      'inputConverter valid',
      build: () => cubit,
      act: (bloc) {
        when(() => mockInputConverter.stringToInt(tString))
            .thenReturn(const Right(tParsed));

        when(
          () => mockGetConcreteNumberTrivia(const Params(number: tParsed)),
        ).thenAnswer((_) async => const Right(tNumberTrivia));

        cubit.getConcreteNumber(tString);
      },
      verify: (_) => mockInputConverter.stringToInt(tString),
    );

    blocTest<NumbertriviacubitCubit, NumbertriviacubitState>(
      '[Error] inputConverter invalid',
      build: () => cubit,
      act: (bloc) {
        when(() => mockInputConverter.stringToInt(tInvalidStr))
            .thenReturn(Left(InvalidInputFailure()));

        cubit.getConcreteNumber(tInvalidStr);
      },
      expect: () => [const ErrorState('error state')],
    );

    blocTest<NumbertriviacubitCubit, NumbertriviacubitState>(
      'call  GetConcreteNumberTrivia',
      build: () => cubit,
      act: (bloc) {
        when(() => mockInputConverter.stringToInt(tString))
            .thenReturn(const Right(tParsed));

        when(
          () => mockGetConcreteNumberTrivia(const Params(number: tParsed)),
        ).thenAnswer((_) async => const Right(tNumberTrivia));

        cubit.getConcreteNumber(tString);
      },
      verify: (_) => mockGetConcreteNumberTrivia(const Params(number: tParsed)),
    );

    blocTest<NumbertriviacubitCubit, NumbertriviacubitState>(
      'GetConcreteNumberTrivia complated success',
      build: () => cubit,
      act: (bloc) {
        when(() => mockInputConverter.stringToInt(tString))
            .thenReturn(const Right(tParsed));

        when(
          () => mockGetConcreteNumberTrivia(const Params(number: tParsed)),
        ).thenAnswer((_) async => const Right(tNumberTrivia));

        cubit.getConcreteNumber(tString);
      },
      expect: () => <NumbertriviacubitState>[
        // EmptyState(),
        LoadingState(),
        const SuccessState(tNumberTrivia),
      ],
    );

    blocTest<NumbertriviacubitCubit, NumbertriviacubitState>(
      'GetConcreteNumberTrivia complated server error',
      build: () => cubit,
      act: (bloc) {
        when(() => mockInputConverter.stringToInt(tString))
            .thenReturn(const Right(tParsed));

        when(
          () => mockGetConcreteNumberTrivia(const Params(number: tParsed)),
        ).thenAnswer((_) async => Left(ServerFailure()));

        cubit.getConcreteNumber(tString);
      },
      expect: () => <NumbertriviacubitState>[
        // EmptyState(),
        LoadingState(),
        const ErrorState('server error'),
      ],
    );

    blocTest<NumbertriviacubitCubit, NumbertriviacubitState>(
      'GetConcreteNumberTrivia complated cache error',
      build: () => cubit,
      act: (bloc) {
        when(() => mockInputConverter.stringToInt(tString))
            .thenReturn(const Right(tParsed));

        when(
          () => mockGetConcreteNumberTrivia(const Params(number: tParsed)),
        ).thenAnswer((_) async => Left(CacheFailure()));

        cubit.getConcreteNumber(tString);
      },
      expect: () => <NumbertriviacubitState>[
        // EmptyState(),
        LoadingState(),
        const ErrorState('cache error'),
      ],
    );
  });

  group('get trivia random number', () {
    const tNumberTrivia = NumBerTrivia(text: 'text', number: 1);

    blocTest<NumbertriviacubitCubit, NumbertriviacubitState>(
      'call  GetRandomNumberTrivia',
      build: () => cubit,
      act: (bloc) {
        when(
          () => mockGetRandomNumberTrivia(NoParams()),
        ).thenAnswer((_) async => const Right(tNumberTrivia));

        cubit.getRandomNumber();
      },
      verify: (_) => mockGetRandomNumberTrivia(NoParams()),
    );

    blocTest<NumbertriviacubitCubit, NumbertriviacubitState>(
      'GetRandomNumberTrivia complated success',
      build: () => cubit,
      act: (bloc) {
        when(
          () => mockGetRandomNumberTrivia(NoParams()),
        ).thenAnswer((_) async => const Right(tNumberTrivia));

        cubit.getRandomNumber();
      },
      expect: () => <NumbertriviacubitState>[
        // EmptyState(),
        LoadingState(),
        const SuccessState(tNumberTrivia),
      ],
    );

    blocTest<NumbertriviacubitCubit, NumbertriviacubitState>(
      'GetRandomNumberTrivia complated server error',
      build: () => cubit,
      act: (bloc) {
        when(
          () => mockGetRandomNumberTrivia(NoParams()),
        ).thenAnswer((_) async => Left(ServerFailure()));

        cubit.getRandomNumber();
      },
      expect: () => <NumbertriviacubitState>[
        // EmptyState(),
        LoadingState(),
        const ErrorState('server error'),
      ],
    );

    blocTest<NumbertriviacubitCubit, NumbertriviacubitState>(
      'GetRandomNumberTrivia complated cache error',
      build: () => cubit,
      act: (bloc) {
        when(
          () => mockGetRandomNumberTrivia(NoParams()),
        ).thenAnswer((_) async => Left(CacheFailure()));

        cubit.getRandomNumber();
      },
      expect: () => <NumbertriviacubitState>[
        // EmptyState(),
        LoadingState(),
        const ErrorState('cache error'),
      ],
    );
  });
}
