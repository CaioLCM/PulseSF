import 'package:flutter/material.dart';
import 'package:pulsesf/main.dart';
import 'package:pulsesf/pages/profilePage.dart';
import 'package:pulsesf/pages/projectsPage.dart';

class Mainpage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        children: [
          Container(
            padding: EdgeInsets.all(18),
            decoration: BoxDecoration(
              color: Colors.purple[400]
            ),
            child: 
               Column(
                children: [
                  SizedBox(height: 15,),
                  Row(
                    children: [
                        SizedBox(width: 130,),
                        Text("Menu options", style: TextStyle(
                              color: Colors.white,
                              fontSize: 20,
                              fontWeight: FontWeight.bold
                              )
                                ),
                    ],
                  ),
                ],
            ),
          ),
                    Container(
            padding: EdgeInsets.all(16),
            margin: EdgeInsets.fromLTRB(10, 8, 10, 15),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(12),
              color: Colors.grey[200]
            ),
            child: Row(
              children: [
                SizedBox(width: 10,),
                Icon(Icons.precision_manufacturing),
                SizedBox(width: 10),
                 TextButton(onPressed: ()=>{
                                       Navigator.push(context, MaterialPageRoute(builder: (builder) => Projectspage()))
                                    }, child: Text("Projects", style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold
                ),
                ),
                )
              ],
            ),
          ),
                    Container(
                       padding: EdgeInsets.all(16),
            margin: EdgeInsets.fromLTRB(10, 8, 10, 15),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(12),
              color: Colors.grey[200]
            ),
                      child: Row(
                                  children: [
                                    SizedBox(width: 10,),
                                    Icon(Icons.person),
                                    SizedBox(width: 10),
                                    TextButton(onPressed: ()=>{
                                       Navigator.push(context, MaterialPageRoute(builder: (builder) => Profilepage()))
                                    }, child: Text("Profile", style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold
                ),),)
                                  ],
                                ),
                    ),
          Container(
            padding: EdgeInsets.all(16),
            margin: EdgeInsets.fromLTRB(10, 8, 10, 15),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(12),
              color: Colors.grey[200]
            ),
            child: Column(
              children: [
                Row(
                  children: [
                    SizedBox(width: 10,),
                    Icon(Icons.place_outlined),
                    SizedBox(width: 10),
                    Text("Discover Events", style: TextStyle(
                      fontSize: 20,
                      color: Colors.grey.withValues(alpha: 0.5),
                      fontStyle: FontStyle.italic,
                      fontWeight: FontWeight.bold
                    ),),
                  ],
                ),
                Row(
                  children: [
                    SizedBox(width: 20,),
                    Text("Explore upcoming events tailored"),
                  ],
                ),
                Text("to your interests. Find your next experience!")
              ],
            ),
            
          ),
          Container(
             padding: EdgeInsets.all(16),
            margin: EdgeInsets.fromLTRB(10, 8, 10, 15),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(12),
              color: Colors.grey[200]
            ),
            child: Column(
              children: [
                Row(
                  children: [
                    SizedBox(width: 10,),
                    Icon(Icons.code),
                    SizedBox(width: 10),
                    Text("Match a coding buddy", style: TextStyle(
                       fontSize: 20,
                      color: Colors.grey.withValues(alpha: 0.5),
                      fontStyle: FontStyle.italic,
                      fontWeight: FontWeight.bold
                    ),),
                  ],
                ),
                Row(
                  children: [
                    SizedBox(width: 20,),
                    Text("Let AI find your perfect coding buddy."),
                  ],
                ),
                Text("Learn and grow together")
              ],
            ),
          ),
                    Container(
             padding: EdgeInsets.all(16),
            margin: EdgeInsets.fromLTRB(10, 8, 10, 15),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(12),
              color: Colors.grey[200]
            ),
            child: Column(
              children: [
                Row(
                  children: [
                    SizedBox(width: 10,),
                    Icon(Icons.chat),
                    SizedBox(width: 10),
                    Text("Global chat", style: TextStyle(
                       fontSize: 20,
                      color: Colors.grey.withValues(alpha: 0.5),
                      fontStyle: FontStyle.italic,
                      fontWeight: FontWeight.bold
                    ),),
                  ],
                ),
                Row(
                  children: [
                    SizedBox(width: 20,),
                    Text("Join the global conversation. Connect with"),
                  ],
                ),
                Text("other developers")
              ],
            ),
          ),
           Container(
             padding: EdgeInsets.all(16),
            margin: EdgeInsets.fromLTRB(10, 8, 10, 15),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(12),
              color: Colors.grey[200]
            ),
            child: Column(
              children: [
                Row(
                  children: [
                    SizedBox(width: 10,),
                    Icon(Icons.book),
                    SizedBox(width: 10),
                    Text("Quizz", style: TextStyle(
                       fontSize: 20,
                      color: Colors.grey.withValues(alpha: 0.5),
                      fontStyle: FontStyle.italic,
                      fontWeight: FontWeight.bold
                    ),),
                  ],
                ),
                Row(
                  children: [
                    SizedBox(width: 20,),
                    Text("Test your knowledge and boost your"

),
                  ],
                ),
                Text("skills with quick coding quizzes!")
              ],
            ),
          ),
        ],
      ),
    );
  }
}