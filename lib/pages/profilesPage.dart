import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:pulsesf/http/communication.dart';

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
          print(profiles[1]);
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
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
