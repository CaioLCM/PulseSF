import 'package:flutter/material.dart';
import 'package:pulsesf/Widgets/SignUp/ConfirmTextField.dart';
import 'package:pulsesf/Widgets/SignUp/CreateAccount.dart';
import 'package:pulsesf/Widgets/SignUp/emailTextField.dart';
import 'package:pulsesf/Widgets/SignUp/nameTextField.dart';
import 'package:pulsesf/Widgets/SignUp/passwordTextField.dart';
import 'package:pulsesf/http/communication.dart';
import 'package:pulsesf/main.dart';

class Signupscreen extends StatefulWidget{
  const Signupscreen({super.key});

  
  @override
  State<Signupscreen> createState() => _SignupscreenState();
}

class _SignupscreenState extends State<Signupscreen> with SingleTickerProviderStateMixin{

  TextEditingController user = TextEditingController();

  TextEditingController email = TextEditingController();

  TextEditingController password = TextEditingController();

  TextEditingController confirmPassword = TextEditingController();

  late AnimationController _controller;
  late Animation<Offset> _offsetAnimation;
  Color pintura = Colors.deepPurple;
  String info = 'Sign up';

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(milliseconds: 400),
      vsync: this,
    );
        _offsetAnimation = TweenSequence<Offset>([
      TweenSequenceItem(tween: Tween(begin: Offset.zero, end: Offset(-0.05, 0)), weight: 1),
      TweenSequenceItem(tween: Tween(begin: Offset(-0.05, 0), end: Offset(0.05, 0)), weight: 2),
      TweenSequenceItem(tween: Tween(begin: Offset(0.05, 0), end: Offset.zero), weight: 1),
    ]).animate(CurvedAnimation(parent: _controller, curve: Curves.elasticIn));
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context){
    return 
    Scaffold(
      backgroundColor: Colors.white,
        body: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text("Create account", style: TextStyle(
              color: Colors.purple[400],
              fontFamily: "Fredoka",
              fontSize: 40,
              fontWeight: FontWeight.w700
            ),),
            Container(
              padding: EdgeInsets.all(15),
              margin: EdgeInsets.all(15),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(15),
                color: Colors.purple[100]
              ),
              child: Column(
              children: [
            Nametextfield(user),
            SizedBox(height: 15,),
            Emailtextfield(email),
            SizedBox(height: 15,),
            Passwordtextfield(password),
            SizedBox(height: 15,),
            Confirmtextfield(confirmPassword)
          ],
              
            )),
            Createaccount(user: user, email: email, password: password, confirmPassword: confirmPassword,),
            SizedBox(height: 10,),
            Text("Already have an account?", style: TextStyle(
              fontFamily: "Fredoka",
              color: Colors.black,
              fontWeight: FontWeight.bold,
              fontSize: 15
            ),),
            TextButton(onPressed: () => {
              Navigator.pop(context)
            }, child: Text("Log in", style: TextStyle(color: Colors.purple, fontFamily: "Fredoka"),))  
        ])
      );
  }
}
