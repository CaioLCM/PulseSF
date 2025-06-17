import 'package:flutter/material.dart';
import 'package:pulsesf/http/communication.dart';
import 'package:pulsesf/pages/createProjectMenu.dart';

class UserprojectsPage extends StatefulWidget {
  final String user_email;
  const UserprojectsPage({super.key, required this.user_email});

  @override
  State<UserprojectsPage> createState() => _UserprojectsPageState();
}

class _UserprojectsPageState extends State<UserprojectsPage> {
  List<project> projects = [];

  Future<void> _userProjectsHandler(String email) async {
    List<project> _Projects = [];
    getProjects().then((pjs) {
      pjs.forEach((p) {
        if (p.emailOwner == email || p.member_list.contains(email)) {
          _Projects.add(p);
        }
      });
      setState(() {
        projects = _Projects;
      });
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _userProjectsHandler(widget.user_email);
  }

  @override
  Widget build(BuildContext context) {
    print(projects.length);
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Active projects",
          style: TextStyle(color: Colors.white, fontFamily: "Fredoka"),
        ),
        backgroundColor: Colors.purple,
      ),
      body: Column(
        children: [
          Container(
            height: 834,
            child: Card(
              elevation: 15,
              child: Padding(
                padding: const EdgeInsets.all(13.0),
                child: ListView.builder(
                  itemCount: projects.length,
                  itemBuilder:
                      (context, index) {
                      return Column(
                        children: [
                          ListTile(
                            title: Text(
                              projects[index].name,
                              style: TextStyle(fontFamily: "Fredoka"),
                            ),
                            trailing: Text(
                              "Members: ${projects[index].members}",
                              style: TextStyle(fontFamily: "Fredoka"),
                            ),
                            subtitle: Text(
                              projects[index].bio,
                              style: TextStyle(fontFamily: "Fredoka"),
                            ),
                            leading: IconButton(
                              onPressed: () async {
                                await removeUserFromProject(
                                  widget.user_email,
                                  projects[index].name,
                                );
                                await _userProjectsHandler(widget.user_email);
                              },
                              icon: Icon(Icons.exit_to_app, color: Colors.red),
                            ),
                          ),
                          Divider(),
                          SizedBox(height: 15,),
                        ],
                      );
                      },
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
