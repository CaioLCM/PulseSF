import 'package:flutter/material.dart';
import 'package:pulsesf/main.dart';
import 'package:pulsesf/pages/aboutSF_page.dart';
import 'package:pulsesf/pages/chat_page.dart';
import 'package:pulsesf/pages/eventsSF_page.dart';
import 'package:pulsesf/pages/profilePage.dart';
import 'package:pulsesf/pages/profilesPage.dart';
import 'package:pulsesf/pages/projectsPage.dart';
import 'package:pulsesf/pages/toDoList_page.dart';

class Optionslist extends StatelessWidget {
  final String email;
  const Optionslist({required this.email});

  @override
  Widget build(BuildContext context) {
    List<Widget> Personal = [
      GestureDetector(
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (builder) => Projectspage()),
          );
        },
        child: Container(
          padding: EdgeInsets.fromLTRB(20, 20, 40, 20),
          margin: EdgeInsets.fromLTRB(10, 8, 10, 15),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(12),
            color: Colors.blue[400],
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Row(
                children: [
                  SizedBox(width: 10),
                  Icon(Icons.precision_manufacturing),
                  SizedBox(width: 10),
                  Text(
                    "Projects",
                    style: TextStyle(fontSize: 20, fontFamily: "Fredoka"),
                  ),
                ],
              ),
              Container(
                margin: EdgeInsets.fromLTRB(15, 0, 0, 0),
                child: Text(
                  "Create/join a project!",
                  style: TextStyle(color: Colors.black, fontFamily: "Fredoka"),
                ),
              ),
            ],
          ),
        ),
      ),
      GestureDetector(
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (builder) => Profilepage(email: email)),
          );
        },
        child: Container(
          padding: EdgeInsets.fromLTRB(20, 20, 40, 20),
          margin: EdgeInsets.fromLTRB(10, 8, 10, 15),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(12),
            color: Colors.blue[400],
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Row(
                children: [
                  SizedBox(width: 10),
                  Icon(Icons.person),
                  SizedBox(width: 10),
                  Text(
                    "Profile",
                    style: TextStyle(fontSize: 20, fontFamily: "Fredoka"),
                  ),
                ],
              ),
              Container(
                margin: EdgeInsets.fromLTRB(15, 0, 0, 0),
                child: Text(
                  "Access your profile",
                  style: TextStyle(color: Colors.black, fontFamily: "Fredoka"),
                ),
              ),
            ],
          ),
        ),
      ),
      GestureDetector(
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (builder) => TodolistPage(email: email)),
          );
        },
        child: Container(
          padding: EdgeInsets.fromLTRB(20, 20, 40, 20),
          margin: EdgeInsets.fromLTRB(10, 8, 10, 15),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(12),
            color: Colors.blue[400],
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Row(
                children: [
                  SizedBox(width: 10),
                  Icon(Icons.person),
                  SizedBox(width: 10),
                  Text(
                    "To-do list",
                    style: TextStyle(fontSize: 20, fontFamily: "Fredoka"),
                  ),
                ],
              ),
              Container(
                margin: EdgeInsets.fromLTRB(15, 0, 0, 0),
                child: Text(
                  "Access your to-do list",
                  style: TextStyle(color: Colors.black, fontFamily: "Fredoka"),
                ),
              ),
            ],
          ),
        ),
      ),
    ];

    List<Widget> Social = [
      GestureDetector(
        onTap: () {
          Navigator.of(
            context,
          ).push(MaterialPageRoute(builder: (context) => Profilespage()));
        },
        child: Container(
          padding: EdgeInsets.all(20),
          margin: EdgeInsets.fromLTRB(10, 8, 10, 15),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(12),
            color: Colors.orange[400],
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Row(
                children: [
                  SizedBox(width: 10),
                  Icon(Icons.code),
                  SizedBox(width: 10),
                  Text(
                    "Match a coding buddy",
                    style: TextStyle(
                      fontSize: 20,
                      color: Colors.black,
                      fontFamily: "Fredoka",
                    ),
                  ),
                ],
              ),
              Text(
                "See the neighbors' profile",
                style: TextStyle(color: Colors.black, fontFamily: "Fredoka"),
              ),
            ],
          ),
        ),
      ),
      GestureDetector(
        onTap:
            () => Navigator.of(
              context,
            ).push(MaterialPageRoute(builder: (_) => ChatPage(email: email))),
        child: Container(
          padding: EdgeInsets.all(20),
          margin: EdgeInsets.fromLTRB(10, 8, 10, 15),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(12),
            color: Colors.orange[400],
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Row(
                children: [
                  SizedBox(width: 10),
                  Icon(Icons.chat),
                  SizedBox(width: 10),
                  Text(
                    "Global chat",
                    style: TextStyle(
                      fontSize: 20,
                      color: Colors.black,
                      fontFamily: "Fredoka",
                    ),
                  ),
                ],
              ),
              Text(
                "Talk with your neighbors",
                style: TextStyle(color: Colors.black, fontFamily: "Fredoka"),
              ),
            ],
          ),
        ),
      ),
    ];

    List<Widget> SF = [
      GestureDetector(
        onTap: () {
          Navigator.of(
            context,
          ).push(MaterialPageRoute(builder: (_) => EventssfPage(email: email)));
        },
        child: Container(
          padding: EdgeInsets.all(20),
          margin: EdgeInsets.fromLTRB(10, 8, 10, 15),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(12),
            color: Colors.green,
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Row(
                children: [
                  SizedBox(width: 10),
                  Icon(Icons.place_outlined),
                  SizedBox(width: 10),
                  Text(
                    "Discover Events",
                    style: TextStyle(
                      fontSize: 20,
                      color: Colors.black,
                      fontFamily: "Fredoka",
                    ),
                  ),
                ],
              ),
              Text(
                "See what's happening at the city",
                style: TextStyle(color: Colors.black, fontFamily: "Fredoka"),
              ),
            ],
          ),
        ),
      ),
      GestureDetector(
        onTap: () {
          Navigator.of(
            context,
          ).push(MaterialPageRoute(builder: (_) => AboutsfPage()));
        },
        child: Container(
          padding: EdgeInsets.all(20),
          margin: EdgeInsets.fromLTRB(10, 8, 10, 15),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(12),
            color: Colors.green,
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Row(
                children: [
                  SizedBox(width: 10),
                  Icon(Icons.car_crash),
                  SizedBox(width: 10),
                  Text(
                    "More about SF",
                    style: TextStyle(
                      fontSize: 20,
                      color: Colors.black,
                      fontFamily: "Fredoka",
                    ),
                  ),
                ],
              ),
              Text(
                "See more about San Francisco",
                style: TextStyle(color: Colors.black, fontFamily: "Fredoka"),
              ),
            ],
          ),
        ),
      ),
    ];

    List<Widget> Games = [
      GestureDetector(
        onTap: () {
          ///
        },
        child: Container(
          padding: EdgeInsets.all(20),
          margin: EdgeInsets.fromLTRB(10, 8, 10, 15),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(12),
            color: Colors.yellow,
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Row(
                children: [
                  SizedBox(width: 10),
                  Icon(Icons.quiz),
                  SizedBox(width: 10),
                  Text(
                    "Quiz",
                    style: TextStyle(
                      fontSize: 20,
                      color: Colors.black,
                      fontFamily: "Fredoka",
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    ];

    List<Widget> Options = [
      Column(
        children: [
          //////////////////////////////////////////////////////////////////////////////
          Text(
            "Personal",
            style: TextStyle(
              fontFamily: "Fredoka",
              fontWeight: FontWeight.bold,
              fontSize: 30,
            ),
          ),
          SizedBox(height: 20),
          SizedBox(
            height: 300,
            child: ListView.builder(
              itemCount: Personal.length,
              scrollDirection: Axis.horizontal,
              itemBuilder: (context, index) {
                return Personal[index];
              },
            ),
          ),

          /////////////////////////////////////////////////////////////////////////////////
          SizedBox(height: 15),
          Text(
            "Social",
            style: TextStyle(
              fontFamily: "Fredoka",
              fontWeight: FontWeight.bold,
              fontSize: 30,
            ),
          ),
          SizedBox(height: 20),
          SizedBox(
            height: 300,
            child: ListView.builder(
              itemCount: Social.length,
              scrollDirection: Axis.horizontal,
              itemBuilder: (context, index) {
                return Social[index];
              },
            ),
          ),

          //////////////////////////////////////////////////////////////////////////////////
          SizedBox(height: 15),
          Text(
            "Explore",
            style: TextStyle(
              fontFamily: "Fredoka",
              fontWeight: FontWeight.bold,
              fontSize: 30,
            ),
          ),
          SizedBox(height: 20),
          SizedBox(
            height: 300,
            child: ListView.builder(
              itemCount: SF.length,
              scrollDirection: Axis.horizontal,
              itemBuilder: (context, index) {
                return SF[index];
              },
            ),
          ),
          SizedBox(height: 15),
          Text(
            "Games",
            style: TextStyle(
              fontFamily: "Fredoka",
              fontWeight: FontWeight.bold,
              fontSize: 30
            ),
          ),
          SizedBox(height: 20,),
          SizedBox(
            height: 300,
            child: ListView.builder(
              itemCount: Games.length,
              scrollDirection: Axis.horizontal,
              itemBuilder:(context, index) {
                return Games[index];
              },
            ),
          )
        ],
      ),
    ];
    return SizedBox(
      height: 685,
      child: ListView.builder(
        itemCount: Options.length,
        itemBuilder: (context, index) {
          final option = Options[index];
          return option;
        },
      ),
    );
  }
}
