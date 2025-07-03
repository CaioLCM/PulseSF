import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:pulsesf/Widgets/LoginPage/email.dart';
import 'package:pulsesf/models/question_model.dart';
import 'package:pulsesf/models/true_or_false_model.dart';
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
    final url = Uri.parse('https://pulsesf-backend.onrender.com/logon');
    var response = await http.post(
      url,
      body: {"username": nickname, 'email': email, 'password': password},
    );
    if (response.statusCode == 200) {
      showDialog(
        context: context,
        builder:
            (context) => AlertDialog(
              title: Text("Account created successfully!"),
              content: Text("User will be redirected to the login page"),
              actions: [
                TextButton(
                  onPressed: () => Navigator.pop(context),
                  child: Text("Login page"),
                ),
              ],
            ),
      );
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
  final url = Uri.parse("https://pulsesf-backend.onrender.com/login");
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
  final url = Uri.parse("https://pulsesf-backend.onrender.com/profileAdd");
  var response = await http.post(url, body: {"email": email, "image": image});
}

Future<List<project>> getProjects() async {
  final url = Uri.parse("https://pulsesf-backend.onrender.com/projects");
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
  final url = Uri.parse("https://pulsesf-backend.onrender.com/projectCreate");
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
  final url = Uri.parse("https://pulsesf-backend.onrender.com/removeProject");
  var response = await http.post(url, body: {"name": name});
}

Future<String> searchForProfilePicture(String email) async {
  final url = Uri.parse("https://pulsesf-backend.onrender.com/searchPicture");
  var response = await http.post(
    url,
    headers: {"Content-Type": "application/json"},
    body: jsonEncode({"email": email}),
  );
  final body = response.body;
  print(response.statusCode);
  final decoded = jsonDecode(body);
  print("AAAAAAAAAAAAAAAAAAA");
  print(decoded);
  return decoded["picture"];
}

void addUserToProject(dynamic name, List<String> memberList) async {
  print(memberList);
  final url = Uri.parse("https://pulsesf-backend.onrender.com/addMember");
  var response = await http.post(
    url,
    headers: {"Content-Type": "application/json; charset=UTF-8"},
    body: jsonEncode({
      "project_name": name.toString(),
      "member_list": memberList,
    }),
  );
  if (response.statusCode == 200) {
    print(response.body);
  } else {
    print(response.body);
  }
}

Future<void> removeUserFromProject(String email, String project_name) async {
  final url = Uri.parse("https://pulsesf-backend.onrender.com/removeUser");
  var response = await http.post(
    url,
    body: {"email": email, "project_name": project_name},
  );
}

Future<List<Map<String, dynamic>>> searchUsers() async {
  final url = Uri.parse("https://pulsesf-backend.onrender.com/searchUsers");
  var response = await http.get(url);
  final response_body = jsonDecode(response.body);
  List<Map<String, dynamic>> final_body = [];
  print(response_body);
  response_body["users_info"].forEach(
    (user) => {
      final_body.add({
        "email": user["email"],
        "profile_picture": user["profile_picture"],
        "friends": user["friends"],
      }),
    },
  );
  return final_body;
}

Future<String> searchBio(String email) async {
  final url = Uri.parse("https://pulsesf-backend.onrender.com/searchUser");
  var response = await http.post(url, body: {"email": email});
  final encoded = jsonDecode(response.body);
  final bio = encoded["bio"];
  return bio;
}

Future<void> updateBio(String email, String bio) async {
  final url = Uri.parse("https://pulsesf-backend.onrender.com/updateBio");
  final response = await http.post(url, body: {"email": email, "bio": bio});
}

Future<void> addFriend(String email_req, String email_res) async {
  final url = Uri.parse("https://pulsesf-backend.onrender.com/addFriend");
  final response = await http.post(
    url,
    body: {"email_req": email_req, "email_res": email_res},
  );
}

Future<bool> checkFriend(String email_req, String email_res) async {
  final url = Uri.parse("https://pulsesf-backend.onrender.com/checkFriend");
  final response = await http.post(
    url,
    body: {"email_req": email_req, "email_res": email_res},
  );
  if (response.statusCode == 200) {
    return true;
  } else {
    return false;
  }
}

Future<List<String>> searchFriendsRequests(String email) async {
  final url = Uri.parse("https://pulsesf-backend.onrender.com/searchRequests");
  final response = await http.post(url, body: {"email": email});

  final dynamic response_decode = jsonDecode(response.body);

  if (response.statusCode == 200) {
    if (response_decode != null && response_decode['requests'] is List) {
      final List<dynamic> dynamicList = response_decode["requests"];
      final List<String> listString =
          dynamicList.map((e) => e.toString()).toList();
      return listString;
    } else {
      return ["Nothing to show"];
    }
  } else {
    return ["Nothing to show"];
  }
}

