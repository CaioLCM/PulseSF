import 'package:flutter/material.dart';
import 'package:pulsesf/http/communication.dart';

class AttendingEventsPage extends StatefulWidget {
  final String email;
  const AttendingEventsPage({super.key, required this.email});

  @override
  State<AttendingEventsPage> createState() => _AttendingEventsPageState();
}

class _AttendingEventsPageState extends State<AttendingEventsPage> {
List<Map<String, dynamic>> user_events = [];

_EventsHandler(String email) async {
  List<Map<String, dynamic>> _user_events = [];
  getEvents().then((eve) {
    eve.forEach((E){
      if (E["upvotes"].contains(email) || E["emailOwner"] == email) {
        _user_events.add(E);
      }
    });
    setState(() {
    user_events = _user_events;
  });
  });
}

@override
  void initState() {
    // TODO: implement initState
    super.initState();
    _EventsHandler(widget.email);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Attending events", style: TextStyle(fontFamily: "Fredoka", color: Colors.white),),backgroundColor: Colors.purple,),
      body: Column(
        children: [
          Container(
            height: 834,
            child: Padding(
              padding: const EdgeInsets.all(13.0),
              child: ListView.builder(
                itemCount: user_events.length,
                itemBuilder: (context, index){
                  return ListTile(
                    title: Text(user_events[index]["title"], style: TextStyle(fontFamily: "Fredoka"),),
                    subtitle: Text(user_events[index]["description"], style: TextStyle(fontFamily: "Fredoka"),),
                    leading: Text(user_events[index]["timestamp"], style: TextStyle(fontFamily: "Fredoka"),),
                    trailing: CircleAvatar(
                      child: Text((user_events[index]["upvotes"].length - user_events[index]["downvotes"].length).toString()),
                    ),
                  );
                  Divider();
                  SizedBox(height: 15,);
                },),
            ),
          )
        ],
      ),
    );
  }
}