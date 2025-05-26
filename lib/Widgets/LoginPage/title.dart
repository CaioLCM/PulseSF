import 'package:flutter/material.dart';
    class MainTitle extends StatelessWidget {
  const MainTitle({super.key});

      @override
      Widget build(BuildContext context){
        return
        Text("PulseSF", style: TextStyle(
                color: Colors.purple[400],
                fontSize: 80,
                fontWeight: FontWeight.bold
                )
        );
      }
    }