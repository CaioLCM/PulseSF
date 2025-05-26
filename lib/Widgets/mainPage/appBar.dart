import 'package:flutter/material.dart';
import 'package:pulsesf/main.dart';

class MyAppbar extends StatelessWidget {
  String email = '';
  final ImageProvider? _profileImage;

  MyAppbar(this.email, this._profileImage, {super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
            padding: EdgeInsets.all(18),
            decoration: BoxDecoration(
              color: Colors.purple[400]
            ),
            child: 
               Column(
                children: [
                  SizedBox(height: 15,),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                        Row(
                          children: [
                            CircleAvatar(backgroundImage: _profileImage,),
                            SizedBox(width: 15,),
                            Text(email, style: TextStyle(
                              fontFamily: "Fredoka",
                                  color: Colors.white,
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold
                                  )
                                    ),
                            SizedBox(width: 20,),
                            IconButton(onPressed: (){
                              Navigator.push(context, MaterialPageRoute(builder: (builder) => MyApp()));
                            }, icon: Icon(Icons.logout), color: const Color.fromARGB(255, 255, 17, 0),)
                          ],
                        ),
                    ],
                  ),
                ],
            ),
          );
  }
}