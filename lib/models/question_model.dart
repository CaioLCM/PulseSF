class Question {
  final String questionText;
  final String correctAnswer;
  final List<String> allAnswers;

  Question({required this.questionText, required this.correctAnswer, required this.allAnswers});

  factory Question.fromJson(Map<String, dynamic> json){
    List<String> incorrects = List<String>.from(json['incorrect_answers']);
    String correct = json["correct_answer"];

    List<String> all = [...incorrects, correct];

    all.shuffle();

    return Question(
      questionText: json["question"], 
      correctAnswer: correct, 
      allAnswers: all);
  }
}