import 'package:flutter_test/flutter_test.dart';
import 'package:test_driven_development/app/app.dart';
import 'package:test_driven_development/counter/view/counter_page.dart';

void main() {
  group('App', () {
    testWidgets('render NumberTriviaPage', (tester) async {
      await tester.pumpWidget(const App());
      expect(find.byType(CounterPage), findsOneWidget);
    });
  });
}
