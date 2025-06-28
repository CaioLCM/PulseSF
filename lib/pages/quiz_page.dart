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
        title: Text(
          "Quiz",
          style: TextStyle(fontFamily: "Fredoka", color: Colors.white),
        ),
      ),
      body: Center(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              margin: EdgeInsets.only(top: 20),
              child: Column(
                children: [
                  Text(
                    widget.email,
                    style: TextStyle(fontFamily: "Fredoka", fontSize: 20),
                  ),
                  SizedBox(height: 10),
                  Text("Easy: 0"),
                  SizedBox(height: 5),
                  Container(
                    margin: EdgeInsets.symmetric(horizontal: 10),
                    child: LinearProgressIndicator(
                      value: 0.5,
                      minHeight: 16,
                      backgroundColor: Colors.green[100],
                      valueColor: AlwaysStoppedAnimation<Color>(Colors.green),
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                  SizedBox(height: 15),
                  Text("Normal: 0"),
                  SizedBox(height: 5),
                  Container(
                    margin: EdgeInsets.symmetric(horizontal: 10),
                    child: LinearProgressIndicator(
                      value: 0.5,
                      minHeight: 16,
                      backgroundColor: Colors.blue[700],
                      valueColor: AlwaysStoppedAnimation<Color>(Colors.blue),
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: 15),
            Text("Hard: 0"),
            SizedBox(height: 5),
            GestureDetector(
              onTap: () {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder:
                        (_) =>
                            QuizOptionPage(email: widget.email, level: "easy"),
                  ),
                );
              },
              child: Container(
                margin: EdgeInsets.symmetric(horizontal: 10),
                child: LinearProgressIndicator(
                  value: 0.5,
                  minHeight: 16,
                  backgroundColor: Colors.red[700],
                  valueColor: AlwaysStoppedAnimation<Color>(Colors.red),
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
            ),
            SizedBox(height: 30),
            GestureDetector(
              onTap: () {
/*                 Navigator.of(context).push(
                  MaterialPageRoute(
                    builder:
                        (_) => QuizOptionPage(
                          email: widget.email,
                          level: "normal",
                        ),
                  ),
                ); */
              },
              child: GestureDetector(
                onTap: () {
                  //Navigator.of(context).push(MaterialPageRoute(builder: (_) => QuizOptionPage(email: widget.email, level: "hard")));
                },
                child: Container(
                  margin: EdgeInsets.symmetric(horizontal: 10),
                  padding: EdgeInsets.all(30),
                  alignment: Alignment.center,
                  width: double.infinity,
                  decoration: BoxDecoration(
                    color: Colors.green,
                    borderRadius: BorderRadiusDirectional.circular(10),
                  ),
                  child: Text("Easy", style: TextStyle(fontFamily: "Fredoka")),
                ),
              ),
            ),
            SizedBox(height: 15),
            Container(
              margin: EdgeInsets.symmetric(horizontal: 10),
              padding: EdgeInsets.all(30),
              alignment: Alignment.center,
              width: double.infinity,
              decoration: BoxDecoration(
                color: Colors.blue,
                borderRadius: BorderRadiusDirectional.circular(10),
              ),
              child: Text("Normal", style: TextStyle(fontFamily: "Fredoka")),
            ),
            SizedBox(height: 15),
            Container(
              margin: EdgeInsets.symmetric(horizontal: 10),
              padding: EdgeInsets.all(30),
              alignment: Alignment.center,
              width: double.infinity,
              decoration: BoxDecoration(
                color: Colors.red,
                borderRadius: BorderRadiusDirectional.circular(10),
              ),
              child: Text("Hard", style: TextStyle(fontFamily: "Fredoka")),
            ),
          ],
        ),
      ),
    );
  }
}
