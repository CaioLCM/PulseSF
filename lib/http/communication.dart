import 'dart:convert';

import 'package:flutter/widgets.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:pulsesf/pages/mainPage.dart';
import 'package:shared_preferences/shared_preferences.dart';

Future<bool> CreateAccount(String nickname, String email, String password, BuildContext context) async {
  final url = Uri.parse('http://10.0.2.2:3000/logon');
  var response = await http.post(url, body: {"nickname": nickname, 'email': email, 'password': password});
  if (response.statusCode == 200){
    Navigator.pop(context);
    return true;
  }
  else {
      return false; 
  }
}

Future<bool> verifyAccount(String email, String password, BuildContext context) async {
  final url = Uri.parse('http://10.0.2.2:3000/login');
  var response = await http.post(url, body: {"email": email, "password": password});
  if (response.statusCode == 200){
             final data = jsonDecode(response.body);
             final token = data['token'];
             SharedPreferences prefs = await SharedPreferences.getInstance();
             await prefs.setString('jwt_token', token);
             Navigator.push(context, MaterialPageRoute(builder: (builder) => Mainpage()));
             return true;
        }
  else {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setBool("valid_login", false);
    return false;
  }
}

Future<void> updateAccountWithProfIlePicture(String email, String image) async{
  final url = Uri.parse("http://10.0.2.2:3000/profileAdd");
  var response = await http.post(url, body: {"email": email, "image": image});
}
