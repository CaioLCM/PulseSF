import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:pulsesf/http/communication.dart';
import 'package:pulsesf/pages/createProjectMenu.dart';
import 'package:shared_preferences/shared_preferences.dart';

Future<List<project>> loadProjects() async {
  final prefs = await SharedPreferences.getInstance();
  final jsonList = prefs.getStringList('projects') ?? [];

  return jsonList.map((jsonString) => project.fromJson(jsonDecode(jsonString))).toList();
}
class Projectspage extends StatefulWidget {
  @override
  State<Projectspage> createState() => _ProjectspageState();
}

class _ProjectspageState extends State<Projectspage> {
  List <project> projects = [];

  void initState() {
    super.initState();
    getProjects();
    loadProjects().then((loaded) {
      setState(() {
        projects = loaded;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder<List<project>>(future: 
      getProjects(), 
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting){
          return Center(child: CircularProgressIndicator());
        } else if (snapshot.hasError) {
          return Center(child: Text("Error: ${snapshot.error}"));
        } else if (!snapshot.hasData || snapshot.data!.isEmpty){
          return Center(child: Text("Nenhum projeto encontrado"));
        }

        final projects = snapshot.data!;
        return ListView.builder(itemCount: projects.length, itemBuilder: (context, index) {
          final proj = projects[index];
          return ListTile(
            title: Text(proj.name),
            subtitle: Text(proj.bio),
            trailing: Text("${proj.members} members"),
          );
        });
      },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          await Navigator.push(
            context,
            MaterialPageRoute(builder: (builder) => Createprojectmenu()),
          );
          final loaded = await loadProjects();
          setState(() {
            projects = loaded;
          });
        },
        child: Icon(Icons.add),
        backgroundColor: Colors.purple[400],
      ),
    );
  }
}