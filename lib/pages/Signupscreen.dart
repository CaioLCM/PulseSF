import 'package:flutter/material.dart';

class Signupscreen extends StatelessWidget{
  
  TextEditingController user = new TextEditingController();
  TextEditingController email = new TextEditingController();
  TextEditingController password = new TextEditingController();
  TextEditingController confirmPassword = new TextEditingController();
  @override
  Widget build(BuildContext context){
    return Scaffold(
      backgroundColor: Colors.white,
        body: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text("Create account"),
            TextField(
              controller: user,
              decoration: InputDecoration(
              labelText: "Name",
              prefixIcon: Icon(Icons.person),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(13) 
              ),
              filled: true,
              fillColor: Colors.grey[100]
            ),
            ),
            SizedBox(height: 15,),
            TextField(
              controller: email,
              decoration: InputDecoration(
              labelText: "Email",
              prefixIcon: Icon(Icons.email),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(13) 
              ),
              filled: true,
              fillColor: Colors.grey[100]
            ),
            ),
            SizedBox(height: 15,),
            TextField(controller: password, decoration: InputDecoration(
              labelText: "Password",
              prefixIcon: Icon(Icons.password),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(13) 
              ),
              filled: true,
              fillColor: Colors.grey[100]
            ),
            ),
            SizedBox(height: 15,),
            TextField(
              controller: confirmPassword,
              decoration:InputDecoration(
              labelText: "Comfirm Password",
              prefixIcon: Icon(Icons.password),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(13) 
              ),
              filled: true,
              fillColor: Colors.grey[100]
            ),
            ),
            SizedBox(height: 15,),
            ElevatedButton(onPressed: null, child: Text("Sign Up"), style: ElevatedButton.styleFrom(
                padding: EdgeInsets.symmetric(horizontal: 50, vertical: 8),
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                textStyle: TextStyle(fontSize: 20)
                )),
            Text("Already have an account?"),
            TextButton(onPressed: () => {
              Navigator.pop(context)
            }, child: Text("Log in"))
          ],
        ),
      );
  }
}
