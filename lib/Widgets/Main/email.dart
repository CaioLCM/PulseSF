import 'package:flutter/material.dart';

final border_input = new OutlineInputBorder(borderRadius: 
  BorderRadius.circular(12),
  borderSide: const BorderSide(color: Colors.transparent),
  );

class EmailInput extends StatelessWidget{
  
  TextEditingController emailController;

  EmailInput(this.emailController);
  
  @override
  Widget build(BuildContext context) {
      return  Padding(
        padding: const EdgeInsets.fromLTRB(50, 0, 50, 0),
        child: TextField(
                      controller: emailController,
                      decoration: InputDecoration(
                        prefixIcon: Icon(Icons.email),
                        labelText: "Email",
                        enabledBorder: border_input,
                        focusedBorder: border_input,
                        filled: true,
                        fillColor: Colors.grey[100],
        
                      ),
                    ),
      );
  }
} 