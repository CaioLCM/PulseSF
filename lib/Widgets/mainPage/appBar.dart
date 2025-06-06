import 'package:flutter/material.dart';
import 'package:pulsesf/http/communication.dart';
import 'package:pulsesf/main.dart';
import 'package:pulsesf/pages/bioPage.dart';
import 'package:pulsesf/pages/notificationPage.dart';

class MyAppbar extends StatefulWidget {
  String email = '';
  final ImageProvider? _profileImage;
  MyAppbar(this.email, this._profileImage, {super.key});

  @override
  State<MyAppbar> createState() => _MyAppbarState();
}

class _MyAppbarState extends State<MyAppbar> {

  @override
  Widget build(BuildContext context) {
    void _openNotificationsModal(BuildContext context){
    showModalBottomSheet(context: context, 
      builder: (_) => Notificationpage(email: widget.email,)
      );
  }

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
                            CircleAvatar(backgroundImage: widget._profileImage,),
                            SizedBox(width: 15,),
                            Text(widget.email, style: TextStyle(
                              fontFamily: "Fredoka",
                                  color: Colors.white,
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold
                                  )
                                    ),
                            SizedBox(width: 20,),
                            IconButton(onPressed: (){
                              Navigator.push(context, MaterialPageRoute(builder: (builder) => MyApp()));
                            }, icon: Icon(Icons.logout), color: const Color.fromARGB(255, 255, 17, 0),),
                            IconButton(onPressed: (){_openNotificationsModal(context);}, icon: Icon(Icons.notifications)),
                          ],
                        ),
                    ],
                  ),
                ],
            ),
          );
  }
}