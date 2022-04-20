import 'dart:convert';

import 'package:flutter_test/flutter_test.dart';
import 'package:http/http.dart' as http;
import 'package:mocktail/mocktail.dart';
import 'package:test_driven_development/core/error/exceptions.dart';
import 'package:test_driven_development/features/number_trivia/data/models/number_trivia_model.dart';
import 'package:test_driven_development/features/number_trivia/data/sourses/number_trivia_remote_data_source.dart';

import '../../../../fixtures/fixture_reader.dart';

class MockHttpClient extends Mock implements http.Client {}

void main() {
  late MockHttpClient mockHttpClient;
  late NumberTriviaRemoteDataSource dataSource;

  setUp(() {
    mockHttpClient = MockHttpClient();
    dataSource = NumberTriviaRemoteDataSourceImpl(mockHttpClient);
  });

  const tNumber = 1;
  final urlConrete = Uri.parse('http://numbersapi.com/$tNumber?json');
  final urlRandom = Uri.parse('http://numbersapi.com/random?json');
  final headers = {'Content-Type': 'application/json'};

  void _httpClient200(Uri uri) {
    when(() => mockHttpClient.get(uri, headers: headers)).thenAnswer(
      (_) async => http.Response(fixture('trivia.json'), 200),
    );
  }

  void _httpClient404(Uri uri) {
    when(() => mockHttpClient.get(uri, headers: headers)).thenAnswer(
      (_) async => http.Response('Something wrong', 404),
    );
  }

  group('get concrete number trivia', () {
    final tNumberTriviaModel = NumberTriviaModel.fromJson(
      json.decode(fixture('trivia.json')) as Map<String, dynamic>,
    );

    test(
      'Get request URL wuth number Content-Type: application/json',
      () async {
        _httpClient200(urlConrete);

        await dataSource.getConcreteNumberTrivia(tNumber);

        verify(() => mockHttpClient.get(urlConrete, headers: headers));
      },
    );

    test(
      'Returh NumberTrivia Model Success',
      () async {
        _httpClient200(urlConrete);

        final result = await dataSource.getConcreteNumberTrivia(tNumber);

        expect(result, tNumberTriviaModel);
      },
    );

    test(
      'Returh ServerException Error',
      () async {
        _httpClient404(urlConrete);

        final call = dataSource.getConcreteNumberTrivia;

        expect(call(tNumber), throwsA(const TypeMatcher<ServerException>()));
      },
    );
  });

  group('get random number trivia', () {
    final tNumberTriviaModel = NumberTriviaModel.fromJson(
      json.decode(fixture('trivia.json')) as Map<String, dynamic>,
    );

    test(
      'Get request URL with random Content-Type: application/json',
      () async {
        _httpClient200(urlRandom);

        await dataSource.getRandomNumberTrivia();

        verify(() => mockHttpClient.get(urlRandom, headers: headers));
      },
    );

    test(
      'Returh NumberTrivia Model Success',
      () async {
        _httpClient200(urlRandom);

        final result = await dataSource.getRandomNumberTrivia();

        expect(result, tNumberTriviaModel);
      },
    );

    test(
      'Returh ServerException Error',
      () async {
        _httpClient404(urlRandom);

        final call = dataSource.getRandomNumberTrivia();

        expect(call, throwsA(const TypeMatcher<ServerException>()));
      },
    );
  });
}
