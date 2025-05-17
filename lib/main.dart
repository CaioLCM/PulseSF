import 'package:flutter/material.dart';
import 'package:pulsesf/Widgets/Main/email.dart';
import 'package:pulsesf/Widgets/Main/logInButton.dart';
import 'package:pulsesf/Widgets/Main/password.dart';
import 'package:pulsesf/Widgets/Main/signupButton.dart';
import 'package:pulsesf/Widgets/Main/title.dart';
import 'package:zhi_starry_sky/starry_sky.dart';
import 'package:easy_dynamic_theme/easy_dynamic_theme.dart';
import 'package:animated_text_kit/animated_text_kit.dart';

main(){
  runApp(EasyDynamicThemeWidget(child: MyApp()));
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
                  MainTitle(),
                  SizedBox(height: 40),
                  Text("Email", style: TextStyle(fontWeight:FontWeight.bold),),
                  SizedBox(height: 10),
                  EmailInput(emailController),
                  SizedBox(height: 20),
                  Text("Password", style: TextStyle(fontWeight: FontWeight.bold),),
                  SizedBox(height: 10),
                  PasswordInput(passwordController),
                  SizedBox(height: 50),
                  Loginbutton(email: emailController, password: passwordController),
                  SizedBox(height: 10),
                  Text("Don't have an account?", style: TextStyle(fontWeight: FontWeight.bold)),
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