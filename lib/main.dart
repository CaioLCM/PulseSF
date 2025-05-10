import 'package:flutter/material.dart';
import 'package:pulsesf/Widgets/Main/email.dart';
import 'package:pulsesf/Widgets/Main/logInButton.dart';
import 'package:pulsesf/Widgets/Main/password.dart';
import 'package:pulsesf/Widgets/Main/title.dart';

main(){
  runApp(new MyApp());
}

////////////////////////////////////////////////////////////////////////
final emailController = new TextEditingController();
final passwordController = new TextEditingController();
final border = new OutlineInputBorder(borderRadius: BorderRadius.circular(12));
///////////////////////////////////////////////////////////////////////

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return(
      MaterialApp(home: 
        Scaffold(
          backgroundColor: Colors.white,
            body:
            SafeArea(child: 
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(height: 80),
                  MainTitle(),
                  SizedBox(height: 70),
                  Text("Email", style: TextStyle(fontWeight:FontWeight.bold),),
                  SizedBox(height: 10),
                  EmailInput(emailController),
                  SizedBox(height: 40),
                  Text("Password", style: TextStyle(fontWeight: FontWeight.bold),),
                  SizedBox(height: 10),
                  PasswordInput(passwordController),
                  SizedBox(height: 50),
                  Loginbutton(),
                  SizedBox(height: 10),
                  Text("Don't have an account?", style: TextStyle(fontWeight: FontWeight.bold)),
                  TextButton(onPressed: null, child: Text("Sign up"), style: 
                  ButtonStyle(
                    textStyle: WidgetStatePropertyAll(TextStyle(color: Colors.blue))
                  ),)
                ],
            ),
            ),   
        )
      ,)
    );
  }
}