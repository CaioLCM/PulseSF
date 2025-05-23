import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:jwt_decoder/jwt_decoder.dart';
import 'package:pulsesf/http/communication.dart';
import 'package:pulsesf/pages/createProjectMenu.dart';
import 'package:pulsesf/pages/mainPage.dart';
import 'package:shared_preferences/shared_preferences.dart';
class Projectspage extends StatefulWidget {
  @override
  State<Projectspage> createState() => _ProjectspageState();
}

class _ProjectspageState extends State<Projectspage> {

  _openProjectCreationModal(BuildContext context){
    showModalBottomSheet(context: context, builder: (_){
      return Createprojectmenu();
    });
  }

  List <project> projects = [];
  String emailOwner = '';

  Future<List<project>> loadProjects() async {
  final prefs = await SharedPreferences.getInstance();
  final jsonList = prefs.getStringList('projects') ?? [];

  final token = prefs.getString("jwt_token");
  final decoded = JwtDecoder.decode(token!);
  final String email = decoded['user']['email']; 

  setState(() {
      emailOwner = email;
  });

  final result = await getProjects();
  return result ?? [];

}

  void initState() {
    super.initState();
    loadProjects().then((loaded) => {
      setState(() {
        projects = loaded;
      })
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          ...(
            projects.isNotEmpty
              ? projects.map((project) {
                  return Container(
                    color: Colors.grey[400],
                    margin: EdgeInsets.all(15),
                    child: ListTile(
                      title: Text(project.name ?? 'No name', style: TextStyle(fontWeight: FontWeight.bold),),
                      subtitle: Text(project.bio),
                      trailing: project.emailOwner == emailOwner? IconButton(onPressed: () async{
                        await removeProject(project.name);
                        final loaded = await loadProjects();
                        setState(() {
                          projects = loaded;
                        });
                        }, icon: Icon(Icons.remove)) : Text("")
                    ),
                  );
                }).toList()
              : [Text('No projects found')]
          ),
        ],
      ), 
       floatingActionButton: FloatingActionButton(
        onPressed: () async {
          await _openProjectCreationModal(context);
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