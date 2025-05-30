import 'package:flutter/material.dart';
import 'package:pulsesf/pages/Signupscreen.dart';

class Signupbutton extends StatelessWidget {
  const Signupbutton({super.key});

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (builder) => Signupscreen()),
        );
      },
      style: ButtonStyle(
        textStyle: WidgetStatePropertyAll(
          TextStyle(color: Colors.blue, fontFamily: "Fredoka"),
        ),
      ),
      child: Text("Sign up"),
    );
  }
}
