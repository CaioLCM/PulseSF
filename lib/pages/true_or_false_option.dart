import 'package:flutter/material.dart';
import 'package:pulsesf/http/communication.dart';
import 'package:pulsesf/models/question_model.dart';
import 'package:pulsesf/models/true_or_false_model.dart';

class TrueOrFalseOption extends StatefulWidget {
  final String email;
  final String level;
  const TrueOrFalseOption({super.key, required this.email, required this.level});

  @override
  State<TrueOrFalseOption> createState() => _TrueOrFalsePageState();
}

class _TrueOrFalsePageState extends State<TrueOrFalseOption> {
  late Future<List<TrueOrFalseModel>> questionsFuture;
  
  int index = 0;
  int score = 0;
  bool answered = false; 

  
  void _answerQuestion(String selectedAnswer, List<TrueOrFalseModel> questions){
    setState(() {
      answered = true;
      if (selectedAnswer == questions[index].answer){
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
          _showResultDialog();
        }
      });
    });
  }

  void _showResultDialog(){
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
    questionsFuture = getTrueOrFalseQuiz(widget.level);
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
                Text(currentQuestion.question, textAlign: TextAlign.center,),
                SizedBox(height: 30,),
                  // Example answer buttons for True/False
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 8),
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: answered
                            ? (currentQuestion.answer == "True"
                                ? Colors.green
                                : Colors.red)
                            : Colors.purple,
                        padding: const EdgeInsets.symmetric(vertical: 16),
                        textStyle: const TextStyle(
                          fontSize: 18, fontFamily: "Fredoka"
                        ),
                      ),
                      onPressed: answered
                          ? null
                          : () => _answerQuestion("True", questions),
                      child: const Text("True", style: TextStyle(color: Colors.white)),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 8),
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: answered
                            ? (currentQuestion.answer == "False"
                                ? Colors.green
                                : Colors.red)
                            : Colors.purple,
                        padding: const EdgeInsets.symmetric(vertical: 16),
                        textStyle: const TextStyle(
                          fontSize: 18, fontFamily: "Fredoka"
                        ),
                      ),
                      onPressed: answered
                          ? null
                          : () => _answerQuestion("False", questions),
                      child: const Text("False", style: TextStyle(color: Colors.white)),
                    ),
                  ),
                ],
              ),
            );
          }
        ),
      );
    }
  }