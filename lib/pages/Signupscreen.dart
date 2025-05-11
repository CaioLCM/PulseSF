import 'package:flutter/material.dart';

class Signupscreen extends StatelessWidget{
  @override
  Widget build(BuildContext context){
    return Scaffold(
        body: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text("Create account"),
            TextField(decoration: InputDecoration(
              labelText: "Name",
              icon: Icon(Icons.person)
            ),
            ),
            TextField(decoration: InputDecoration(
              labelText: "Email",
              icon: Icon(Icons.email)
            ),
            ),
            TextField(decoration: InputDecoration(
              labelText: "Password",
              icon: Icon(Icons.lock)
            ),
            ),
            TextField(decoration: InputDecoration(
              labelText: "Comfirm Password",
              icon: Icon(Icons.lock)
            ),
            ),
            ElevatedButton(onPressed: null, child: Text("Sign Up")),
            Text("Already have an account?"),
            TextButton(onPressed: () => {
              Navigator.pop(context)
            }, child: Text("Log in"))
          ],
        ),
      );
  }
}
