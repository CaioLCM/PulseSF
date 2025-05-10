import 'package:flutter/material.dart';

class Loginbutton extends StatelessWidget{
    
  @override
  Widget build(BuildContext context) {
      return ElevatedButton(onPressed: null, child: Text("Log in"), 
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.deepPurple,
                    padding: EdgeInsets.symmetric(horizontal: 50, vertical: 8),
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                    textStyle: TextStyle(fontSize: 20)
                  )
      );
  }
} 