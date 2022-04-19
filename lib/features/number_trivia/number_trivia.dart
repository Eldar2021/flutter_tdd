import 'package:equatable/equatable.dart';

class NumBerTrivia extends Equatable {
  const NumBerTrivia({
    required this.text,
    required this.number,
  });

  final String text;
  final int number;

  @override
  List<Object?> get props => [text, number];
}
