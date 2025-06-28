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
  final ScrollController _scrollController = ScrollController();
  
  List<Map<String, dynamic>> _messages = [];
  bool _isLoading = true;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    _chatService.connect(
      widget.send_email,
      (newMessage) {
        if (mounted){
          setState(() {
            _messages.add(newMessage);
          });
          _scrollToBottom();
        }
      },
    );
    _loadChatHistory();
  }

  @override
  void dispose(){
    _chatService.disconnect();
    _textController.dispose();
    _scrollController.dispose();
    super.dispose();
  }

  Future<void> _loadChatHistory() async {
    setState(() {
      _isLoading = true;
    });
    final history = await _chatService.fetchPrivateMessageHistory(
      widget.send_email,
      widget.receive_email
    );

    if (mounted){
      setState(() {
        _messages = history;
        _isLoading = false;
      });
      _scrollToBottom();
    }
  }

  void _handleSendMessage(){
    if (_textController.text.trim().isEmpty) return;
    final messageText = _textController.text.trim();

    _chatService.sendMessage(messageText, widget.send_email, widget.receive_email);

    setState(() {
      _messages.add({
        "senderEmail": widget.send_email,
        "text": messageText
      });
    });
    _textController.clear();
    _scrollToBottom();
  }

  void _scrollToBottom(){
    WidgetsBinding.instance.addPostFrameCallback((_){
      if (_scrollController.hasClients){
        _scrollController.animateTo(_scrollController.position.maxScrollExtent, 
        duration: const Duration(milliseconds: 300), 
        curve: Curves.easeOut);
      }
    });
  }

  Widget _buildMessageItem(Map<String, dynamic> message){
    final bool isMe = message["senderEmail"] == widget.send_email;

    return Align(
      alignment: isMe? Alignment.centerRight : Alignment.centerLeft,
      child: Container(
        decoration: BoxDecoration(
          color: isMe? Colors.purple : Colors.grey.shade300,
          borderRadius: BorderRadius.circular(16)
        ),
        padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 14),
        margin: const EdgeInsets.symmetric(vertical: 4, horizontal: 8),
        child: Text(
          message["text"] ?? "",
          style: TextStyle(
            fontFamily: "Fredoka",
            fontSize: 15,
            color: isMe? Colors.white : Colors.black87
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.receive_email, style: TextStyle(fontFamily: "Fredoka", color: Colors.white),),
        backgroundColor: Colors.purple,
      ),
      body: Column(
        children: [
        Expanded(
        child: _isLoading ? const Center(child: CircularProgressIndicator(),) 
        : ListView.builder(
        controller: _scrollController,
        padding: const EdgeInsets.all(8),  
        itemCount: _messages.length,
        itemBuilder: (context, index) => _buildMessageItem(_messages[index])
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
                    _handleSendMessage();
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