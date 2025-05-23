import 'package:flutter/widgets.dart';
import 'package:flutter/material.dart';

class Nametextfield extends StatelessWidget {
  TextEditingController email;

  Nametextfield(this.email);

  @override
  Widget build(BuildContext context) {
    return TextField(
              controller: email,
              decoration: InputDecoration(
              labelText: "Name",
              prefixIcon: Icon(Icons.person),
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