import 'package:flutter_test/flutter_test.dart';
import 'package:test_driven_development/features/number_trivia/presentation/pages/screen/number_trivia_screen.dart';

import '../../../../helpers/helpers.dart';

void main() {
  group('widgets', () {
    testWidgets(
      'MassageText',
      (tester) async {
        await tester.pumpApp(const MassageText('Eldarado'));
        expect(find.text('Eldarado'), findsOneWidget);
      },
    );

    testWidgets(
      'NumberText',
      (tester) async {
        await tester.pumpApp(const NumberText('123'));
        expect(find.text('123'), findsOneWidget);
      },
    );
  });
}
