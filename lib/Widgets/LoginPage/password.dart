import 'package:flutter/material.dart';

final border_input = OutlineInputBorder(borderRadius: 
  BorderRadius.circular(12),
  borderSide: const BorderSide(color: Colors.transparent),
  );

class PasswordInput extends StatelessWidget{
  
  TextEditingController passwordController;

  PasswordInput(this.passwordController, {super.key});
  
  @override
  Widget build(BuildContext context) {
      return  Padding(
        padding: const EdgeInsets.fromLTRB(50, 0, 50, 0),
        child: TextField(
                      controller: passwordController,
                      style: TextStyle(
                      color: Colors.black
                      ),
                      obscureText: true,
                      decoration: InputDecoration(
                        prefixIcon: Icon(Icons.lock),
                        prefixIconColor: Colors.black,
                        labelText: "Password",
                        labelStyle: TextStyle(
                          fontFamily: "Fredoka",
                          color: Colors.black
                        ),
                        enabledBorder: border_input,
                        focusedBorder: border_input,
                        filled: true,
                        fillColor: Colors.grey[100],
        
                      ),
                    ),
      );
  }
} 