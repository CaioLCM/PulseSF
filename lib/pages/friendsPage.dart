import 'package:flutter/material.dart';
import 'package:pulsesf/http/communication.dart';
import 'package:pulsesf/pages/displayProfiles.dart';

class Friendspage extends StatefulWidget {
  String email;
  Friendspage({required this.email});

  @override
  State<Friendspage> createState() {
    return _FriendspageState();
  }
}

class _FriendspageState extends State<Friendspage> {
  List<String> friends = [];
  List<String> profile_pictures = [];

  _getFriends() async {
    List <String> pictures = [];
    await searchFriends(widget.email).then(
      (Loaded) => {
        for (int i =0; i < Loaded.length; i ++){
          searchForProfilePicture(Loaded[i]).then((pfp){
            pictures.add(pfp);
          })
        },
        setState(() {
          friends = Loaded;
          profile_pictures = pictures;
        }),
      },
    );
  }

  @override
  void initState() {
    super.initState();
    setState(() {
      _getFriends();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Friends"),
        backgroundColor: Colors.purple,
        titleTextStyle: TextStyle(
          color: Colors.white,
          fontSize: 17,
          fontFamily: "Fredoka",
        ),
      ),
      body: 
      friends.length > 0
      ? ListView.builder(
        itemCount: friends.length,
        itemBuilder: (context, index) {
          return GestureDetector(onTap: () {
            Navigator.of(context).push(MaterialPageRoute(builder: (builder) => Displayprofiles(email: friends[index], profile_picture: profile_pictures[index])));
          }, child: 
          Card(
            elevation: 15,
            child: ListTile(
              title: Row(
                children: [
                  // need to add profile picture lol
                  Text(friends[index]),
                  SizedBox(width: 60,),
                  IconButton(onPressed: (){removeFriend(widget.email, friends[index]).then(
                    (removed){
                      if (removed){
                        setState(() {
                          _getFriends();
                        });
                      }
                    }
                  );
                  }, icon: Icon(Icons.remove_circle))
                  //remove friend option
                ],
              ),
            ),
          ));
        },
      )
      : Center(child: Text("Add your first friend!", style: TextStyle(fontSize: 17, fontFamily: "Fredoka"),))
    );
  }
}
