import 'package:flutter/widgets.dart';
import 'package:flutter/material.dart';

class Passwordtextfield extends StatelessWidget {
  TextEditingController controller;
  Passwordtextfield(this.controller, {super.key});

  @override
  Widget build(BuildContext context) {
    return TextField(
              controller: controller,
              obscureText: true,
              style: TextStyle(
                color: Colors.black,
                fontFamily: "Fredoka"
              ),
              decoration:InputDecoration(
              labelText: "Password",
              prefixIcon: Icon(Icons.password),
              labelStyle: TextStyle(color: Colors.black, fontFamily: "Fredoka"),
              prefixIconColor: Colors.black,
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(13) 
              ),
              filled: true,
              fillColor: Colors.grey[100]
            ),
            );
  }
}