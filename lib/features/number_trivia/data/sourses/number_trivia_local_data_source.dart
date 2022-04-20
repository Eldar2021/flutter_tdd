import 'package:hive/hive.dart';
import 'package:test_driven_development/core/error/exceptions.dart';

import '../models/number_trivia_model.dart';

abstract class NumberTriviaLocalDataSource {
  Future<NumberTriviaModel> getLastNumberTrivia();

  Future<void> cacheNumberTrivia(NumberTriviaModel triviaToCache);
}

class NumberTriviaLocalDataSourceImpl implements NumberTriviaLocalDataSource {
  NumberTriviaLocalDataSourceImpl(this.hiveBox);

  final Box<NumberTriviaModel> hiveBox;

  @override
  Future<NumberTriviaModel> getLastNumberTrivia() {
    final val = hiveBox.get('Trivia');
    if (val != null) {
      return Future.value(val);
    } else {
      throw CacheException();
    }
  }

  @override
  Future<void> cacheNumberTrivia(NumberTriviaModel triviaToCache) async {
    await hiveBox.put('Trivia', triviaToCache);
    return;
  }
}
