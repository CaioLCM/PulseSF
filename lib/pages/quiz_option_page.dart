import 'package:flutter/material.dart';
import 'package:pulsesf/http/communication.dart';
import 'package:pulsesf/models/question_model.dart';

class QuizOptionPage extends StatefulWidget {
  final String email;
  final String level;
  const QuizOptionPage({super.key, required this.email, required this.level});

  @override
  State<QuizOptionPage> createState() => _QuizOptionPageState();
}

class _QuizOptionPageState extends State<QuizOptionPage> {
  late Future<List<Question>> questionsFuture;
  
  int index = 0;
  int score = 0;
  bool answered = false; 

  _handleUpdateUserPoints() async{
    int totalPoints = 0;
    if (widget.level == "easy"){
      totalPoints = 1;
    }

    else if (widget.level == "medium"){
      totalPoints = 3;
    }

    else {
      totalPoints = 5;
    }

    await addPointsToUser(widget.email, totalPoints);
  }

  void _answerQuestion (String selectedAnswer, List<Question> questions){
    setState(() {
      answered = true;
      if (selectedAnswer == questions[index].correctAnswer){
        score ++;
      }   
    });

    Future.delayed(const Duration(milliseconds: 1500), (){
      if (!mounted) return;
      setState(() {
        if (index < questions.length - 1){
          index ++;
          answered = false;
        } else {
          _showResultDialog(questions.length);
        }
      });
    });
  }

  void _showResultDialog(int totalQuestions){
    int poinsPerCorrectAnswer = 0;
    if (widget.level == "easy"){
      poinsPerCorrectAnswer = 1;
    } else if (widget.level == "medium"){
      poinsPerCorrectAnswer = 3;
    } else {
      poinsPerCorrectAnswer = 5;
    }

    final int finalPoints = score * poinsPerCorrectAnswer;

    if (finalPoints > 0){
      addPointsToUser(widget.email, finalPoints);
    }

    showDialog(context: context, 
    barrierDismissible: false,
    builder: (context) => AlertDialog(
      title: Text("Game over"),
      content: Text("Score: $score / 10"),
      actions: [
        TextButton(onPressed: (){
          Navigator.of(context).pop();
          Navigator.of(context).pop();
        }, child: Text("Ok"))
      ],
    ));
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    questionsFuture = getQuiz(widget.level);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          widget.level,
          style: TextStyle(fontFamily: "Fredoka", color: Colors.white),
        ),
        backgroundColor: Colors.purple,
      ),
      body: FutureBuilder(future: questionsFuture, builder: (context, snapshot){
        if (snapshot.connectionState == ConnectionState.waiting){
          return const Center(child: CircularProgressIndicator(),);
        }

        if (snapshot.hasError || !snapshot.hasData || snapshot.data!.isEmpty){
          return const Center(
            child: Text("Not possible to load the questions"),
          );
        }

        final questions = snapshot.data!;
        final currentQuestion = questions[index];

          return SingleChildScrollView(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Text("Question ${index + 1}/10", textAlign: TextAlign.center,),
                SizedBox(height: 20,),
                Text(currentQuestion.questionText, textAlign: TextAlign.center,),
                SizedBox(height: 30,),
                ...currentQuestion.allAnswers.map((answer){
                  Color buttonColor = Colors.deepPurple;
                  if (answered){
                    buttonColor = (answer == currentQuestion.correctAnswer)
                    ? Colors.green
                    : Colors.red;
                  }

                  return Padding(
                    padding: const EdgeInsets.symmetric(vertical: 8),
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: buttonColor,
                        padding: const EdgeInsets.symmetric(vertical: 16),
                        textStyle: TextStyle(
                          fontSize: 18, fontFamily: "Fredoka"
                        )
                      ),
                      onPressed: answered? null : () => _answerQuestion(answer, questions),
                     child: Text(answer, style: TextStyle(color: Colors.white),),
                    ),
                  );
                })
              ],
            ),
          );
        })
      );
    }
  }
