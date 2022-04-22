import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../bloc/number_trivia_bloc.dart';

class NumberTriviaScreen extends StatelessWidget {
  NumberTriviaScreen({Key? key}) : super(key: key);

  final controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('NumberTrivia')),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(10),
          child: Column(
            children: [
              const SizedBox(height: 20),
              Center(
                child: BlocBuilder<NumberTriviaBloc, NumberTriviaState>(
                  builder: (context, state) {
                    if (state is EmptyState) {
                      return const NumberText('Empty');
                    } else if (state is LoadingState) {
                      return const Center(child: CircularProgressIndicator());
                    } else if (state is SuccessState) {
                      return NumberText(state.trivia.number.toString());
                    } else if (state is ErrorState) {
                      return const NumberText('NotFound');
                    } else {
                      return const NumberText('State is not fount');
                    }
                  },
                ),
              ),
              const SizedBox(height: 30),
              SizedBox(
                height: MediaQuery.of(context).size.height / 3,
                child: SingleChildScrollView(
                  child: BlocBuilder<NumberTriviaBloc, NumberTriviaState>(
                    builder: (context, state) {
                      if (state is EmptyState) {
                        return const MassageText('Number Trivia');
                      } else if (state is LoadingState) {
                        return const Center(child: CircularProgressIndicator());
                      } else if (state is SuccessState) {
                        return MassageText(state.trivia.text);
                      } else if (state is ErrorState) {
                        return MassageText(state.message);
                      } else {
                        return const MassageText('State is not fount');
                      }
                    },
                  ),
                ),
              ),
              const SizedBox(height: 30),
              TextField(
                controller: controller,
                decoration: InputDecoration(
                  border: InputBorder.none,
                  hintText: 'Search text',
                  filled: true,
                  fillColor: Colors.grey,
                  focusedBorder: OutlineInputBorder(
                    borderSide: const BorderSide(color: Colors.red),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  enabledBorder: UnderlineInputBorder(
                    borderSide: const BorderSide(color: Colors.grey),
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
              ),
              const SizedBox(height: 30),
              Row(
                children: [
                  Expanded(
                    child: ElevatedButton(
                      onPressed: () {
                        context.read<NumberTriviaBloc>().add(
                              GetConcreteNumber(controller.text),
                            );
                      },
                      child: const Text('Search'),
                    ),
                  ),
                  const SizedBox(width: 10),
                  Expanded(
                    child: ElevatedButton(
                      onPressed: () {
                        context.read<NumberTriviaBloc>().add(GetRandomNumber());
                      },
                      child: const Text('Search'),
                    ),
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}

class MassageText extends StatelessWidget {
  const MassageText(
    this.massage, {
    Key? key,
  }) : super(key: key);

  final String massage;

  @override
  Widget build(BuildContext context) {
    return Text(
      massage,
      textAlign: TextAlign.center,
      style: Theme.of(context).textTheme.headline6,
    );
  }
}

class NumberText extends StatelessWidget {
  const NumberText(
    this.val, {
    Key? key,
  }) : super(key: key);

  final String val;

  @override
  Widget build(BuildContext context) {
    return Text(
      val,
      style: Theme.of(context).textTheme.headline2,
    );
  }
}
