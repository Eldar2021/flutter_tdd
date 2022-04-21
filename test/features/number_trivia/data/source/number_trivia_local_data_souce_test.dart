import 'package:flutter_test/flutter_test.dart';
import 'package:hive/hive.dart';
import 'package:mocktail/mocktail.dart';
import 'package:test_driven_development/core/error/exceptions.dart';
import 'package:test_driven_development/features/number_trivia/data/models/number_trivia_model.dart';
import 'package:test_driven_development/features/number_trivia/data/sourses/number_trivia_local_data_source.dart';

class MockHiveBox extends Mock implements Box<NumberTriviaModel> {}

void main() {
  late MockHiveBox mockHiveBox;
  late NumberTriviaLocalDataSource dataSource;
  late NumberTriviaModel numberTriviaModel;

  setUp(() {
    mockHiveBox = MockHiveBox();
    dataSource = NumberTriviaLocalDataSourceImpl(mockHiveBox);
    numberTriviaModel = const NumberTriviaModel(
      text: 'model text',
      number: 1,
    );
  });

  group(
    'get tast number trivia',
    () {
      test(
        'number trivia fron hive box',
        () async {
          when<NumberTriviaModel>(() => mockHiveBox.get('Trivia')!)
              .thenReturn(numberTriviaModel);

          final result = await dataSource.getLastNumberTrivia();

          verify(() => mockHiveBox.get('Trivia'));

          expect(result, numberTriviaModel);
        },
      );

      test(
        'null fron hive box',
        () async {
          when<dynamic>(() => mockHiveBox.get('Trivia')!).thenReturn(null);

          final call = dataSource.getLastNumberTrivia;

          expect(call, throwsA(const TypeMatcher<CacheException>()));
        },
      );
    },
  );

  group('cache number trivia', () {
    test(
      'cache number trivia success',
      () async {
        when(() => mockHiveBox.put('Trivia', numberTriviaModel))
            .thenAnswer((_) => Future.value());

        await dataSource.cacheNumberTrivia(numberTriviaModel);

        verifyNever(() => mockHiveBox.put('Trivia', numberTriviaModel));
      },
    );
  });
}
