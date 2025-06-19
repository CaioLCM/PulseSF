import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:pulsesf/Widgets/chat_service.dart';

class ChatPage extends StatefulWidget {
  String email;
  ChatPage({required this.email});
  @override
  State<ChatPage> createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> {
  final ChatService _chatService = ChatService();
  final TextEditingController _textController = TextEditingController();
  List<Map<String, dynamic>> _messages = [];
  bool _isLoading = true;

  Future<void> _loadChat() async {
    final history = await _chatService.fetchGlobalMessageHistory();
    setState(() {
      _isLoading = false;
      _messages = history;
    });

    _chatService.connect((data) {
      setState(() {
        _messages.add(data);
      });
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _loadChat();
  }

  void _handleSendMessage() {
    if (_textController.text.isNotEmpty) {
      _chatService.sendGlobalMessage(_textController.text, widget.email);
      _textController.clear();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Global chat", style: TextStyle(fontFamily: "Fredoka", color: Colors.white)),
      backgroundColor: Colors.purple,
      
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              itemCount: _messages.length,
              itemBuilder:
                  (context, index) => Column(
                    children: [
                      ListTile(
                        title: Text(
                          _messages[index]["senderEmail"],
                          style: TextStyle(fontFamily: "Fredoka"),
                        ),
                        trailing: Text(
                          _messages[index]["timestamp"],
                          style: TextStyle(fontFamily: "Fredoka"),
                        ),
                        subtitle: Text(
                          _messages[index]["text"],
                          style: TextStyle(fontFamily: "Fredoka"),
                        ),
                      ),
                      Divider(),
                    ],
                  ),
            ),
          ),
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
                    _handleSendMessage();
                  },
                  child: Text("Send", style: TextStyle(color: Colors.white),),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
