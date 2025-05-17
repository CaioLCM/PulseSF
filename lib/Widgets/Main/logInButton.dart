import 'package:flutter/material.dart';
import 'package:pulsesf/http/communication.dart';
import 'package:pulsesf/pages/mainPage.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Loginbutton extends StatefulWidget{
  final TextEditingController email;
  final TextEditingController password;

  Loginbutton({required this.email, required this.password});

  @override
  State<Loginbutton> createState() => _LoginbuttonState();
}

class _LoginbuttonState extends State<Loginbutton> with SingleTickerProviderStateMixin{
  late AnimationController _controller;
  late Animation<Offset> _offsetAnimation;
  Color pintura = Colors.deepPurple;
  String info = 'Log in';

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
  Widget build(BuildContext context) {
      return SlideTransition(position: _offsetAnimation, 
      child:
      ElevatedButton(onPressed: () async {
        verifyAccount(widget.email.text, widget.password.text, context);
          setState(() {
              _controller.forward(from: 0);
              pintura = Colors.red;
              info = 'Invalid account!';
          });
          Future.delayed(Duration(seconds: 2), () {
            setState(() {
              pintura = Colors.deepPurple;
              info = 'Log in';
            });
          });
      }, child: Text(info, style: TextStyle(color: Colors.white),), 
                  style: ElevatedButton.styleFrom(
                    backgroundColor: pintura,
                    padding: EdgeInsets.symmetric(horizontal: 50, vertical: 8),
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                    textStyle: TextStyle(fontSize: 20)
                  ),
      ) ,);
      
  }
} 