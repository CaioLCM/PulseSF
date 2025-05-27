import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:pulsesf/pages/createProjectMenu.dart';
import 'package:pulsesf/pages/mainPage.dart';
import 'package:shared_preferences/shared_preferences.dart';

Future<bool> CreateAccount(
  String nickname,
  String email,
  String password,
  BuildContext context,
) async {
  bool isValidEmail(String email) {
    final emailRegex = RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$');
    return emailRegex.hasMatch(email);
  }

  if (isValidEmail(email) && nickname.isNotEmpty && password.isNotEmpty) {
    final url = Uri.parse('http://10.0.2.2:3000/logon');
    var response = await http.post(
      url,
      body: {"username": nickname, 'email': email, 'password': password},
    );
    if (response.statusCode == 200) {
      Navigator.pop(context);
      return true;
    } else {
      return false;
    }
  } else {
    return false;
  }
}

Future<bool> verifyAccount(
  String email,
  String password,
  BuildContext context,
) async {
  final url = Uri.parse("http://10.0.2.2:3000/login");
  var response = await http.post(
    url,
    body: {"email": email, "password": password},
  );
  if (response.statusCode == 200) {
    final data = jsonDecode(response.body);
    final token = data['token'];
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString('jwt_token', token);
    Navigator.push(
      context,
      MaterialPageRoute(builder: (builder) => Mainpage()),
    );
    return true;
  } else {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setBool("valid_login", false);
    return false;
  }
}

Future<void> updateAccountWithProfIlePicture(String email, String image) async {
  final url = Uri.parse("http://10.0.2.2:3000/profileAdd");
  var response = await http.post(url, body: {"email": email, "image": image});
}

Future<List<project>> getProjects() async {
  final url = Uri.parse("http://10.0.2.2:3000/projects");
  var response = await http.get(url);
  final decoded = jsonDecode(response.body);
  return decoded.map<project>((item) => project.fromJson(item)).toList();
}

Future<void> addProject(
  String title,
  String bio,
  double members,
  String email,
) async {
  final url = Uri.parse("http://10.0.2.2:3000/projectCreate");
  var response = await http.post(
    url,
    body: {
      "email": email,
      "title": title,
      "bio": bio,
      "members": members.toString(),
    },
  );
}

Future<void> removeProject(String name) async {
  final url = Uri.parse("http://10.0.2.2:3000/removeProject");
  var response = await http.post(url, body: {"name": name});
}

Future<String> searchForProfilePicture(String email) async {
  final url = Uri.parse("http://10.0.2.2:3000/searchPicture");
  var response = await http.post(url, body: {"email": email});
  final body = response.body;
  final decoded = jsonDecode(body);
  return decoded["picture"];
}

void addUserToProject(dynamic name, List<String> memberList) async {
  print(memberList);
  final url = Uri.parse("http://10.0.2.2:3000/addMember");
  var response = await http.post(
    url,
    headers: {"Content-Type": "application/json; charset=UTF-8"},
    body: jsonEncode({"project_name": name.toString(), "member_list": memberList}),
  );
  if (response.statusCode == 200){
    print(response.body);
  }
  else {
    print(response.body);
  }
}

void removeUserFromProject(String email, List<String> member_list) async {
  final url = Uri.parse("http://10.0.2.2:3000/removeUser");
  var response = await http.post(url, headers: {"ContentType": "application/json; charset=UTF-8"},
  body: jsonEncode({"email": email, "member_list": member_list}));
}