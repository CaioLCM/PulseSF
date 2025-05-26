import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:jwt_decoder/jwt_decoder.dart';
import 'package:pulsesf/Widgets/LoginPage/email.dart';
import 'package:pulsesf/Widgets/mainPage/OptionsList.dart';
import 'package:pulsesf/Widgets/mainPage/appBar.dart';
import 'package:pulsesf/main.dart';
import 'package:pulsesf/pages/profilePage.dart';
import 'package:pulsesf/pages/projectsPage.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Mainpage extends StatefulWidget {
  const Mainpage({super.key});

  @override
  State<Mainpage> createState() => _MainpageState();
}

class _MainpageState extends State<Mainpage> {
  ImageProvider? _profileImage;

  /////////////////////////////////////////////////////////////////////

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

  /////////////////////////////////////////////////////////////////////

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

  /////////////////////////////////////////////////////////////

  @override 
  void initState(){
    super.initState();
    _loadProfileImage();
    readToken();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        children: [
            MyAppbar(email, _profileImage),
            Optionslist()
        ],
      ),
    );
  }
}