import 'dart:convert';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:jwt_decoder/jwt_decoder.dart';
import 'package:pulsesf/http/communication.dart';
import 'package:pulsesf/pages/bioPage.dart';
import 'package:pulsesf/pages/mainPage.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:image_picker/image_picker.dart';

class Displayprofiles extends StatefulWidget {
  String email;
  String profile_picture;
  Displayprofiles({required this.email, required this.profile_picture});

  @override
  State<Displayprofiles> createState() => _Displayprofiles();
}

class _Displayprofiles extends State<Displayprofiles> {
  ImageProvider? _profileImage;

  _loadBio() async{
    final bio = await searchBio(widget.email);
    return bio;
  }

  @override
  void initState() {
    super.initState();
    setState(() {
      if (widget.profile_picture != "No profile picture") {
        _profileImage = MemoryImage(base64Decode(widget.profile_picture));
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
            color: Colors.purple,
            width: double.infinity,
            height: 90,
            child: Row(
              children: [
                IconButton(onPressed: () => Navigator.pop(context), icon: Icon(Icons.exit_to_app), iconSize: 40, color: Colors.red,),
                SizedBox(width: 60,),
                Text(widget.email, style: TextStyle(
                  fontFamily: "Fredoka",
                  fontSize: 17,
                  fontWeight: FontWeight.bold
                ),)
              ],
            ),
          ),
          SizedBox(height: 30),
          Row(
            children: [
              SizedBox(width: 105),
              Row(
                children: [
                  CircleAvatar(
                    radius: 90,
                    backgroundImage:
                        _profileImage,
                    backgroundColor: Colors.green,
                    child: _profileImage == null ? Text(widget.email[0]) : null,
                  ),
                ],
              ),
            ],
          ),
          SizedBox(height: 30,),
          Text("About me", style: TextStyle(fontFamily: "Fredoka", fontWeight: FontWeight.bold, fontSize: 30),),
          SizedBox(height: 30,),
          Card(
            elevation: 10,
            child: Container(
              height: 500,
              width: 350,
              child: FutureBuilder(future: _loadBio(), builder: (context, snapshot) {
                if (snapshot.hasData){
                  return Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(snapshot.data.toString(), style: TextStyle(fontFamily: "Fredoka", fontSize: 18),),
                  );
                }
                else {
                  return CircularProgressIndicator(
                    value: 7,
                  );
                }
              },),
            ),
          )
        ],
      ),
    );
  }
}
