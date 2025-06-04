import 'package:flutter/material.dart';

class Friendspage extends StatefulWidget {

  @override
  State<Friendspage> createState() => _MyWidgetState();
}

class _MyWidgetState extends State<Friendspage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Friends"), backgroundColor: Colors.purple, titleTextStyle: TextStyle(color: Colors.white, fontSize: 17, fontFamily: "Fredoka"),),
    );
  }
}