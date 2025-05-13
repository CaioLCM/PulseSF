import 'package:http/http.dart' as http;

var url = Uri.parse('http://localhost:3000');

void sendRequest() async {
  var response = await http.post(url, body: {"nickname": 'none', 'email': 'none', 'password': 'none'});
}

