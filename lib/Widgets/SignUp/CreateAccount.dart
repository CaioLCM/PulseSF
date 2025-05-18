import 'package:flutter/material.dart';
import 'package:pulsesf/http/communication.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Createaccount extends StatefulWidget {
  final TextEditingController user;
  final TextEditingController email;
  final TextEditingController password;
  final TextEditingController confirmPassword;

  Createaccount({
    required this.user,
    required this.email,
    required this.password,
    required this.confirmPassword,
  });

  @override
  State<Createaccount> createState() => _CreateaccountState();
}

class _CreateaccountState extends State<Createaccount> with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<Offset> _offsetAnimation;
  bool valid = true;
  Color pintura = Colors.deepPurple;
  String info = 'Sign Up';
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
    return Center(
      child: SlideTransition(
        position: _offsetAnimation,
        child: ElevatedButton(
          onPressed: (loading || _controller.isAnimating) ? null : () async {
            if (widget.password.text != widget.confirmPassword.text) {
              setState(() {
                pintura = Colors.red;
                info = 'Passwords do not match!';
              });
              _controller.forward(from: 0);
              Future.delayed(Duration(seconds: 2), () {
                if (mounted) {
                  setState(() {
                    pintura = Colors.deepPurple;
                    info = 'Sign Up';
                  });
                }
              });
              return;
            }

            setState(() {
              loading = true;
            });

            valid = await CreateAccount(
              widget.user.text,
              widget.email.text,
              widget.confirmPassword.text,
              context,
            );

            if (!valid) {
              setState(() {
                pintura = Colors.red;
                info = 'Invalid info!';
              });
              _controller.forward(from: 0);
              Future.delayed(Duration(seconds: 2), () {
                if (mounted) {
                  setState(() {
                    pintura = Colors.deepPurple;
                    info = 'Sign Up';
                  });
                }
              });
            }

            setState(() {
              loading = false;
            });
          },
          style: ElevatedButton.styleFrom(
            backgroundColor: pintura,
            padding: EdgeInsets.symmetric(horizontal: 50, vertical: 8),
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
            textStyle: TextStyle(fontSize: 20),
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
              : Text(info, style: TextStyle(color: Colors.white)),
        ),
      ),
    );
  }
}
