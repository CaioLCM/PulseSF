import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:jwt_decoder/jwt_decoder.dart';
import 'package:pulsesf/http/communication.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Biopage extends StatefulWidget {
  @override
  State<Biopage> createState() => _Biopage();
}

class _Biopage extends State<Biopage> {
  String email = "";

  TextEditingController bio_controller = new TextEditingController();

  Future<String> searchInfo() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    final token = prefs.getString("jwt_token");
    if (token != null) {
      final decoded_token = JwtDecoder.decode(token);
      final email_token = decoded_token["user"]["email"];
      return await searchBio(email_token);
    } else {
      return "Insert your info";
    }
  }

  @override
  void initState() {
    super.initState();
    searchInfo().then(
      (bio) => {
        setState(() {
          bio_controller.text = bio;
        }),
      },
    );
  }

  Future<void> updateBIO() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    final token = prefs.getString("jwt_token");
    if (token != null) {
      final decoded_token = JwtDecoder.decode(token);
      final email = decoded_token["user"]["email"];
      await updateBio(email, bio_controller.text);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: Column(
          children: [
            Container(
              child: TextField(
                maxLines: 14,
                controller: bio_controller,
                decoration: InputDecoration(
                  label: Center(
                    child: Text("BIO", style: TextStyle(fontFamily: "Fredoka")),
                  ),
                ),
              ),
            ),
            ElevatedButton(
              onPressed: () {
                updateBIO().then((_) {
                  Navigator.pop(context);
                });
              },
              child: Text("Save", style: TextStyle(fontFamily: "Fredoka")),
              style: ButtonStyle(
                padding: WidgetStateProperty.all(EdgeInsets.symmetric(horizontal: 100, vertical: 15)),
                elevation: WidgetStatePropertyAll(10.0),
                ),
            ),
          ],
        ),
      ),
    );
  }
}
