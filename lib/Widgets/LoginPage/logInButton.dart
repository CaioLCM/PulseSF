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
  bool loading = false;

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
      ElevatedButton(
        onPressed: (loading || _controller.isAnimating) ? null : () async {
          setState(() {
            loading = true;
          });
          final exists = await verifyAccount(widget.email.text, widget.password.text, context);
          if (exists == false){
            setState(() {
              pintura = Colors.red;
              info = 'Invalid account!';
              loading = false;
            });
            _controller.forward(from: 0);
          } else {
            setState(() {
              widget.email.text = '';
              widget.password.text = '';
              loading = false;
            });
          }
          Future.delayed(Duration(seconds: 2), () {
            setState(() {
              pintura = Colors.deepPurple;
              info = 'Log in';
            });
          });
        },
        style: ElevatedButton.styleFrom(
          backgroundColor: pintura,
          padding: EdgeInsets.symmetric(horizontal: 100, vertical: 15),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
          textStyle: TextStyle(fontSize: 20)
        ),
        child: loading
        ? SizedBox(
              width: 24,
              height: 24,
              child: CircularProgressIndicator(
                color: Colors.white,
                strokeWidth: 2,
              ),
            )
        : Text(info, style: TextStyle(color: Colors.white, fontFamily: "Fredoka")),
      ),
    );
  }
} 