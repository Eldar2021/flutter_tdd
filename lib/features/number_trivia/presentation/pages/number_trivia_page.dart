import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/lactor/service_locator.dart';
import '../bloc/number_trivia_bloc.dart';
import 'screen/number_trivia_screen.dart';

class NumberTriviaPage extends StatelessWidget {
  const NumberTriviaPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => sl<NumberTriviaBloc>(),
      child: NumberTriviaScreen(),
    );
  }
}
