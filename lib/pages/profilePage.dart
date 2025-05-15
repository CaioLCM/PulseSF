import 'package:flutter/material.dart';
import 'package:jwt_decoder/jwt_decoder.dart';
import 'package:pulsesf/pages/mainPage.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Profilepage extends StatelessWidget {
  String nickname = '';
  String email = '';
  void readToken() async {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      final token = prefs.getString('jwt_token');

      if (token != null){
        var decodedToken = JwtDecoder.decode(token);
        nickname = decodedToken['user']['name'];
        email = decodedToken['user']['email'];
      }
  }
  @override
  Widget build(BuildContext context) {
    readToken();
    return Scaffold(
      body: Column(
        children: [
          SizedBox(height: 30),
          Row(
            children: [
              SizedBox(width: 120,),
              CircleAvatar(
                radius: 90,
              ),
            ],
          ),
          SizedBox(height: 20,),
          Text(nickname, style: TextStyle(
            fontSize: 30
          ),),
          SizedBox(height: 8,),
          Text(email, style: TextStyle(fontSize: 20),),
          SizedBox(height: 20,),
          Container(
             padding: EdgeInsets.all(16),
            margin: EdgeInsets.only(bottom: 16),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(12),
              color: Colors.grey[200]
            ),
            child: Row(
              children: [
                SizedBox(width: 10,),
                Icon(Icons.person),
                SizedBox(width: 10),
                Text("Bio", style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold
                ),),
              ],
            ),
          ),
        Container(
             padding: EdgeInsets.all(16),
            margin: EdgeInsets.only(bottom: 16),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(12),
              color: Colors.grey[200]
            ),
            child: Row(
              children: [
                SizedBox(width: 10,),
                Icon(Icons.calendar_month),
                SizedBox(width: 10),
                Text("Participated Events", style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold
                ),),
              ],
            ),
          ),
          Container(
             padding: EdgeInsets.all(16),
            margin: EdgeInsets.only(bottom: 16),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(12),
              color: Colors.grey[200]
            ),
            child: Row(
              children: [
                SizedBox(width: 10,),
                Icon(Icons.code),
                SizedBox(width: 10),
                Text("Active Projects", style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold
                ),),
              ],
            ),
          ),
          Container(
            padding: EdgeInsets.all(16),
            margin: EdgeInsets.only(bottom: 16),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(12),
              color: Colors.grey[200]
            ),
            child: Row(
              children: [
                SizedBox(width: 10,),
                Icon(Icons.people),
                SizedBox(width: 10),
                Text("Friends", style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold
                ),),
              ],
            ),
          ),
          IconButton(onPressed:() => {
                                        Navigator.push(context, MaterialPageRoute(builder: (builder) => Mainpage()))
                                      }, icon: Icon(Icons.subdirectory_arrow_left_sharp))
        ],
      ),
    );
  }
}