import 'dart:convert';

import 'package:flutter/widgets.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:pulsesf/pages/mainPage.dart';
import 'package:shared_preferences/shared_preferences.dart';

void CreateAccount(String nickname, String email, String password, BuildContext context) async {
  final url = Uri.parse('http://10.0.2.2:3000/logon');
  var response = await http.post(url, body: {"nickname": nickname, 'email': email, 'password': password});
  if (response.statusCode == 200){
    Navigator.pop(context);
  }
}

void verifyAccount(String email, String password, BuildContext context) async {
  final url = Uri.parse('http://10.0.2.2:3000/login');
  var response = await http.post(url, body: {"email": email, "password": password});
  if (response.statusCode == 200){
             final data = jsonDecode(response.body);
             final token = data['token'];
             SharedPreferences prefs = await SharedPreferences.getInstance();
             await prefs.setString('jwt_token', token);
             await prefs.setString("valid_login", "true");
             Navigator.push(context, MaterialPageRoute(builder: (builder) => Mainpage()));
             print(prefs.getString("jwt_token"));
        }
}

