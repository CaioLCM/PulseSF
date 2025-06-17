import 'dart:convert';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:jwt_decoder/jwt_decoder.dart';
import 'package:pulsesf/http/communication.dart';
import 'package:pulsesf/pages/attending_events_page.dart';
import 'package:pulsesf/pages/bioPage.dart';
import 'package:pulsesf/pages/friendsPage.dart';
import 'package:pulsesf/pages/mainPage.dart';
import 'package:pulsesf/pages/userProjects_page.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:image_picker/image_picker.dart';
 
class Profilepage extends StatefulWidget {
  const Profilepage({super.key});

  @override
  State<Profilepage> createState() => _ProfilepageState();
}

class _ProfilepageState extends State<Profilepage> {
  ImageProvider? _profileImage;

   void _openBioModal(BuildContext context) {
    showModalBottomSheet(
      context: context,
      builder: (_) => Biopage(),
    );
  }

  @override   
  void initState(){
    super.initState();
    _loadProfileImage();
    readToken();
  }

  void _loadProfileImage() async {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      final token = prefs.getString('jwt_token');
      if (token != null){
        var decodedToken = JwtDecoder.decode(token);
        print(decodedToken['user']['profilePicture']);
         if (decodedToken['user']['profilePicture'] != null) {
          setState(() {
          _profileImage = MemoryImage(base64Decode(decodedToken['user']['profilePicture']));
      
      });
    }
      }
  }


  Future<void> _pickImage() async {
    final picker = ImagePicker();
    final prefs = await SharedPreferences.getInstance();
    final pickedFile = await picker.pickImage(source: ImageSource.camera);
    Uint8List bytes;
    String base64Image = '';

    bytes = await pickedFile!.readAsBytes();
    base64Image = base64Encode(bytes);
    updateAccountWithProfIlePicture(email, base64Image);
    
    await prefs.setString("profile", base64Image);
    setState(() {
      _profileImage = MemoryImage(bytes);
    });

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('DANGER'),
        content: Text("User is way too handsome"),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text("Nice rizz bro"),
          ),
        ],
      ),
    );

  }

  String email = '';
  
  void readToken() async {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      final token = prefs.getString('jwt_token');

      if (token != null){
        var decodedToken = JwtDecoder.decode(token);
        setState(() {
        email = decodedToken['user']['email'];
        });

      }
  }  

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Profile"), backgroundColor: Colors.purple, titleTextStyle: TextStyle(color: Colors.white, fontSize: 17, fontFamily: "Fredoka"),),
      body: Column(
        children: [
          SizedBox(height: 30),
          Row(
            children: [
              SizedBox(width: 105,),
              Row(
                children: [
                  CircleAvatar(
                    radius: 90,
                    backgroundImage: _profileImage,
                  ),
                  IconButton(onPressed: _pickImage, icon: Icon(Icons.camera_alt), iconSize: 40,)
                ],
              ),
            ],
          ),
          SizedBox(height: 20,),
          FittedBox(
            child: Text(email, style: TextStyle(
              fontSize: 30
            ),),
          ),
          SizedBox(height: 8,),
          //Text(email, style: TextStyle(fontSize: 20),),
          SizedBox(height: 20,),
          GestureDetector(
            onTap: () {
              _openBioModal(context);
            },
            child: Container(
               padding: EdgeInsets.all(16),
              margin: EdgeInsets.only(bottom: 16),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(12),
                color: Colors.grey[200]
              ),
                child: Row(
                  children: [
                    SizedBox(width: 10,),
                    Icon(Icons.person, color: Colors.black,),
                    SizedBox(width: 10),
                    Text("Bio", style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: const Color.fromARGB(255, 90, 85, 85)
                    ),),
                  ],
                ),
              ),
          ),
        GestureDetector(
          onTap: () => Navigator.of(context).push(MaterialPageRoute(builder: (_) => AttendingEventsPage(email: email,))),
          child: Container(
               padding: EdgeInsets.all(16),
              margin: EdgeInsets.only(bottom: 16),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(12),
                color: Colors.grey[200]
              ),
              child: Row(
                children: [
                  SizedBox(width: 10,),
                  Icon(Icons.calendar_month, color: Colors.black,),
                  SizedBox(width: 10),
                  Text("Attending events", style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: const Color.fromARGB(255, 90, 85, 85)
                  ),),
                ],
              ),
            ),
        ),
          GestureDetector(
            onTap: () => Navigator.of(context).push(MaterialPageRoute(builder: (_) => UserprojectsPage(user_email: email,))),
            child: Container(
               padding: EdgeInsets.all(16),
              margin: EdgeInsets.only(bottom: 16),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(12),
                color: Colors.grey[200]
              ),
              child: Row(
                children: [
                  SizedBox(width: 10,),
                  Icon(Icons.code, color: Colors.black,),
                  SizedBox(width: 10),
                  Text("Active Projects", style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Color.fromARGB(255, 90, 85, 85)
                  ),),
                ],
              ),
            ),
          ),
          GestureDetector(
            onTap: () {
              Navigator.of(context).push(MaterialPageRoute(builder: (builder)=> Friendspage(email: email,)));
            },
            child: Container(
              padding: EdgeInsets.all(16),
              margin: EdgeInsets.only(bottom: 16),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(12),
                color: Colors.grey[200]
              ),
                child: Row(
                  children: [
                    SizedBox(width: 10,),
                    Icon(Icons.people, color: Colors.black,),
                    SizedBox(width: 10),
                    Text("Friends", style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: const Color.fromARGB(255, 90, 85, 85)
                    ),),
                  ],
                ),
              ),
          ),
        ],
      ),
    );
  }
}