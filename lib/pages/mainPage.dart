import 'package:flutter/material.dart';

class Mainpage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          SizedBox(height: 40,),
          Text("PulseSF", style: TextStyle(
                color: Colors.purple[400],
                fontSize: 40,
                fontWeight: FontWeight.bold
                )
        ),
          Container(
             padding: EdgeInsets.all(16),
            margin: EdgeInsets.only(bottom: 16),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(12),
              color: Colors.grey[200]
            ),
            child: Row(
              children: [
                SizedBox(width: 10,),
                Icon(Icons.place_outlined),
                SizedBox(width: 10),
                Text("Discover Events"),
              ],
            ),
          ),
          Container(
             padding: EdgeInsets.all(16),
            margin: EdgeInsets.only(bottom: 16),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(12),
              color: Colors.grey[200]
            ),
            child: Row(
              children: [
                SizedBox(width: 10,),
                Icon(Icons.code),
                SizedBox(width: 10),
                Text("Match a coding buddy"),
              ],
            ),
          ),
          Container(
            padding: EdgeInsets.all(16),
            margin: EdgeInsets.only(bottom: 16),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(12),
              color: Colors.grey[200]
            ),
            child: Row(
              children: [
                SizedBox(width: 10,),
                Icon(Icons.precision_manufacturing),
                SizedBox(width: 10),
                Text("Create/join projects"),
              ],
            ),
          ),
                    Container(
                       padding: EdgeInsets.all(16),
            margin: EdgeInsets.only(bottom: 16),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(12),
              color: Colors.grey[200]
            ),
                      child: Row(
                                  children: [
                                    SizedBox(width: 10,),
                                    Icon(Icons.person),
                                    SizedBox(width: 10),
                                    Text("Profile"),
                                  ],
                                ),
                    ),
        ],
      ),
    );
  }
}