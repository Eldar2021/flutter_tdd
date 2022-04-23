import 'package:flutter_test/flutter_test.dart';
import 'package:hive/hive.dart';
import 'package:test_driven_development/app/app.dart';
import 'package:test_driven_development/core/lactor/service_locator.dart';
import 'package:test_driven_development/features/number_trivia/data/models/number_trivia_model.dart';
import 'package:test_driven_development/features/number_trivia/presentation/pages/number_trivia_page.dart';

void main() {
  group('App', () {
    setUp(() async {
      await appInit();
      Hive.init('database');
      await Hive.openBox<NumberTriviaModel>('NumberTrivia');
    });
    testWidgets('render NumberTriviaPage', (tester) async {
      await tester.pumpWidget(const App());
      expect(find.byType(NumberTriviaPage), findsOneWidget);
    });
  });
}
