import '../../domain/entities/number_trivia.dart';

class NumberTriviaModel extends NumBerTrivia {
  const NumberTriviaModel({
    required String text,
    required int number,
  }) : super(text: text, number: number);

  factory NumberTriviaModel.fromJson(Map<String, dynamic> json) {
    return NumberTriviaModel(
      text: json['text'] as String,
      number: (json['number'] as num).toInt(),
    );
  }

  Map<String, dynamic> toJson() {
    return <String, dynamic>{
      'text': text,
      'number': number,
    };
  }
}
