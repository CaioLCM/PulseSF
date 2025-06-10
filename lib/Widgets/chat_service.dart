import 'package:socket_io_client/socket_io_client.dart' as IO;

class ChatService {
  late IO.Socket socket;

  void connect(Null Function(dynamic data) param0){
    socket = IO.io('http://10.0.2.2:3000', {
      'transports': ['websocket'],
      'autoConnect': false
    });

    socket.connect();

    socket.onConnect((_){
      print("conectado ao servidor");
    });

    socket.on("newMessage", (data) {
      print("Nova mensagem recebida: $data");

    });
    socket.onDisconnect((_) => print("Desconectado do servidor"));
  }

  void senderGlobalMessage(String text, String senderEmail){
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