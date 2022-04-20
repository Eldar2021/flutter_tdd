import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:test_driven_development/core/error/exceptions.dart';
import 'package:test_driven_development/core/error/failures.dart';
import 'package:test_driven_development/core/platform/network_info.dart';
import 'package:test_driven_development/features/number_trivia/data/models/number_trivia_model.dart';
import 'package:test_driven_development/features/number_trivia/data/repositories/number_trivia_repository_impl.dart';
import 'package:test_driven_development/features/number_trivia/data/sourses/number_trivia_local_data_source.dart';
import 'package:test_driven_development/features/number_trivia/data/sourses/number_trivia_remote_data_source.dart';
import 'package:test_driven_development/features/number_trivia/domain/entities/number_trivia.dart';

class MockRemoteDataSource extends Mock
    implements NumberTriviaRemoteDataSource {}

class MockLocalDataSource extends Mock implements NumberTriviaLocalDataSource {}

class MockNetworkInfo extends Mock implements NetworkInfo {}

void main() {
  late MockRemoteDataSource mockRemoteDataSource;
  late MockLocalDataSource mockLocalDataSource;
  late MockNetworkInfo mockNetworkInfo;
  late NumberTriviaRepositoryImpl repository;

  setUp(() {
    mockRemoteDataSource = MockRemoteDataSource();
    mockLocalDataSource = MockLocalDataSource();
    mockNetworkInfo = MockNetworkInfo();
    repository = NumberTriviaRepositoryImpl(
      remoteDataSource: mockRemoteDataSource,
      localDataSource: mockLocalDataSource,
      networkInfo: mockNetworkInfo,
    );
  });

  group('get concrete number trivia', () {
    const tNumber = 1;
    const tNumberTriviaModel =
        NumberTriviaModel(text: 'Test Trivia', number: tNumber);
    const NumBerTrivia tNumberTrivia = tNumberTriviaModel;

    test('should check if the device is online', () async {
      //arrange
      when(() => mockNetworkInfo.isConnected).thenAnswer((_) async => true);

      when(() => mockRemoteDataSource.getConcreteNumberTrivia(tNumber))
          .thenAnswer((_) async => tNumberTriviaModel);

      when(() => mockLocalDataSource.cacheNumberTrivia(tNumberTriviaModel))
          // ignore: avoid_returning_null_for_void
          .thenAnswer((_) async => null);

      // act
      await repository.getConcreateNumberTrivia(tNumber);

      // assert
      verify(() => mockNetworkInfo.isConnected);
    });

    group('device is online', () {
      setUp(() {
        when(() => mockNetworkInfo.isConnected).thenAnswer((_) async => true);
      });

      test(
        'should return remote data when call to remote data source success',
        () async {
          when(() => mockRemoteDataSource.getConcreteNumberTrivia(tNumber))
              .thenAnswer((_) async => tNumberTriviaModel);

          when(() => mockLocalDataSource.cacheNumberTrivia(tNumberTriviaModel))
              // ignore: avoid_returning_null_for_void
              .thenAnswer((_) async => null);

          final result = await repository.getConcreateNumberTrivia(tNumber);

          verify(() => mockRemoteDataSource.getConcreteNumberTrivia(tNumber));

          expect(result, const Right<Failure, NumBerTrivia>(tNumberTrivia));
        },
      );

      test(
        'should cache locally data when call to remote data source success',
        () async {
          when(() => mockRemoteDataSource.getConcreteNumberTrivia(tNumber))
              .thenAnswer((_) async => tNumberTriviaModel);

          when(() => mockLocalDataSource.cacheNumberTrivia(tNumberTriviaModel))
              // ignore: avoid_returning_null_for_void
              .thenAnswer((_) async => null);

          await repository.getConcreateNumberTrivia(tNumber);

          verify(() => mockRemoteDataSource.getConcreteNumberTrivia(tNumber));

          verify(
            () => mockLocalDataSource.cacheNumberTrivia(tNumberTriviaModel),
          );
        },
      );
      test(
        'return server failure when call to remote data source unsuccess',
        () async {
          when(() => mockRemoteDataSource.getConcreteNumberTrivia(tNumber))
              .thenThrow(ServerException());

          final result = await repository.getConcreateNumberTrivia(tNumber);

          verify(() => mockRemoteDataSource.getConcreteNumberTrivia(tNumber));

          verifyZeroInteractions(mockLocalDataSource);

          expect(result, Left<Failure, NumBerTrivia>(ServerFailure()));
        },
      );
    });

    group('device is offline', () {
      setUp(() {
        when(() => mockNetworkInfo.isConnected).thenAnswer((_) async => false);
      });

      test(
        'return last locally data when the cached data is present',
        () async {
          when(() => mockLocalDataSource.getLastNumberTrivia())
              .thenAnswer((invocation) async => tNumberTriviaModel);

          final result = await repository.getConcreateNumberTrivia(tNumber);

          verifyZeroInteractions(mockRemoteDataSource);
          verify(() => mockLocalDataSource.getLastNumberTrivia());

          expect(result, const Right<Failure, NumBerTrivia>(tNumberTrivia));
        },
      );

      test(
        'return CacheFailure data when the cached data is not present',
        () async {
          when(() => mockLocalDataSource.getLastNumberTrivia())
              .thenThrow(CacheException());

          final result = await repository.getConcreateNumberTrivia(tNumber);

          verifyZeroInteractions(mockRemoteDataSource);
          verify(() => mockLocalDataSource.getLastNumberTrivia());

          expect(result, Left<Failure, NumBerTrivia>(CacheFailure()));
        },
      );
    });
  });


  group('get randon number trivia', () {
    const tNumberTriviaModel =
        NumberTriviaModel(text: 'Test Trivia', number: 1);
    const NumBerTrivia tNumberTrivia = tNumberTriviaModel;

    test('should check if the device is online', () async {
      //arrange
      when(() => mockNetworkInfo.isConnected).thenAnswer((_) async => true);

      when(() => mockRemoteDataSource.getRandomNumberTrivia())
          .thenAnswer((_) async => tNumberTriviaModel);

      when(() => mockLocalDataSource.cacheNumberTrivia(tNumberTriviaModel))
          // ignore: avoid_returning_null_for_void
          .thenAnswer((_) async => null);

      // act
      await repository.getRandomTrivia();

      // assert
      verify(() => mockNetworkInfo.isConnected);
    });

    group('device is online', () {
      setUp(() {
        when(() => mockNetworkInfo.isConnected).thenAnswer((_) async => true);
      });

      test(
        'should return remote data when call to remote data source success',
        () async {
          when(() => mockRemoteDataSource.getRandomNumberTrivia())
              .thenAnswer((_) async => tNumberTriviaModel);

          when(() => mockLocalDataSource.cacheNumberTrivia(tNumberTriviaModel))
              // ignore: avoid_returning_null_for_void
              .thenAnswer((_) async => null);

          final result = await repository.getRandomTrivia();

          verify(() => mockRemoteDataSource.getRandomNumberTrivia());

          expect(result, const Right<Failure, NumBerTrivia>(tNumberTrivia));
        },
      );

      test(
        'should cache locally data when call to remote data source success',
        () async {
          when(() => mockRemoteDataSource.getRandomNumberTrivia())
              .thenAnswer((_) async => tNumberTriviaModel);

          when(() => mockLocalDataSource.cacheNumberTrivia(tNumberTriviaModel))
              // ignore: avoid_returning_null_for_void
              .thenAnswer((_) async => null);

          await repository.getRandomTrivia();

          verify(() => mockRemoteDataSource.getRandomNumberTrivia());

          verify(
            () => mockLocalDataSource.cacheNumberTrivia(tNumberTriviaModel),
          );
        },
      );
      test(
        'return server failure when call to remote data source unsuccess',
        () async {
          when(() => mockRemoteDataSource.getRandomNumberTrivia())
              .thenThrow(ServerException());

          final result = await repository.getRandomTrivia();

          verify(() => mockRemoteDataSource.getRandomNumberTrivia());

          verifyZeroInteractions(mockLocalDataSource);

          expect(result, Left<Failure, NumBerTrivia>(ServerFailure()));
        },
      );
    });

    group('device is offline', () {
      setUp(() {
        when(() => mockNetworkInfo.isConnected).thenAnswer((_) async => false);
      });

      test(
        'return last locally data when the cached data is present',
        () async {
          when(() => mockLocalDataSource.getLastNumberTrivia())
              .thenAnswer((invocation) async => tNumberTriviaModel);

          final result = await repository.getRandomTrivia();

          verifyZeroInteractions(mockRemoteDataSource);
          verify(() => mockLocalDataSource.getLastNumberTrivia());

          expect(result, const Right<Failure, NumBerTrivia>(tNumberTrivia));
        },
      );

      test(
        'return CacheFailure data when the cached data is not present',
        () async {
          when(() => mockLocalDataSource.getLastNumberTrivia())
              .thenThrow(CacheException());

          final result = await repository.getRandomTrivia();

          verifyZeroInteractions(mockRemoteDataSource);
          verify(() => mockLocalDataSource.getLastNumberTrivia());

          expect(result, Left<Failure, NumBerTrivia>(CacheFailure()));
        },
      );
    });
  });
}
