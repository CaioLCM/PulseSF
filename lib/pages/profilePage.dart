import 'package:flutter/material.dart';
import 'package:pulsesf/pages/mainPage.dart';

class Profilepage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          SizedBox(height: 30),
          Row(
            children: [
              SizedBox(width: 120,),
              CircleAvatar(
                radius: 90,
              ),
            ],
          ),
          SizedBox(height: 20,),
          Text("User name", style: TextStyle(
            fontSize: 30
          ),),
          SizedBox(height: 8,),
          Text("User email", style: TextStyle(fontSize: 20),),
          SizedBox(height: 20,),
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
                Text("Bio", style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold
                ),),
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
                Icon(Icons.calendar_month),
                SizedBox(width: 10),
                Text("Participated Events", style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold
                ),),
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
                Text("Active Projects", style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold
                ),),
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
                Icon(Icons.people),
                SizedBox(width: 10),
                Text("Friends", style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold
                ),),
              ],
            ),
          ),
          IconButton(onPressed:() => {
                                        Navigator.push(context, MaterialPageRoute(builder: (builder) => Mainpage()))
                                      }, icon: Icon(Icons.subdirectory_arrow_left_sharp))
        ],
      ),
    );
  }
}