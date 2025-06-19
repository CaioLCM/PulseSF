import 'package:flutter/material.dart';
import 'package:pulsesf/Widgets/chat_service.dart';

class MessagePage extends StatefulWidget {
  final String send_email;
  final String receive_email;
  const MessagePage({required this.send_email, required this.receive_email});

  @override
  State<MessagePage> createState() => _MessagePageState();
}

class _MessagePageState extends State<MessagePage> {
  final ChatService _chatService = ChatService();
  final TextEditingController _textController = TextEditingController();
  List<Map<String, dynamic>> _messages = [];
  bool _isLoading = true;

  Future<void> _loadChat() async{
    final history = await _chatService.fetchMessageHistory();
    setState(() {
      _isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.receive_email, style: TextStyle(fontFamily: "Fredoka", color: Colors.white),),
        backgroundColor: Colors.purple,
      ),
      body: Column(children: [
        Expanded(child: ListView.builder(itemCount: _messages.length,
        itemBuilder: (context, index) => Column(
          children: [
            ListTile(
              title: Text(
                _messages[index]["senderEmail"],
                style: TextStyle(fontFamily: "Fredoka"),
              ),
              subtitle: Text(
                _messages[index]["text"],
                style: TextStyle(fontFamily: "Fredoka"),
              ),
            ),
            Divider()
          ],
        ),
        )),
        Container(
            color: Colors.purple,
            padding: EdgeInsets.all(8),
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    minLines: 1,
                    maxLines: 30,
                    controller: _textController,
                    style: TextStyle(
                      color: Colors.white,
                      fontFamily: "Fredoka",
                    ),
                    decoration: InputDecoration(
                      label: Text(
                        "Insert a message",
                        style: TextStyle(
                          color: Colors.white,
                          fontFamily: "Fredoka",
                        ),
                      ),
                    ),
                  ),
                ),
                ElevatedButton(
                  style: ButtonStyle(
                    backgroundColor: WidgetStateProperty.all<Color>(
                      Colors.purpleAccent,
                    ),
                    textStyle: WidgetStateProperty.all<TextStyle>(
                      TextStyle(color: Colors.white, fontFamily: "Fredoka"),
                    ),
                  ),
                  onPressed: () {
                    //_handleSendMessage();
                  },
                  child: Text("Send", style: TextStyle(color: Colors.white),),
                ),
      ],),
    )
    ],
    ),
    );
  }
}