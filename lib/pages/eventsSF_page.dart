import 'package:flutter/material.dart';
import 'package:pulsesf/http/communication.dart';
import 'package:pulsesf/pages/createEvent.dart';

class EventssfPage extends StatefulWidget {
  final email;
  const EventssfPage({required this.email});

  @override
  State<EventssfPage> createState() => EventssfPageState();
}

class EventssfPageState extends State<EventssfPage> {
  List<Map<String, String>> events = [];
  _EventsHandler() async{
    getEvents().then((ev){
      setState(() {
        events = ev;
      });
    });
  }
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _EventsHandler();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Events San Francisco",
          style: TextStyle(color: Colors.white, fontFamily: "Fredoka"),
        ),
        backgroundColor: Colors.purple,
      ),
      body: Container(
        height: 300,
        child: ListView.builder(
          itemCount: events.length,
          itemBuilder:
              (context, index) => Column(
                children: [
                  ListTile(
                    leading: Text(events[index]["timestamp"]!, style: TextStyle(fontFamily: "Fredoka"),),
                    title: Text(events[index]["title"]!, style: TextStyle(fontFamily: "Fredoka"),),
                    subtitle: Text(
                      events[index]["description"]!, style: TextStyle(fontFamily: "Fredoka"),
                    ),
                    trailing: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        IconButton(
                          onPressed: () {},
                          icon: Icon(Icons.arrow_upward, color: Colors.green),
                        ),
                        IconButton(
                          onPressed: () {},
                          icon: Icon(Icons.arrow_downward, color: Colors.red),
                        ),
                        CircleAvatar(child: Text("0", style: TextStyle(fontFamily: "Fredoka"),)),
                      ],
                    ),
                  ),
                  Divider(),
                ],
              ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          showModalBottomSheet(
            context: context,
            builder: (context) => Createevent(email: widget.email,)
          );
        },
        child: Icon(Icons.add),
      ),
    );
  }
}
