import 'package:flutter/material.dart';
import 'package:pulsesf/Widgets/SignUp/CreateAccount.dart';
import 'package:pulsesf/http/communication.dart';

class Signupscreen extends StatefulWidget{
  
  @override
  State<Signupscreen> createState() => _SignupscreenState();
}

class _SignupscreenState extends State<Signupscreen> with SingleTickerProviderStateMixin{

  TextEditingController user = new TextEditingController();

  TextEditingController email = new TextEditingController();

  TextEditingController password = new TextEditingController();

  TextEditingController confirmPassword = new TextEditingController();

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
              fontSize: 40,
              fontWeight: FontWeight.bold
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
                 TextField(
              controller: user,
              decoration: InputDecoration(
              labelText: "Name",
              prefixIcon: Icon(Icons.person),
              labelStyle: TextStyle(color: Colors.black),
              prefixIconColor: Colors.black,
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(13) 
              ),
              filled: true,
              fillColor: Colors.grey[100]
            ),
            ),
            SizedBox(height: 15,),
            TextField(
              controller: email,
              decoration: InputDecoration(
              labelText: "Email",
              prefixIcon: Icon(Icons.email),
              labelStyle: TextStyle(color: Colors.black),
              prefixIconColor: Colors.black,
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(13) 
              ),
              filled: true,
              fillColor: Colors.grey[100]
            ),
            ),
            SizedBox(height: 15,),
            TextField(controller: password, obscureText: true, decoration: InputDecoration(
              labelText: "Password",
              prefixIcon: Icon(Icons.password),
              labelStyle: TextStyle(color: Colors.black),
              prefixIconColor: Colors.black,
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(13) 
              ),
              filled: true,
              fillColor: Colors.grey[100]
            ),
            ),
            SizedBox(height: 15,),
            TextField(
              controller: confirmPassword,
              obscureText: true,
              decoration:InputDecoration(
              labelText: "Confirm Password",
              prefixIcon: Icon(Icons.password),
              labelStyle: TextStyle(color: Colors.black),
              prefixIconColor: Colors.black,
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(13) 
              ),
              filled: true,
              fillColor: Colors.grey[100]
            ),
            ),
          ],
              
            )),
            Createaccount(user: user, email: email, password: password, confirmPassword: confirmPassword,),
            SizedBox(height: 10,),
            Text("Already have an account?", style: TextStyle(
              color: Colors.black,
              fontWeight: FontWeight.bold,
              fontSize: 15
            ),),
            TextButton(onPressed: () => {
              Navigator.pop(context)
            }, child: Text("Log in", style: TextStyle(color: Colors.purple),))  
        ])
      );
  }
}
