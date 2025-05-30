import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:pulsesf/http/communication.dart';
import 'package:pulsesf/pages/displayProfiles.dart';

class Profilespage extends StatefulWidget {
  @override
  State<Profilespage> createState() => _ProfilespageState();
}

class _ProfilespageState extends State<Profilespage> {
  List<Map<String, dynamic>> profiles = [];

  _loadprofiles() async {
    searchUsers().then(
      (loaded) => {
        setState(() {
          profiles = loaded;
        }),
      },
    );
  }

  @override
  void initState() {
    super.initState();
    setState(() {
      _loadprofiles();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Container(
            color: Colors.purple,
            width: double.infinity,
            height: 90,
            child: Row(
              children: [
                IconButton(onPressed: () => Navigator.pop(context), icon: Icon(Icons.exit_to_app), iconSize: 40, color: Colors.red,),
                SizedBox(width: 120,),
                Text("Users", style: TextStyle(
                  fontFamily: "Fredoka",
                  fontSize: 17,
                  fontWeight: FontWeight.bold
                ),)
              ],
            ),
          ),
          SizedBox(height: 30),
          Container(
            height: 778,
            margin: EdgeInsets.symmetric(vertical: 5),
            padding: EdgeInsets.only(bottom: 10),
            child: ListView.builder(
              itemCount: profiles.length,
              itemBuilder: (BuildContext context, int index) {
                return Card(
                  elevation: 3,
                  child: GestureDetector(
                    onTap: () {
                      Navigator.push(context, MaterialPageRoute(builder: (builder) => Displayprofiles(email: profiles[index]["email"], profile_picture: profiles[index]["profile_picture"])));
                    },
                    child: Container(
                      margin: const EdgeInsets.all(8.0),
                      padding: EdgeInsets.only(bottom: 30),
                      child: ListTile(
                        title: Row(
                          children: [
                            profiles[index]["profile_picture"] != "No profile picture"
                                ? CircleAvatar(
                                  backgroundImage: MemoryImage(
                                    base64Decode(profiles[index]["profile_picture"]),
                                  ),
                                )
                                : CircleAvatar(
                                  backgroundColor: Colors.green,
                                  child: Text(profiles[index]["email"][0]),
                                ),
                            SizedBox(width: 15),
                            Text(profiles[index]["email"]),
                          ],
                        ),
                        //subtitle: Text("House at the future!!!"),
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
