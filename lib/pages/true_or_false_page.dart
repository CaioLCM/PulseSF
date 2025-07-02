import 'package:flutter/material.dart';
import 'package:pulsesf/pages/true_or_false_option.dart';

class TrueOrFalsePage extends StatefulWidget {
  final String email;
  const TrueOrFalsePage({super.key, required this.email});

  @override
  State<TrueOrFalsePage> createState() => _TrueOrFalsePageState();
}

class _TrueOrFalsePageState extends State<TrueOrFalsePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.purple,
        title: const Text(
          "True or False",
          style: TextStyle(fontFamily: "Fredoka", color: Colors.white),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text(
              widget.email,
              textAlign: TextAlign.center,
              style: const TextStyle(fontFamily: "Fredoka", fontSize: 20),
            ),
            const SizedBox(height: 24),

            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.green,
                padding: const EdgeInsets.symmetric(vertical: 20),
                textStyle: const TextStyle(fontSize: 22, fontFamily: "Fredoka"),
              ),
              onPressed: () {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder:
                        (_) =>
                            TrueOrFalseOption(email: widget.email, level: "Easy"),
                  ),
                ); 
              },
              child: const Text("Easy", style: TextStyle(color: Colors.white)),
            ),
            const SizedBox(height: 20),

            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.blue,
                padding: const EdgeInsets.symmetric(vertical: 20),
                textStyle: const TextStyle(fontSize: 22, fontFamily: "Fredoka"),
              ),
              onPressed: () {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder:
                        (_) => TrueOrFalseOption(
                          email: widget.email,
                          level: "medium",
                        ),
                  ),
                );
              }, 
              child: const Text(
                "Normal",
                style: TextStyle(color: Colors.white),
              ),
            ),
            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }
}

