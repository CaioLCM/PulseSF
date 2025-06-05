import 'package:flutter/material.dart';

class Friendspage extends StatefulWidget {
  const Friendspage({super.key});

  @override
  State<Friendspage> createState() => _FriendspageState();
}

class _FriendspageState extends State<Friendspage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Friends"),
        backgroundColor: Colors.purple,
        titleTextStyle: TextStyle(
          color: Colors.white,
          fontSize: 17,
          fontFamily: "Fredoka",
        ),
      ),
    );
  }
}