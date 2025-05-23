import 'package:flutter/widgets.dart';
import 'package:flutter/material.dart';

class Confirmtextfield extends StatelessWidget {
  TextEditingController controller;
  Confirmtextfield(this.controller);

  @override
  Widget build(BuildContext context) {
    return TextField(
              controller: controller,
              obscureText: true,
              decoration:InputDecoration(
              labelText: "Confirm Password",
              prefixIcon: Icon(Icons.password),
              labelStyle: TextStyle(color: Colors.black),
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