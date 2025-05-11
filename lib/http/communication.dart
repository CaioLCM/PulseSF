import 'package:http/http.dart' as http;

var url = Uri.parse('http://localhost:3000');

void sendRequest() async {
  var response = await http.post(url);
  print('Response status: ${response.statusCode}');
  print('Response text: ${response.body}');
}

