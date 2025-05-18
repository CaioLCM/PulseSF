import 'package:flutter/material.dart';
import 'package:jwt_decoder/jwt_decoder.dart';
import 'package:pulsesf/pages/mainPage.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:image_picker/image_picker.dart';
 
class Profilepage extends StatefulWidget {
  @override
  State<Profilepage> createState() => _ProfilepageState();
}

class _ProfilepageState extends State<Profilepage> {
  ImageProvider? _profileImage;

  @override   
  void initState(){
    super.initState();
    _loadProfileImage();
    readToken();
  }

  void _loadProfileImage() async {
    final prefs = await SharedPreferences.getInstance();
    final imageUrl = prefs.getString("profile");

    if (imageUrl != null) {
      setState(() {
        _profileImage = NetworkImage(imageUrl);
      });
    }
  }


  Future<void> _pickImage() async {
    final picker = ImagePicker();
    final prefs = await SharedPreferences.getInstance();
    final pickedFile = await picker.pickImage(source: ImageSource.camera);

    if (pickedFile != null){
      await prefs.setString("profile", "https://i.pinimg.com/736x/1c/8e/97/1c8e97bebfd438b16a2758a40e565a1f.jpg");
    }

    setState(() {
      _profileImage = NetworkImage('https://i.pinimg.com/736x/1c/8e/97/1c8e97bebfd438b16a2758a40e565a1f.jpg');
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
          Text(email, style: TextStyle(
            fontSize: 30
          ),),
          SizedBox(height: 8,),
          //Text(email, style: TextStyle(fontSize: 20),),
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
                Icon(Icons.calendar_month, color: Colors.black,),
                SizedBox(width: 10),
                Text("Participated Events", style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: const Color.fromARGB(255, 90, 85, 85)
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
          IconButton(onPressed:() => {
                                        Navigator.push(context, MaterialPageRoute(builder: (builder) => Mainpage()))
                                      }, icon: Icon(Icons.subdirectory_arrow_left_sharp))
        ],
      ),
    );
  }
}