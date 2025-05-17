import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:shared_preferences/shared_preferences.dart';

class project{
  final String name;
  final String bio;
  final double members;

  project({this.name = 'default', this.bio = 'default', this.members = 0});
  Map<String, dynamic> toJson() => {
    'name': name,
    'bio': bio,
    'members': members
  };
  factory project.fromJson(Map<String, dynamic> json) => project(
    name: json['name'],
    bio: json['bio'],
    members: json['members']
  );
}

Future<void> saveProjects(List<project> projects) async {
  final prefs = await SharedPreferences.getInstance();
  final jsonList = projects.map((project) => jsonEncode(project.toJson())).toList();
  await prefs.setStringList('projects', jsonList);
}


class Createprojectmenu extends StatefulWidget{

  @override
  State<Createprojectmenu> createState() => _CreateprojectmenuState();
}

class _CreateprojectmenuState extends State<Createprojectmenu> {
  List<project> projects = [];

  TextEditingController choice = new TextEditingController();

  TextEditingController ProjectName = new TextEditingController();

  TextEditingController DescribeProject = new TextEditingController();

  double value = 1;

  @override
  Widget build(BuildContext context){
    return Scaffold(
      backgroundColor: Colors.white,
        body: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextField(
              controller: ProjectName,
              decoration: InputDecoration(
              labelText: "Project name",
              prefixIcon: Icon(Icons.insert_drive_file_rounded),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(13) 
              ),
              filled: true,
              fillColor: Colors.grey[100]
            ),
            ),
            SizedBox(height: 15,),
            TextField(
              controller: DescribeProject,
              decoration: InputDecoration(
              labelText: "Describe your project",
              prefixIcon: Icon(Icons.info),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(13) 
              ),
              filled: true,
              fillColor: Colors.grey[100]
            ),
            ),
            SizedBox(height: 15,),
            Text("Max number of students (without couting you): $value"),
            Slider(
              value: value, max: 4, divisions: 4, label: value.toString(), 
              onChanged: (double newValue) => {
                setState(() {
                  value = newValue;
                })
              }),
            ElevatedButton(onPressed: () async {
              final newProject = project(
                name: ProjectName.text,
                bio: DescribeProject.text,
                members: value
              );

              final prefs = await SharedPreferences.getInstance();
              final jsonList = prefs.getStringList('projects') ?? [];

              jsonList.add(jsonEncode(newProject.toJson()));
              await prefs.setStringList('projects', jsonList);

              Navigator.pop(context);

            }, child: Text("Create project"), style: ElevatedButton.styleFrom(
                padding: EdgeInsets.symmetric(horizontal: 50, vertical: 8),
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                textStyle: TextStyle(fontSize: 20)
                )),
          ],
        ),
      );
  }
}