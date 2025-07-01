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
  
  List<Question> questions = [];
  int index = 0;
  int score = 0;
  bool answered = false; 
  bool loading = true;

  _handleQuizQuestions() async{
    getQuiz(widget.level).then((Loaded){
      setState(() { 
        questions = Loaded;
        loading = false;
      });
    });
  }
  
  void _answerQuestion(String selectedAnswer){
    setState(() {
      answered = true;
      if (selectedAnswer == questions[index].correctAnswer){
        score ++; 
      }   
    });
  }

  void _showResultDialog(){
    showDialog(context: context, 
    barrierDismissible: false,
    builder: (context) => AlertDialog(
      title: Text("Game over"),
      content: Text("Score: $score / ${questions.length}"),
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
      body: Center(
        child: Container(
          padding: EdgeInsets.all(8),
          margin: EdgeInsets.symmetric(vertical: 50),
          child: loading? Center(child: CircularProgressIndicator(),)
          : Column(
            children: [
              Text(questions[index]["Question"]!, style: TextStyle(fontFamily: "Fredoka", fontSize: 25), textAlign: TextAlign.center,),
              SizedBox(height: 15,),
              TextButton( onPressed: () {
                setState(() {
                  index += 1;
                });
              }, child: Text("a) ${questions[index]["Correct answer"]!}", style: TextStyle(fontFamily: "Fredoka", fontSize: 20)),),
              SizedBox(height: 10,),
              TextButton(onPressed: () {
                setState(() {
                  index += 1;
                });
              }, child: Text("b) ${questions[index]["Incorrect answer 1"]!}", style: TextStyle(fontFamily: "Fredoka", fontSize: 20)),),
              SizedBox(height: 10,),
              TextButton(onPressed: () {
                setState(() {
                  index += 1;
                });
              }, child: Text("c) ${questions[index]["Incorrect answer 2"]!}", style: TextStyle(fontFamily: "Fredoka", fontSize: 20)),),
              SizedBox(height: 10,),
              TextButton(onPressed: () {
                setState(() {
                  index += 1;
                });
              }, child: Text("d) ${questions[index]["Incorrect answer 3"]!}", style: TextStyle(fontFamily: "Fredoka", fontSize: 20)),)
            ],
          ),
        ),
      ),
    );
  }
}
