import 'package:flutter/material.dart';
import 'package:pulsesf/main.dart';

class Mainpage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 174, 218, 240),
      body: Column(
        children: [
          Container(
            decoration: BoxDecoration(
              color: Colors.white
            ),
            child: Column(
              children: [
                Row(
                  children: [
                    SizedBox(width: 130,),
                    Text("PulseSF", style: TextStyle(
                          color: Colors.purple[400],
                          fontSize: 40,
                          fontWeight: FontWeight.bold
                          )
                            ),
                    SizedBox(width: 30,),
                    IconButton(onPressed: () => {
                      Navigator.push(context, MaterialPageRoute(builder: (builder) => MyApp()))
                    }, icon:  Icon(Icons.logout))
                  ],
                ),
                        Text("Building your San Francisco experience")
              ],
            ),
          ),
        SizedBox(height: 30,),
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
                Text("Discover Events", style: TextStyle(
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
                Text("Match a coding buddy", style: TextStyle(
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
                Icon(Icons.precision_manufacturing),
                SizedBox(width: 10),
                Text("Create/join projects", style: TextStyle(
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
                                    Icon(Icons.person),
                                    SizedBox(width: 10),
                                    Text("Profile", style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold
                ),),
                                  ],
                                ),
                    ),
        ],
      ),
    );
  }
}