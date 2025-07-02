import 'package:flutter/material.dart';

class LeaderboardPage extends StatefulWidget {
  const LeaderboardPage({super.key});

  @override
  State<LeaderboardPage> createState() => _LeaderboardPageState();
}

class _LeaderboardPageState extends State<LeaderboardPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.purple,
        title: const Text(
          "Leaderboard",
          style: TextStyle(fontFamily: "Fredoka", color: Colors.white),
        ),
      ),
      body: Container(
        height: 5000,
        child: ListView.builder(
          itemCount: 50,
          itemBuilder:(context, index) {
           return Padding(
              padding: const EdgeInsets.all(8.0),
              child: ListTile(
                leading: CircleAvatar(
                  backgroundColor: Colors.purple,
                  child: Text(
                    (index + 1).toString(),
                    style: const TextStyle(color: Colors.white, fontSize: 20),
                  ),
                ),
                title: Text(
                  "User ${index + 1}",
                  style: const TextStyle(fontFamily: "Fredoka", fontSize: 18),
                ),
                subtitle: const Text(
                  "Score: 100",
                  style: TextStyle(fontFamily: "Fredoka", fontSize: 16),
                ),
              ),
            );
          }, 
          ),
      ),
    );
  }
} 