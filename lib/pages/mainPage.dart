import 'package:flutter/material.dart';

class Mainpage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("PulseSF"),),
      body: Column(
        children: [

          Row(
            children: [
              Icon(Icons.place_outlined),
              SizedBox(width: 10),
              Text("Discover Events"),
            ],
          ),
        ],
      ),
    );
  }
}