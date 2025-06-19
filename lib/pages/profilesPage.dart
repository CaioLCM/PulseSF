import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:jwt_decoder/jwt_decoder.dart';
import 'package:pulsesf/http/communication.dart';
import 'package:pulsesf/pages/displayProfiles.dart';
import 'package:pulsesf/pages/message_page.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Profilespage extends StatefulWidget {
  @override
  State<Profilespage> createState() => _ProfilespageState();
}

class _ProfilespageState extends State<Profilespage> {
  List<Map<String, dynamic>> profiles = [];
  String userEmail = '';

  _loadprofiles() async {
    searchUsers().then(
      (loaded) => {
        setState(() {
          profiles = loaded;
        }),
      },
    );
  }

  Future<void> _loadUserEmail() async {
    final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString("jwt_token");
    final decoded = JwtDecoder.decode(token!);
    setState(() {
      userEmail = decoded['user']?['email'] as String;
    });
  }

  @override
  void initState() {
    super.initState();
    _loadUserEmail();
    setState(() {
      _loadprofiles();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Coders"),
        backgroundColor: Colors.purple,
        titleTextStyle: TextStyle(
          color: Colors.white,
          fontSize: 17,
          fontFamily: "Fredoka",
        ),
      ),
      body: Column(
        children: [
          SizedBox(height: 30),
          Container(
            height: 654,
            margin: EdgeInsets.symmetric(vertical: 5),
            padding: EdgeInsets.only(bottom: 10),
            child: ListView.builder(
              itemCount: profiles.length,
              itemBuilder: (BuildContext context, int index) {
                return FutureBuilder(
                  future: checkFriend(userEmail, profiles[index]["email"]),
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.done) {
                      return GestureDetector(
                         onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder:
                                      (builder) => Displayprofiles(
                                        email: profiles[index]["email"],
                                        profile_picture:
                                            profiles[index]["profile_picture"],
                                      ),
                                ),
                              );
                            },
                        child: Card(
                          elevation: 3,
                            child: Container(
                              margin: const EdgeInsets.all(8.0),
                              padding: EdgeInsets.only(bottom: 30),
                              child: ListTile(
                                title: FittedBox(
                                  child: Row(
                                    children: [
                                      profiles[index]["profile_picture"] !=
                                              "No profile picture"
                                          ? CircleAvatar(
                                            backgroundImage: MemoryImage(
                                              base64Decode(
                                                profiles[index]["profile_picture"],
                                              ),
                                            ),
                                          )
                                          : CircleAvatar(
                                            backgroundColor: Colors.green,
                                            child: Text(
                                              profiles[index]["email"][0],
                                            ),
                                          ),
                                      SizedBox(width: 15),
                                      Text(profiles[index]["email"]),
                                      SizedBox(width: 150),
                                      if (userEmail != profiles[index]["email"] &&
                                          snapshot.data == false)
                                        profiles[index]["friends"].contains(userEmail)
                                        ? Icon(Icons.people)
                                        :IconButton(
                                          onPressed: () {
                                            setState(() {
                                              addFriend(
                                                userEmail,
                                                profiles[index]["email"],
                                              );
                                              _loadprofiles();
                                            });
                                          },
                                          icon: Icon(Icons.add),
                                          iconSize: 30,
                                        ),
                                      if(userEmail != profiles[index]["email"])
                                        IconButton(onPressed: (){
                                          Navigator.of(context).push(MaterialPageRoute(builder: (builder) => MessagePage(send_email: userEmail, receive_email: profiles[index]["email"])));
                                      }, icon: Icon(Icons.message)),
                                      if (snapshot.data == true)
                                        profiles[index]["friends"].contains(userEmail)
                                            ? Icon(Icons.people)
                                            : Icon(Icons.hourglass_empty),
                                    ],
                                  ),
                                ),
                                //subtitle: Text("House at the future!!!"),
                              ),
                            ),
                          ),
                      );
                    }

                    if (snapshot.hasError) {
                      return ListTile(
                        title: Text(profiles[index]["email"]),
                        subtitle: Text(
                          "Error!",
                          style: TextStyle(color: Colors.red),
                        ),
                        leading: Icon(Icons.error, color: Colors.red),
                      );
                    } else {
                      return Center(child: CircularProgressIndicator());
                    }
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
