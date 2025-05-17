import 'package:flutter/material.dart';

final border_input = new OutlineInputBorder(borderRadius: 
  BorderRadius.circular(12),
  borderSide: const BorderSide(color: Colors.transparent),
  );

class PasswordInput extends StatelessWidget{
  
  TextEditingController passwordController;

  PasswordInput(this.passwordController);
  
  @override
  Widget build(BuildContext context) {
      return  Padding(
        padding: const EdgeInsets.fromLTRB(50, 0, 50, 0),
        child: TextField(
                      controller: passwordController,
                      obscureText: true,
                      decoration: InputDecoration(
                        prefixIcon: Icon(Icons.lock),
                        labelText: "Password",
                        enabledBorder: border_input,
                        focusedBorder: border_input,
                        filled: true,
                        fillColor: Colors.grey[100],
        
                      ),
                    ),
      );
  }
} 