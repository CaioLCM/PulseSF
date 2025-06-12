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
  List<Map<String, dynamic>> events = [];
  _EventsHandler() async {
    getEvents().then((ev) {
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
        height: 2000,
        child: ListView.builder(
          itemCount: events.length,
          itemBuilder: (context, index) {
            bool upvoted = false;
            events[index]["upvotes"].forEach((vote) {
              if (vote == widget.email) {
                upvoted = true;
              }
            });
            bool downvoted = false;
            events[index]["downvotes"].forEach((vote) {
              if (vote == widget.email) {
                downvoted = true;
              }
            });
            return Column(
              children: [
                ListTile(
                  leading: Text(
                    events[index]["timestamp"]!,
                    style: TextStyle(fontFamily: "Fredoka"),
                  ),
                  title: Text(
                    events[index]["title"]!,
                    style: TextStyle(fontFamily: "Fredoka"),
                  ),
                  subtitle: Text(
                    events[index]["description"]!,
                    style: TextStyle(fontFamily: "Fredoka"),
                  ),
                  trailing: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      downvoted 
                      ? Icon (Icons.arrow_upward, color: Colors.green,)
                      :
                      IconButton(
                        onPressed: () async {
                          await UpVote(widget.email, events[index]["title"]!);
                          _EventsHandler();
                        },
                        icon:
                            upvoted
                                ? CircleAvatar(
                                  backgroundColor: Colors.grey[400],
                                  child: Icon(
                                    Icons.arrow_upward,
                                    color: Colors.green,
                                  ),
                                )
                                : Icon(Icons.arrow_upward, color: Colors.green),
                      ),
                      upvoted
                          ? Icon(Icons.arrow_downward, color: Colors.red)
                          : IconButton(
                            onPressed: () async {
                              await DownVote(
                                widget.email,
                                events[index]["title"],
                              );
                              _EventsHandler();
                            },
                            icon:
                                downvoted
                                    ? CircleAvatar(
                                      backgroundColor: Colors.grey[400],
                                      child: Icon(
                                        Icons.arrow_downward,
                                        color: Colors.red,
                                      ),
                                    )
                                    : Icon(
                                      Icons.arrow_downward,
                                      color: Colors.red,
                                    ),
                          ),
                      CircleAvatar(
                        child: Text(
                          (events[index]["upvotes"]!.length -
                                  events[index]["downvotes"]!.length)
                              .toString(),
                          style: TextStyle(fontFamily: "Fredoka"),
                        ),
                      ),
                    ],
                  ),
                ),
                Divider(),
              ],
            );
          },
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          showModalBottomSheet(
            context: context,
            builder: (context) => Createevent(email: widget.email),
          ).then((_) => _EventsHandler());
        },
        child: Icon(Icons.add),
      ),
    );
  }
}
