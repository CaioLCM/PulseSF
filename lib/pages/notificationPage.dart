import 'package:flutter/material.dart';
import 'package:pulsesf/http/communication.dart';

class Notificationpage extends StatefulWidget {
  String email;
  Notificationpage({required this.email});

  @override
  State<Notificationpage> createState() => _NotificationpageState();
}

class _NotificationpageState extends State<Notificationpage> {
  List<String> requests = [];
  @override
  void initState() {
    super.initState();
    searchFriendsRequests(widget.email).then((Loaded) {
      print(Loaded);
      setState(() {
        requests = Loaded;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          requests.isNotEmpty
              ? SizedBox(
                height: 514,
                child: ListView.builder(
                  itemCount: requests.length,
                  itemBuilder: (context, index) {
                    return Card(
                      elevation: 13,
                      child: Padding(
                        padding: const EdgeInsets.all(13.0),
                        child: Row(
                          children: [
                            CircleAvatar(
                              backgroundColor: Colors.green,
                              child: Text(requests[index][0]),
                            ),
                            SizedBox(width: 15),
                            Text(
                              requests[index],
                              style: TextStyle(fontFamily: "Fredoka"),
                            ),
                            SizedBox(width: 30),
                            IconButton(
                              onPressed: () {
                                acceptFriendRequest(
                                  requests[index],
                                  widget.email,
                                );
                                removeFriendRequest(
                                  requests[index],
                                  widget.email,
                                );
                                setState(() {
                                  Navigator.pop(context);
                                });
                              },
                              icon: Icon(
                                Icons.add_circle_outline_sharp,
                                size: 30,
                                color: Colors.green,
                              ),
                            ),
                            SizedBox(width: 40),
                            IconButton(
                              onPressed: () {
                                removeFriendRequest(
                                  requests[index],
                                  widget.email,
                                );
                                setState(() {
                                 Navigator.pop(context);
                                });
                              },
                              icon: Icon(
                                Icons.cancel,
                                size: 30,
                                color: Colors.red,
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                ),
              )
              : Center(
                child: Text(
                  "Nothing to show",
                  style: TextStyle(fontSize: 20, fontFamily: "Fredoka"),
                ),
              ),
        ],
      ),
    );
  }
}
