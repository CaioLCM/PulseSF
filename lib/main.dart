import 'package:flutter/material.dart';

main(){
  runApp(new MyApp());
}

class MyApp extends StatelessWidget {
    @override
  Widget build(BuildContext context) {
    final emailController = new TextEditingController();
    final passwordController = new TextEditingController();
    final border_input = new OutlineInputBorder(borderRadius: 
    BorderRadius.circular(12),
    borderSide: const BorderSide(color: Colors.transparent),
    );
    final border = new OutlineInputBorder(borderRadius: BorderRadius.circular(12));
    
    return(
      MaterialApp(home: 
        Scaffold(
          backgroundColor: Colors.white,
            body:
            SafeArea(child: 
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(height: 80),
                Text("PulseSF", style: TextStyle(
                  color: Colors.purple[400],
                  fontSize: 80,
                  fontWeight: FontWeight.bold
                  ),
                  ),
                  SizedBox(height: 70),
                  Text("Email", style: TextStyle(fontWeight:FontWeight.bold),),
                  SizedBox(height: 10),
                  TextField(
                    controller: emailController,
                    decoration: InputDecoration(
                      prefixIcon: Icon(Icons.email),
                      labelText: "Email",
                      enabledBorder: border_input,
                      focusedBorder: border_input,
                      filled: true,
                      fillColor: Colors.grey[100],

                    ),
                  ),
                  SizedBox(height: 40),
                  Text("Password", style: TextStyle(fontWeight: FontWeight.bold),),
                  SizedBox(height: 10),
                  TextField(
                    controller: passwordController,
                    decoration: InputDecoration(
                      prefixIcon: Icon(Icons.lock),
                      labelText: "Password",
                      enabledBorder: border_input,
                      focusedBorder: border_input,
                      filled: true,
                      fillColor: Colors.grey[100]
                    ),
                  ),
                  SizedBox(height: 50),
                  ElevatedButton(onPressed: null, child: Text("Log in"), 
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.deepPurple,
                    padding: EdgeInsets.symmetric(horizontal: 50, vertical: 8),
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                    textStyle: TextStyle(fontSize: 20)
                  )
                  
                  ),
                  SizedBox(height: 10),
                  Text("Don't have an account?", style: TextStyle(fontWeight: FontWeight.bold)),
                  TextButton(onPressed: null, child: Text("Sign up"), style: 
                  ButtonStyle(
                    textStyle: WidgetStatePropertyAll(TextStyle(color: Colors.blue))
                  ),)
                ],
            ),
            ),   
        )
      ,)
    );
  }
}