Future<void> removeFriendRequest(
  String emailRequest,
  String emailResponse,
) async {
  final url = Uri.parse("https://pulsesf-backend.onrender.com/removeFriendRequest");
  final response = await http.post(
    url,
    body: {"email_request": emailRequest, "email_response": emailResponse},
  );
}

Future<void> acceptFriendRequest(
  String emailRequest,
  String emailResponse,
) async {
  final url = Uri.parse("https://pulsesf-backend.onrender.com/acceptFriendRequest");
  final response = await http.post(
    url,
    body: {"email_req": emailRequest, "email_res": emailResponse},
  );
}

Future<List<String>> searchFriends(String email) async {
  final url = Uri.parse("https://pulsesf-backend.onrender.com/searchFriends");
  var response = await http.post(url, body: {"email_user": email});
  final decoded = await jsonDecode(response.body);
  if (decoded["friends"] is List) {
    final List<dynamic> friendsDynamic = decoded["friends"];
    final List<String> friendslist =
        friendsDynamic.map((item) => item.toString()).toList();
    return friendslist;
  } else {
    return decoded["friends"];
  }
}

Future<bool> removeFriend(String email_req, String email_res) async {
  final url = Uri.parse("https://pulsesf-backend.onrender.com/removeFriend");
  final response = await http.post(
    url,
    body: {"email_req": email_req, "email_res": email_res},
  );
  if (response.statusCode == 200) {
    return true;
  } else {
    return false;
  }
}

Future<void> addEvent(
  String email_req,
  String title,
  String description,
  String date,
) async {
  final url = Uri.parse("https://pulsesf-backend.onrender.com/addEvent");
  final response = await http.post(
    url,
    body: {
      "email_req": email_req,
      "title": title,
      "description": description,
      "Date": date,
    },
  );
}

Future<List<Map<String, dynamic>>> getEvents() async {
  final url = Uri.parse("https://pulsesf-backend.onrender.com/getEvents");
  final response = await http.get(url);
  List<Map<String, dynamic>> events = [];
  if (response.statusCode == 200) {
    final decoded = jsonDecode(response.body);
    if (decoded is List) {
      decoded
          .map(
            (e) => events.add({
              "emailOwner": e["creatorEmail"],
              "title": e["title"],
              "description": e["description"],
              "timestamp": e["timestamp"],
              "upvotes": e["upvotes"] ?? [],
              "downvotes": e["downvotes"] ?? [],
            }),
          )
          .toList();
      return events;
    }
  }
  return <Map<String, dynamic>>[];
}

Future<void> UpVote(String email, String title) async {
  final url = Uri.parse("https://pulsesf-backend.onrender.com/UpVote");
  final response = await http.post(url, body: {"email": email, "title": title});
}

Future<void> DownVote(String email, String title) async {
  final url = Uri.parse("https://pulsesf-backend.onrender.com/DownVote");
  final response = await http.post(url, body: {"email": email, "title": title});
}

Future<void> RemoveEvent(String title) async {
  final url = Uri.parse("https://pulsesf-backend.onrender.com/removeEvent");
  final response = await http.post(url, body: {"title": title});
}

Future<List<Map<String, dynamic>>> loadToDoList(String email) async {
  final url = Uri.parse("https://pulsesf-backend.onrender.com/loadToDoList");
  final response = await http.post(url, body: {"email": email});
  final decoded = jsonDecode(response.body);
  return List<Map<String, dynamic>>.from(decoded);
}

Future<void> updateToDoList(String email, String title) async {
  final url = Uri.parse("https://pulsesf-backend.onrender.com/updateToDoList");
  final response = await http.post(url, body: {"email": email, "title": title});
}

Future<void> updateCheckState(String email, String title) async {
  final url = Uri.parse("https://pulsesf-backend.onrender.com/updateCheckState");
  final response = await http.post(url, body: {"email": email, "title": title});
}

Future<void> removeToDoItem(String email, String title) async {
  final url = Uri.parse("https://pulsesf-backend.onrender.com/removeToDoItem");
  final response = await http.post(url, body: {"email": email, "title": title});
}

Future<void> createTag(String email, String title, String color) async {
  final url = Uri.parse("https://pulsesf-backend.onrender.com/createTag");
  final response = await http.post(
    url,
    body: {"email": email, "title": title, "color": color},
  );
}

