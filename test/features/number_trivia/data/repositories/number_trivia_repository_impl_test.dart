import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
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
  late NumberTriviaRepositoryImpl repositoryImpl;
  late MockRemoteDataSource mockRemoteDataSource;
  late MockLocalDataSource mockLocalDataSource;
  late MockNetworkInfo mockNetworkInfo;

  setUp(() {
    mockRemoteDataSource = MockRemoteDataSource();
    mockLocalDataSource = MockLocalDataSource();
    mockNetworkInfo = MockNetworkInfo();
    repositoryImpl = NumberTriviaRepositoryImpl(
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
      when(() => mockNetworkInfo.isConnected).thenAnswer((_) async => true);

      await repositoryImpl.getConcreateNumberTrivia(tNumber);

      verify(() => mockNetworkInfo.isConnected);
    });

    group('device is online', () {
      setUp(() {
        when(() => mockNetworkInfo.isConnected).thenAnswer((_) async => true);
      });
    });

    group('device is offline', () {
      setUp(() {
        when(() => mockNetworkInfo.isConnected).thenAnswer((_) async => false);
      });
    });
  });
}
