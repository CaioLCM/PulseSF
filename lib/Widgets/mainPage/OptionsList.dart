import 'package:flutter/material.dart';
import 'package:pulsesf/main.dart';
import 'package:pulsesf/pages/profilePage.dart';
import 'package:pulsesf/pages/profilesPage.dart';
import 'package:pulsesf/pages/projectsPage.dart';

class Optionslist extends StatelessWidget {
  const Optionslist({super.key});

  @override
  Widget build(BuildContext context) {
    List<Widget> Personal = [
      Row(
        children: [
          SizedBox(width: 10),
          Icon(Icons.precision_manufacturing),
          SizedBox(width: 10),
          TextButton(
            onPressed:
                () => {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (builder) => Projectspage()),
                  ),
                },
            child: Text(
              "Projects",
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                fontFamily: "Fredoka",
              ),
            ),
          ),
        ],
      ),
      Row(
        children: [
          SizedBox(width: 10),
          Icon(Icons.person),
          SizedBox(width: 10),
          TextButton(
            onPressed:
                () => {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (builder) => Profilepage()),
                  ),
                },
            child: Text(
              "Profile",
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                fontFamily: "Fredoka",
              ),
            ),
          ),
        ],
      ),
    ];

    List<Widget> Social = [
      GestureDetector(
        onTap: () {
          Navigator.of(context).push(MaterialPageRoute(builder: (context) => Profilespage()));
        },
        child: Row(
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
      ),
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
    ];

    List<Widget> SF = [
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
                return Container(
                  padding: EdgeInsets.all(20),
                  margin: EdgeInsets.fromLTRB(10, 8, 10, 15),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(12),
                    color: Colors.blue[400],
                  ),
                  child: Personal[index],
                );
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
              itemCount: Personal.length,
              scrollDirection: Axis.horizontal,
              itemBuilder: (context, index) {
                return Container(
                  padding: EdgeInsets.all(20),
                  margin: EdgeInsets.fromLTRB(10, 8, 10, 15),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(12),
                    color: Colors.orange[400],
                  ),
                  child: Social[index],
                );
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
                return Container(
                  padding: EdgeInsets.all(20),
                  margin: EdgeInsets.fromLTRB(10, 8, 10, 15),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(12),
                    color: Colors.green,
                  ),
                  child: SF[index],
                );
              },
            ),
          ),
        ],
      ),
    ];
    return SizedBox(
      height: 800,
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
