class TrueOrFalseModel {
  final String question;
  final String answer;
  TrueOrFalseModel({required this.question, required this.answer});

  factory TrueOrFalseModel.fromJson(Map<String, dynamic> json) {
    return TrueOrFalseModel(
      question: json['question'],
      answer: json['correct_answer'],
    );
  }
}
