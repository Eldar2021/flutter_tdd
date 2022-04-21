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
import 'package:test_driven_development/features/number_trivia/presentation/bloc/number_trivia_bloc.dart';

class MockGetConcreteNumberTrivia extends Mock
    implements GetConcreteNumberTrivia {}

class MockGetRandomNumberTrivia extends Mock implements GetRandomNumberTrivia {}

class MockInputConverter extends Mock implements InputConverter {}

void main() {
  late MockGetConcreteNumberTrivia mockGetConcreteNumberTrivia;
  late MockGetRandomNumberTrivia mockGetRandomNumberTrivia;
  late MockInputConverter mockInputConverter;
  late NumberTriviaBloc bloc;

  setUp(() {
    mockGetConcreteNumberTrivia = MockGetConcreteNumberTrivia();
    mockGetRandomNumberTrivia = MockGetRandomNumberTrivia();
    mockInputConverter = MockInputConverter();
    bloc = NumberTriviaBloc(
      getConcreteNumberTrivia: mockGetConcreteNumberTrivia,
      getRandomNumberTrivia: mockGetRandomNumberTrivia,
      inputConverter: mockInputConverter,
    );
  });

  test(
    'initial state is empty',
    () {
      expect(bloc.state, EmptyState());
    },
  );

  group('get trivia concrete number', () {
    const tString = '1';
    const tInvalidStr = 'abc';
    const tParsed = 1;
    const tNumberTrivia = NumBerTrivia(text: 'text', number: 1);

    blocTest<NumberTriviaBloc, NumberTriviaState>(
      'inputConverter valid',
      build: () => bloc,
      act: (bloc) {
        when(() => mockInputConverter.stringToInt(tString))
            .thenReturn(const Right(tParsed));

        when(
          () => mockGetConcreteNumberTrivia(const Params(number: tParsed)),
        ).thenAnswer((_) async => const Right(tNumberTrivia));

        bloc.add(const GetConcreteNumber(tString));
      },
      verify: (_) => mockInputConverter.stringToInt(tString),
    );

    blocTest<NumberTriviaBloc, NumberTriviaState>(
      '[Error] inputConverter invalid',
      build: () => bloc,
      act: (bloc) {
        when(() => mockInputConverter.stringToInt(tInvalidStr))
            .thenReturn(Left(InvalidInputFailure()));

        bloc.add(const GetConcreteNumber(tInvalidStr));
      },
      expect: () => [const ErrorState('error state')],
    );

    blocTest<NumberTriviaBloc, NumberTriviaState>(
      'call  GetConcreteNumberTrivia',
      build: () => bloc,
      act: (bloc) {
        when(() => mockInputConverter.stringToInt(tString))
            .thenReturn(const Right(tParsed));

        when(
          () => mockGetConcreteNumberTrivia(const Params(number: tParsed)),
        ).thenAnswer((_) async => const Right(tNumberTrivia));

        bloc.add(const GetConcreteNumber(tString));
      },
      verify: (_) => mockGetConcreteNumberTrivia(const Params(number: tParsed)),
    );

    blocTest<NumberTriviaBloc, NumberTriviaState>(
      'GetConcreteNumberTrivia complated success',
      build: () => bloc,
      act: (bloc) {
        when(() => mockInputConverter.stringToInt(tString))
            .thenReturn(const Right(tParsed));

        when(
          () => mockGetConcreteNumberTrivia(const Params(number: tParsed)),
        ).thenAnswer((_) async => const Right(tNumberTrivia));

        bloc.add(const GetConcreteNumber(tString));
      },
      expect: () => <NumberTriviaState>[
        // EmptyState(),
        LoadingState(),
        const SuccessState(tNumberTrivia),
      ],
    );

    blocTest<NumberTriviaBloc, NumberTriviaState>(
      'GetConcreteNumberTrivia complated server error',
      build: () => bloc,
      act: (bloc) {
        when(() => mockInputConverter.stringToInt(tString))
            .thenReturn(const Right(tParsed));

        when(
          () => mockGetConcreteNumberTrivia(const Params(number: tParsed)),
        ).thenAnswer((_) async => Left(ServerFailure()));

        bloc.add(const GetConcreteNumber(tString));
      },
      expect: () => <NumberTriviaState>[
        // EmptyState(),
        LoadingState(),
        const ErrorState('server error'),
      ],
    );

    blocTest<NumberTriviaBloc, NumberTriviaState>(
      'GetConcreteNumberTrivia complated cache error',
      build: () => bloc,
      act: (bloc) {
        when(() => mockInputConverter.stringToInt(tString))
            .thenReturn(const Right(tParsed));

        when(
          () => mockGetConcreteNumberTrivia(const Params(number: tParsed)),
        ).thenAnswer((_) async => Left(CacheFailure()));

        bloc.add(const GetConcreteNumber(tString));
      },
      expect: () => <NumberTriviaState>[
        // EmptyState(),
        LoadingState(),
        const ErrorState('cache error'),
      ],
    );
  });

  group('get trivia random number', () {
    const tNumberTrivia = NumBerTrivia(text: 'text', number: 1);

    blocTest<NumberTriviaBloc, NumberTriviaState>(
      'call  GetRandomNumberTrivia',
      build: () => bloc,
      act: (bloc) {
        when(
          () => mockGetRandomNumberTrivia(NoParams()),
        ).thenAnswer((_) async => const Right(tNumberTrivia));

        bloc.add(GetRandomNumber());
      },
      verify: (_) => mockGetRandomNumberTrivia(NoParams()),
    );

    blocTest<NumberTriviaBloc, NumberTriviaState>(
      'GetRandomNumberTrivia complated success',
      build: () => bloc,
      act: (bloc) {
        when(
          () => mockGetRandomNumberTrivia(NoParams()),
        ).thenAnswer((_) async => const Right(tNumberTrivia));

        bloc.add(GetRandomNumber());
      },
      expect: () => <NumberTriviaState>[
        // EmptyState(),
        LoadingState(),
        const SuccessState(tNumberTrivia),
      ],
    );

    blocTest<NumberTriviaBloc, NumberTriviaState>(
      'GetRandomNumberTrivia complated server error',
      build: () => bloc,
      act: (bloc) {
        when(
          () => mockGetRandomNumberTrivia(NoParams()),
        ).thenAnswer((_) async => Left(ServerFailure()));

        bloc.add(GetRandomNumber());
      },
      expect: () => <NumberTriviaState>[
        // EmptyState(),
        LoadingState(),
        const ErrorState('server error'),
      ],
    );

    blocTest<NumberTriviaBloc, NumberTriviaState>(
      'GetRandomNumberTrivia complated cache error',
      build: () => bloc,
      act: (bloc) {
        when(
          () => mockGetRandomNumberTrivia(NoParams()),
        ).thenAnswer((_) async => Left(CacheFailure()));

        bloc.add(GetRandomNumber());
      },
      expect: () => <NumberTriviaState>[
        // EmptyState(),
        LoadingState(),
        const ErrorState('cache error'),
      ],
    );
  });
}
