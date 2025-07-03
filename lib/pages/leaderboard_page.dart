import 'package:flutter/material.dart';
import 'package:pulsesf/http/communication.dart';

class LeaderboardPage extends StatefulWidget {
  const LeaderboardPage({super.key});

  @override
  State<LeaderboardPage> createState() => _LeaderboardPageState();
}

class _LeaderboardPageState extends State<LeaderboardPage> {
  late Future<List<Map<String, dynamic>>> _leaderboardFuture;

  @override
  void initState() {
    super.initState();
    _leaderboardFuture = fetchLeaderboard();
  }

  void _refreshLeaderboard() {
    setState(() {
      _leaderboardFuture = fetchLeaderboard();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.purple,
        title: const Text(
          "Leaderboard",
          style: TextStyle(fontFamily: "Fredoka", color: Colors.white),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.refresh, color: Colors.white),
            onPressed: _refreshLeaderboard,
          ),
        ],
      ),
      body: FutureBuilder<List<Map<String, dynamic>>>(
        future: _leaderboardFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }

          if (snapshot.hasError || !snapshot.hasData || snapshot.data!.isEmpty) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text(
                    'Leaderboard still empty!',
                    style: TextStyle(fontFamily: "Fredoka", fontSize: 18),
                  ),
                  const SizedBox(height: 16),
                  ElevatedButton(
                    onPressed: _refreshLeaderboard,
                    child: const Text("Try again"),
                  )
                ],
              ),
            );
          }

          final leaderboard = snapshot.data!;

          return ListView.builder(
            itemCount: leaderboard.length,
            itemBuilder: (context, index) {
              final user = leaderboard[index];
              final rank = index + 1;

              return Card(
                margin:
                    const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                child: ListTile(
                  leading: CircleAvatar(
                    backgroundColor:
                        rank <= 3 ? Colors.amber.shade600 : Colors.purple.shade100,
                    child: Text(
                      '$rank',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: rank <= 3 ? Colors.white : Colors.purple,
                      ),
                    ),
                  ),
                  title: Text(
                    user['email'] ?? 'User',
                    style: const TextStyle(
                        fontFamily: "Fredoka", fontWeight: FontWeight.bold),
                  ),
                  trailing: Text(
                    '${user['points'] ?? 0} pts',
                    style: const TextStyle(
                      fontSize: 16,
                      color: Colors.green,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }
}