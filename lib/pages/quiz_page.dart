import 'package:flutter/material.dart';
import 'package:pulsesf/pages/quiz_option_page.dart';

class QuizPage extends StatefulWidget {
  final email;
  const QuizPage({super.key, required this.email});

  @override
  State<QuizPage> createState() => _QuizPageState();
}

class _QuizPageState extends State<QuizPage> {

@override
Widget build(BuildContext context) {
  return Scaffold(
    appBar: AppBar(
      backgroundColor: Colors.purple,
      title: const Text(
        "Quiz",
        style: TextStyle(fontFamily: "Fredoka", color: Colors.white),
      ),
    ),
    body: Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 20.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch, 
        children: [
          Text(
            widget.email,
            textAlign: TextAlign.center,
            style: const TextStyle(fontFamily: "Fredoka", fontSize: 20),
          ),
          const SizedBox(height: 24),

          ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.green,
              padding: const EdgeInsets.symmetric(vertical: 20),
              textStyle: const TextStyle(fontSize: 22, fontFamily: "Fredoka"),
            ),
            onPressed: () {
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (_) => QuizOptionPage(email: widget.email, level: "Easy"),
                ),
              );
            },
            child: const Text("Easy", style: TextStyle(color: Colors.white)),
          ),
          const SizedBox(height: 20),

          ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.blue,
              padding: const EdgeInsets.symmetric(vertical: 20),
              textStyle: const TextStyle(fontSize: 22, fontFamily: "Fredoka"),
            ),
            onPressed: () {
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (_) => QuizOptionPage(email: widget.email, level: "medium"),
                ),
              );
            },
            child: const Text("Normal", style: TextStyle(color: Colors.white)),
          ),
          const SizedBox(height: 20),

          ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.red,
              padding: const EdgeInsets.symmetric(vertical: 20),
              textStyle: const TextStyle(fontSize: 22, fontFamily: "Fredoka"),
            ),
            onPressed: () {
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (_) => QuizOptionPage(email: widget.email, level: "hard"),
                ),
              );
            },
            child: const Text("Hard", style: TextStyle(color: Colors.white)),
          ),
        ],
      ),
    ),
  );
  }
}

