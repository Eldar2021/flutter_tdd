import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:test_driven_development/core/error/failures.dart';
import 'package:test_driven_development/features/number_trivia/domain/repositories/number_repository.dart';
import 'package:test_driven_development/features/number_trivia/domain/usecases/get_concrete_number_trivia.dart';
import 'package:test_driven_development/features/number_trivia/number_trivia.dart';

class MockNumberTriviaRepository extends Mock
    implements NumberTriviaRepository {}

void main() {
  late GetConcreteNumberTrivia usecase;
  late MockNumberTriviaRepository mockNumberTriviaRepository;
  setUp(() {
    mockNumberTriviaRepository = MockNumberTriviaRepository();
    usecase = GetConcreteNumberTrivia(mockNumberTriviaRepository);
  });

  const tNumber = 1;
  const tNumberTrivia = NumBerTrivia(text: 'test', number: tNumber);

  test(
    'should get trivia for the number from the repository',
    () async {
      // arrange
      when(() => mockNumberTriviaRepository.getConcreateNumberTrivia(tNumber))
          .thenAnswer(
        (_) async => const Right<Failure, NumBerTrivia>(tNumberTrivia),
      );

      // act
      final result = await usecase(number: tNumber);

      // assert
      expect(result, const Right<Failure, NumBerTrivia>(tNumberTrivia));

      verify(
        () => mockNumberTriviaRepository.getConcreateNumberTrivia(tNumber),
      );

      verifyNoMoreInteractions(mockNumberTriviaRepository);
    },
  );
}
