import 'package:flutter/material.dart';
import 'package:pulsesf/pages/Signupscreen.dart';

class Signupbutton extends StatelessWidget{
    
  @override
  Widget build(BuildContext context) {
      return TextButton(onPressed: () {
        Navigator.push(context, MaterialPageRoute(builder: (builder) => Signupscreen()));
      }, child: Text("Sign up"), style: 
                  ButtonStyle(
                    textStyle: WidgetStatePropertyAll(TextStyle(color: Colors.blue, fontFamily: "Fredoka"))
                  ),);
      
  }
} 