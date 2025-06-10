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
  final List<String> _messages = [];


  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _chatService.connect((data){
      setState(() {
        _messages.add(data["text"]);
      });
    });
  }


  void _handleSendMessage(){
    if (_textController.text.isNotEmpty){
      _chatService.senderGlobalMessage(_textController.text, widget.email);
      _textController.clear();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Global chat"),),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              itemCount: 20,
              itemBuilder:(context, index) => Column(
                children: [
                  ListTile(
                    title: Text("User name"),
                    leading: Text("Horário"),
                    trailing: Text("mensagem"),
                  ),
                  Divider()
                ],
              ),
              ),
          ),
            Row(
              children: [
                Expanded(
                  child: TextField(decoration: InputDecoration(
                    label: Text("Insert your message")
                  ),),
                )
              ],
            )
        ],
      ),
    );
  }
}