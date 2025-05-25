import 'package:flutter/widgets.dart';
import 'package:flutter/material.dart';

class Emailtextfield extends StatelessWidget {
  TextEditingController controller;
  Emailtextfield(this.controller);

  @override
  Widget build(BuildContext context) {
    return TextField(
              controller: controller,
              obscureText: false,
              decoration:InputDecoration(
              labelText: "E-mail",
              prefixIcon: Icon(Icons.email),
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