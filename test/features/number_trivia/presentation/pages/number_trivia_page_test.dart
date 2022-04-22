import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:hive/hive.dart';
import 'package:mocktail/mocktail.dart';
import 'package:test_driven_development/core/lactor/service_locator.dart';
import 'package:test_driven_development/features/number_trivia/data/models/number_trivia_model.dart';
import 'package:test_driven_development/features/number_trivia/presentation/bloc/number_trivia_bloc.dart';
import 'package:test_driven_development/features/number_trivia/presentation/pages/number_trivia_page.dart';
import 'package:test_driven_development/features/number_trivia/presentation/pages/screen/number_trivia_screen.dart';

import '../../../../helpers/helpers.dart';
import '../../../../helpers/locator_helper.dart';

void main() {
  group('NumberTriviaPage', () {
    setUp(() async {
      await appInit();
      Hive.init('database');
      await Hive.openBox<NumberTriviaModel>('NumberTrivia');
    });
    testWidgets('renders CounterView', (tester) async {
      await tester.pumpApp(const NumberTriviaPage());
      expect(find.byType(NumberTriviaScreen), findsOneWidget);
    });
  });

  /// _________NumberTriviaScreen__________ ///
  group('NumberTriviaScreen', () {
    late NumberTriviaBloc triviaBloc;

    setUp(() {
      triviaBloc = MockNumberTriviaBloc();
    });

    final page = BlocProvider(
      create: (_) => triviaBloc,
      child: NumberTriviaScreen(),
    );

    testWidgets(
      'render initail state',
      (tester) async {
        final state = EmptyState();
        when(() => triviaBloc.state).thenReturn(state);
        await tester.pumpApp(page);
        expect(find.text('NumberTrivia'), findsOneWidget);
        expect(find.byType(SingleChildScrollView), findsWidgets);
      },
    );

    testWidgets(
      'render Error state',
      (tester) async {
        const state = ErrorState('error text');
        when(() => triviaBloc.state).thenReturn(state);
        await tester.pumpApp(page);
        expect(find.text('NumberTrivia'), findsOneWidget);
        expect(find.byType(MassageText), findsWidgets);
        expect(find.text('error text'), findsOneWidget);
      },
    );
  });
}
