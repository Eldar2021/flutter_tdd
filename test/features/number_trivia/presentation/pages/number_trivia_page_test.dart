import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:hive/hive.dart';
import 'package:mocktail/mocktail.dart';
import 'package:test_driven_development/core/lactor/service_locator.dart';
import 'package:test_driven_development/features/number_trivia/data/models/number_trivia_model.dart';
import 'package:test_driven_development/features/number_trivia/presentation/cubit/numbertriviacubit_cubit.dart';
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
    late NumbertriviacubitCubit triviaCubit;

    setUp(() {
      triviaCubit = MockNumbertriviacubitCubit();
    });

    final page = BlocProvider(
      create: (_) => triviaCubit,
      child: NumberTriviaScreen(),
    );

    testWidgets(
      'render initail state',
      (tester) async {
        final state = EmptyState();
        when(() => triviaCubit.state).thenReturn(state);
        await tester.pumpApp(page);
        expect(find.text('NumberTrivia'), findsOneWidget);
        expect(find.byType(SingleChildScrollView), findsWidgets);
      },
    );

    testWidgets(
      'render Error state',
      (tester) async {
        const state = ErrorState('error text');
        when(() => triviaCubit.state).thenReturn(state);
        await tester.pumpApp(page);
        expect(find.text('NumberTrivia'), findsOneWidget);
        expect(find.byType(MassageText), findsWidgets);
        expect(find.text('error text'), findsOneWidget);
      },
    );
  });
}
