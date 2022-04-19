import 'dart:convert';
import 'package:flutter_test/flutter_test.dart';
import 'package:test_driven_development/features/number_trivia/data/models/number_trivia_model.dart';
import 'package:test_driven_development/features/number_trivia/domain/entities/number_trivia.dart';

import '../../../../fixtures/fixture_reader.dart';

void main() {
  const tNumberTrivia = NumberTriviaModel(number: 1, text: 'model test');

  test('should be sub class of NumberTrivia entity', () {
    expect(tNumberTrivia, isA<NumBerTrivia>());
  });

  group('from json', () {
    test(
      'should return valid model when the json mumber is an integer',
      () async {
        final jsonMap =
            json.decode(fixture('trivia.json')) as Map<String, dynamic>;

        final result = NumberTriviaModel.fromJson(jsonMap);

        expect(result, equals(tNumberTrivia));
      },
    );

    test(
      'should return valid model when the json mumber is regerded as a double',
      () async {
        final jsonMap =
            json.decode(fixture('trivia_double.json')) as Map<String, dynamic>;

        final result = NumberTriviaModel.fromJson(jsonMap);

        expect(result, equals(tNumberTrivia));
      },
    );
  });

  group('to json', () {
    test(
      'should return a json map containing the proper data',
      () async {
        final result = tNumberTrivia.toJson();

        const data = <String, dynamic>{
          'text': 'model test',
          'number': 1.0,
        };

        expect(result, data);
      },
    );
  });
}
