import 'package:flutter/material.dart';

main(){
  runApp(new MyApp());
}

class MyApp extends StatelessWidget {
    @override
  Widget build(BuildContext context) {
    return(
      MaterialApp(home: 
        Scaffold(
          appBar: AppBar(
            title: Text("PulseSF"),
            ),
          body: Text("This is the beggining of PulseSF!!!"),
        )
      ,)
    );
  }
}