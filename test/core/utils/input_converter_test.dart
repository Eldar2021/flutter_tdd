import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:test_driven_development/core/error/failures.dart';
import 'package:test_driven_development/core/utils/input_convert.dart';

void main() {
  late InputConverter inputConverter;
  setUp(() {
    inputConverter = InputConverter();
  });

  group('string to integer', () {
    test(
      'success',
      () async {
        const str = '123';

        final result = inputConverter.stringToInt(str);

        expect(result, const Right<Failure, int>(123));
      },
    );

    test(
      'failure',
      () async {
        const str = 'abc';

        final result = inputConverter.stringToInt(str);

        expect(result, Left<Failure, int>(InvalidInputFailure()));
      },
    );

    test(
      'negative',
      () async {
        const str = 'abc';

        final result = inputConverter.stringToInt(str);

        expect(result, Left<Failure, int>(InvalidInputFailure()));
      },
    );
  });
}
