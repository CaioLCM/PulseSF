import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
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
    loadProjects().then((loaded) {
      setState(() {
        projects = loaded;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(padding: const EdgeInsets.all(16),
      child: projects.isEmpty
      ? Center(child: Text("Create the firts project!"),)
      : ListView.builder(itemCount: projects.length,
      itemBuilder: (context, index){
        final project = projects[index];
        return Container(
          margin: EdgeInsets.symmetric(vertical: 8),
          padding: EdgeInsets.all(16),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(12),
            color: Colors.grey[200]
          ),
          child: Row(
            children: [
              Expanded(
  child: Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Text(project.name, style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16, color: const Color.fromARGB(255, 90, 85, 85))),
      Text(project.bio, style: TextStyle(color: const Color.fromARGB(255, 90, 85, 85)),),
      Text('Members: ${project.members.toInt()}', style: TextStyle(color: const Color.fromARGB(255, 90, 85, 85)),),
    ],
  ),
),
              IconButton(onPressed: () => setState(() {
                 projects.removeAt(index);
              }), icon: Icon(Icons.remove_circle, color: Colors.red,), 
              ),
            ],
          ),
        );
      },
      )
      ),
      floatingActionButton: FloatingActionButton(onPressed: () async 
      {
        await Navigator.push(context, 
        MaterialPageRoute(builder: (builder) => Createprojectmenu()));
        final loaded = await loadProjects();
        setState(() {
          projects = loaded;
        });
        },
          child: Icon(Icons.add),
          backgroundColor: Colors.purple[400],));
  }
}