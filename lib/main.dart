import 'package:flutter/material.dart';

main(){
  runApp(new MyApp());
}

class MyApp extends StatelessWidget {
    @override
  Widget build(BuildContext context) {
    final emailController = new TextEditingController();
    final passwordController = new TextEditingController();
    return(
      MaterialApp(home: 
        Scaffold(
            body: 
            Center(
              child: Column(
                children: [
                  SizedBox(height: 80),
                  Text("PulseSF", style: TextStyle(
                    color: Colors.purple[400],
                    fontSize: 80,
                    fontWeight: FontWeight.bold
                    ),
                    ),
                    SizedBox(height: 30),
                    TextField(
                      controller: emailController,
                      decoration: InputDecoration(
                        labelText: "Email",
                      ),
                    ),
                    SizedBox(height: 15),
                    TextField(
                      controller: passwordController,
                      decoration: InputDecoration(
                        labelText: "Password"
                      ),
                    )
                  ],
              ),
            ),
            
        )
      ,)
    );
  }
}