Future<void> addTag(String email, String title, String color) async {
  final url = Uri.parse("https://pulsesf-backend.onrender.com/addTag");
  final response = await http.post(
    url,
    body: {"email": email, "title": title, "color": color},
  );
}

Future<List<Map<String, dynamic>>> loadTags(String email) async {
  final url = Uri.parse("https://pulsesf-backend.onrender.com/loadTags");
  final response = await http.post(url, body: {"email": email});
  final decoded = jsonDecode(response.body);
  return List<Map<String, dynamic>>.from(decoded);
}

Future<void> addTagToToDoEvent(
  String email,
  String title,
  String tagName,
  String color,
) async {
  final url = Uri.parse("https://pulsesf-backend.onrender.com/addTagToToDoEvent");
  final response = await http.post(
    url,
    body: {"email": email, "title": title, "tagName": tagName, "color": color},
  );

  if (response.body.isNotEmpty) {
    final decoded = jsonDecode(response.body);
  }
}

Future<void> sendPrivateMessage(
  String senderEmail,
  String receiverEmail,
  String text,
) async {
  final url = Uri.parse("https://pulsesf-backend.onrender.com/send-private-message");
  try {
    await http.post(
      url,
      headers: {"Content-Type": "application/json"},
      body: jsonEncode({
        "senderEmail": senderEmail,
        "receiverEmail": receiverEmail,
        "text": text,
      }),
    );
  } catch (e) {
    print("Error sending message: $e");
  }
}

Future<List<Map<String, dynamic>>> getPrivateMessageHistory(
  String user1Email,
  String user2Email,
) async {
  final url = Uri.parse("https://pulsesf-backend.onrender.com/get-private-messages");
  try {
    final response = await http.post(
      url,
      headers: {"Content-Type": "application/json"},
      body: jsonEncode({"user1Email": user1Email, "user2Email": user2Email}),
    );

    if (response.statusCode == 200) {
      List<dynamic> decoded = jsonDecode(response.body);
      return decoded.cast<Map<String, dynamic>>();
    } else {
      print("Failed to load messages: ${response.body}");
      return [];
    }
  } catch (e) {
    print("Error fetching messages: $e");
    return [];
  }
}

Future<List<Question>> getQuiz(String level) async {
  String difficulty = level.toLowerCase();
  
  final url = Uri.parse(
    "https://opentdb.com/api.php?amount=10&category=18&difficulty=$difficulty&type=multiple",
  );

  try {
    final response = await http.get(url);

    if (response.statusCode == 200) {
      final decodedData = jsonDecode(response.body);

      if (decodedData['response_code'] == 0) {

        final List<dynamic> results = decodedData['results'];

        return results.map((json) => Question.fromJson(json)).toList();
      }
    }

    print("Error to search questions. Status: ${response.statusCode}");
    return [];

  } catch (e) {
    print("Error to search questions: $e");
    return [];
  }
}

Future<List<TrueOrFalseModel>> getTrueOrFalseQuiz(String level) async {
  String difficulty = level.toLowerCase();
  
  final url = Uri.parse(
    "https://opentdb.com/api.php?amount=10&category=9&difficulty=$difficulty&type=boolean",
  );

  try {
    final response = await http.get(url);

    if (response.statusCode == 200) {
      final decodedData = jsonDecode(response.body);

      if (decodedData['response_code'] == 0) {

        final List<dynamic> results = decodedData['results'];

        return results.map((json) => TrueOrFalseModel.fromJson(json)).toList();
      }
    }

    print("Error to search questions. Status: ${response.statusCode}");
    return [];

  } catch (e) {
    print("Error to search questions: $e");
    return [];
  }
}

Future<List<Map<String, dynamic>>> fetchLeaderboard() async {
  final url = Uri.parse("https://pulsesf-backend.onrender.com/leaderboard");
  try {
    final request = await http.get(url);
    if (request.statusCode == 200) {
      final List<dynamic> decoded = jsonDecode(request.body);
      return decoded.map<Map<String, dynamic>>((item) => Map<String, dynamic>.from(item)).toList();
    }
  } catch (error){
    print("Error to load users $error");
    return [];
  }
  return [];
} 

Future<void> addPointsToUser(String email, int points) async {
  final url = Uri.parse("https://pulsesf-backend.onrender.com/addPoints");
  try {
    await http.post(
      url, 
      headers: {"Content-Type": "application/json"},
      body: jsonEncode({
      "email": email,
      "points": points
    }));
  } catch (error){
    print("Error to update user points");
  } 
}
