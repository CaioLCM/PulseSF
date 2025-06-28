import 'package:flutter/material.dart';

class QuizOptionPage extends StatefulWidget {
  final String email;
  final String level;
  const QuizOptionPage({super.key, required this.email, required this.level});

  @override
  State<QuizOptionPage> createState() => _QuizOptionPageState();
}

class _QuizOptionPageState extends State<QuizOptionPage> {
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
    );
  }
}
