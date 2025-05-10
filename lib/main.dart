import 'package:flutter/material.dart';

main(){
  runApp(new MyApp());
}

class MyApp extends StatelessWidget {
    @override
  Widget build(BuildContext context) {
    final emailController = new TextEditingController();
    final passwordController = new TextEditingController();
    final border = new OutlineInputBorder(borderRadius: 
    BorderRadius.circular(10)
    );
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
                    SizedBox(height: 70),
                    Text("Email"),
                    SizedBox(height: 10),
                    TextField(
                      controller: emailController,
                      decoration: InputDecoration(
                        labelText: "Email",
                        enabledBorder: border
                      ),
                    ),
                    SizedBox(height: 40),
                    Text("Password"),
                    SizedBox(height: 10),
                    TextField(
                      controller: passwordController,
                      decoration: InputDecoration(
                        labelText: "Password",
                        enabledBorder: border
                      ),
                    ),
                    ElevatedButton(onPressed: null, child: Text("Log in"), style: ButtonStyle(backgroundColor: WidgetStatePropertyAll(Colors.blue))),
                    Text("Don't have an account? Sign up")
                  ],
              ),
            ),
            
        )
      ,)
    );
  }
}