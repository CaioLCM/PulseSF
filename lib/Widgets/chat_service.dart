import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:socket_io_client/socket_io_client.dart' as IO;

class ChatService {
  late IO.Socket socket;

  Future<List<Map<String, dynamic>>> fetchGlobalMessageHistory() async{
    try{
      final response = await http.get(Uri.parse("http://10.0.2.2:3000/Globalmessages"));
      if (response.statusCode == 200){
        List<dynamic> messagesJson = json.decode(response.body);
        return messagesJson.cast<Map<String, dynamic>>();
      } else {
        print("Error to search history: ${response.statusCode}");
        return [];
      }
    } catch (e) {
      print("Exception to search history: $e");
      return [];
    }
  } 

  Future<void> fetchLocalMessageHistory() async{
    try{
      final response = await http.get(Uri.parse("http://10.0.2.2:3000/Localmessages"));
      if (response.statusCode == 200){
        List<dynamic> messagesJson = json.decode(response.body);
        //return messagesJson.cast<Map<String, dynamic>>();
      }
    } catch (error){
      print(error);
    }
  }

  void connect(Null Function(dynamic data) onNewMessage){
    socket = IO.io('http://10.0.2.2:3000', {
      'transports': ['websocket'],
      'autoConnect': false
    });

    socket.connect();

    socket.onConnect((_){
      print("Connected to server");
    });

    socket.on("newMessage", (data) {
      print("New message: $data");
      onNewMessage(data);
    });
    socket.onDisconnect((_) => print("Desconected"));
  }

  void sendGlobalMessage(String text, String senderEmail){
    socket.emit('sendGlobalMessage', {
      'text': text,
      'senderEmail': senderEmail,
      'timestamp': DateTime.now().toIso8601String()
    });
  }

  void sendMessage(String text, String senderEmail, String receiverEmail){
    socket.emit('sendMessage', {
      'text': text,
      'senderId': senderEmail,
      'receiverId': receiverEmail,
      'timestamp': DateTime.now().toIso8601String()
    });
  }
  void disconnect(){
    socket.disconnect();
  }
}
