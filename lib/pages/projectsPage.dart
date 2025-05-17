import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class Projectspage extends StatefulWidget {
  @override
  State<Projectspage> createState() => _ProjectspageState();
}

class _ProjectspageState extends State<Projectspage> {
  List <String> projects = [];

  void __addProject(){
    setState(() {
      projects.add('Projeto criado');
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
              Text(project),
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
      floatingActionButton: FloatingActionButton(onPressed: __addProject,
          child: Icon(Icons.add),
          backgroundColor: Colors.purple[400],));
  }
}