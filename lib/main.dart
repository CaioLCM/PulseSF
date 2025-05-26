import 'package:flutter/material.dart';
import 'package:pulsesf/Widgets/LoginPage/email.dart';
import 'package:pulsesf/Widgets/LoginPage/logInButton.dart';
import 'package:pulsesf/Widgets/LoginPage/password.dart';
import 'package:pulsesf/Widgets/LoginPage/signUpButton.dart';

import 'package:pulsesf/Widgets/LoginPage/title.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:zhi_starry_sky/starry_sky.dart';
import 'package:easy_dynamic_theme/easy_dynamic_theme.dart';
import 'package:animated_text_kit/animated_text_kit.dart';

main(){
  runApp(EasyDynamicThemeWidget(child: MyApp()));
}

////////////////////////////////////////////////////////////////////////
final emailController = TextEditingController();
final passwordController = TextEditingController();
final border = OutlineInputBorder(borderRadius: BorderRadius.circular(12));
///////////////////////////////////////////////////////////////////////

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> with SingleTickerProviderStateMixin{
  late AnimationController _controller;
  late Animation<double> _wiggle;
  
  @override
  void initState() {
    super.initState();
    DeleteData();
    _controller = AnimationController(vsync: this, duration: Duration(milliseconds: 500))..repeat(reverse: true);
    _wiggle = Tween<double>(begin: -0.05, end: 0.05).animate(_controller);
  }

  Future<void> DeleteData() async{
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.clear();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return( 
      MaterialApp(
        theme: ThemeData.light(),
        darkTheme: ThemeData.dark(),
        themeMode: EasyDynamicTheme.of(context).themeMode,
        home:
        Scaffold(
          backgroundColor: Colors.white,
            body: Stack(
              children: [
            const StarrySkyView(),
            SafeArea(child: 
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                  AnimatedBuilder(animation: _wiggle,
                    builder: (context, child) => Transform.rotate(angle: _wiggle.value, child: child,),
                    child: Text("PulseSF", style: TextStyle(color: Colors.purple[400], fontSize: 80, fontFamily: "Fredoka", fontWeight: FontWeight.w700)),
                  ),
                  SizedBox(height: 40),
                  Text("Email", style: TextStyle(fontWeight:FontWeight.w700, fontFamily: "Fredoka"),),
                  SizedBox(height: 10),
                  EmailInput(emailController),
                  SizedBox(height: 20),
                  Text("Password", style: TextStyle(fontWeight:FontWeight.w700, fontFamily: "Fredoka"),),
                  SizedBox(height: 10),
                  PasswordInput(passwordController),
                  SizedBox(height: 50),
                  Loginbutton(email: emailController, password: passwordController),
                  SizedBox(height: 10),
                  Text("Don't have an account?", style: TextStyle(fontWeight:FontWeight.w700, fontFamily: "Fredoka")),
                  Signupbutton()
                ],
            ),
            ),   
              ],
            )
 
        )
      ,)
    );
 
  }
}