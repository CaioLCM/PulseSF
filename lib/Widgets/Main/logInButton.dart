import 'package:flutter/material.dart';
import 'package:pulsesf/http/communication.dart';
import 'package:pulsesf/pages/mainPage.dart';

class Loginbutton extends StatelessWidget{
  final TextEditingController email;
  final TextEditingController password;

  Loginbutton({required this.email, required this.password});

  @override
  Widget build(BuildContext context) {
      return ElevatedButton(onPressed: () {
        verifyAccount(email.text, password.text, context);

      }, child: Text("Log in"), 
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.deepPurple,
                    padding: EdgeInsets.symmetric(horizontal: 50, vertical: 8),
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                    textStyle: TextStyle(fontSize: 20)
                  ),
      );
  }
} 