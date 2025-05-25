import 'dart:convert';
import 'dart:math';

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
  String user_email = '';
  _openProjectCreationModal(BuildContext context) {
    showModalBottomSheet(
      context: context,
      builder: (_) {
        return Createprojectmenu();
      },
    );
  }

  Future<void> _loadUserEmail() async {
    final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString("jwt_token");
    final decoded = JwtDecoder.decode(token!);
    final String email = decoded['user']['email'];
    setState(() {
      user_email = email;
    });
  }

  Future<ImageProvider<Object>>? _loadProfileImage(String email) async {
    final imageString = await searchForProfilePicture(email);
    if (imageString != null) {
      final _profileImage = MemoryImage(base64Decode(imageString));
      return _profileImage;
    } else {
      final _profileImage = MemoryImage(
        base64Decode(
          "/9j/4QGvRXhpZgAATU0AKgAAAAgABwEQAAIAAAAUAAAAYgEAAAQAAAABAAAFoAEBAAQAAAABAAAHgAEyAAIAAAAUAAAAdgESAAMAAAABAAEAAIdpAAQAAAABAAAAkQEPAAIAAAAHAAAAigAAAABzZGtfZ3Bob25lNjRfeDg2XzY0ADIwMjU6MDU6MjEgMjQ6MDA6MzIAR29vZ2xlAAAQgp0ABQAAAAEAAAFXgpoABQAAAAEAAAFfkpIAAgAAAAQ3NDEAkpEAAgAAAAQ3NDEAkpAAAgAAAAQ3NDEAkgoABQAAAAEAAAFnkgkAAwAAAAEAAAAAiCcAAwAAAAEAZAAAkAQAAgAAABQAAAFvkAMAAgAAABQAAAGDoAMABAAAAAEAAAeApAMAAwAAAAEAAAAAoAIABAAAAAEAAAWgkgIABQAAAAEAAAGXkgEACgAAAAEAAAGfkAAABwAAAAQwMjIwAAAAAAAAAK0AAABkACKgxzuaygAAABEcAAAD6DIwMjU6MDU6MjEgMjQ6MDA6MzIAMjAyNTowNToyMSAyNDowMDozMgAAAACeAAAAZAAAIk8AAAPo/+AAEEpGSUYAAQEAAAEAAQAA/9sAQwACAQEBAQECAQEBAgICAgIEAwICAgIFBAQDBAYFBgYGBQYGBgcJCAYHCQcGBggLCAkKCgoKCgYICwwLCgwJCgoK/9sAQwECAgICAgIFAwMFCgcGBwoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoK/8AAEQgHgAWgAwEiAAIRAQMRAf/EAB8AAAEFAQEBAQEBAAAAAAAAAAABAgMEBQYHCAkKC//EALUQAAIBAwMCBAMFBQQEAAABfQECAwAEEQUSITFBBhNRYQcicRQygZGhCCNCscEVUtHwJDNicoIJChYXGBkaJSYnKCkqNDU2Nzg5OkNERUZHSElKU1RVVldYWVpjZGVmZ2hpanN0dXZ3eHl6g4SFhoeIiYqSk5SVlpe",
        ),
      );
      return _profileImage;
    }
  }

  List<project> projects = [];

  Future<List<project>> loadProjects() async {
    final result = await getProjects();
    return result ?? [];
  }

  List<List<String>> projects_members = [];

  void initState() {
    super.initState();
    _loadUserEmail();
    loadProjects().then(
      (loaded) => {
        setState(() {
          projects_members = [];
          projects = loaded;
          projects.forEach((project) {
            print(project.member_list);
            List<dynamic>? rawMemberList = project.member_list;
           
            if (rawMemberList != null){
              projects_members.add(List<String>.from(rawMemberList.map((item) => item.toString())));
            } else {
              projects_members.add(<String>[]);
            }
          });
        }),
      //print(projects_members)
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          ...(projects.isNotEmpty
              ? projects.map((project) {
                return Container(
                  color: Colors.grey[400],
                  margin: EdgeInsets.all(15),
                  child: ListTile(
                    title: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        project.name ?? 'No name',
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                    ),
                    subtitle: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: const EdgeInsets.fromLTRB(8, 0, 0, 20),
                          child: Text(project.bio),
                        ),
                        Container(
                          height: 50,
                          child: Wrap(
                            children: [
                              Padding(
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 4.0,
                                ),
                                child: FutureBuilder<ImageProvider<Object>?>(
                                  future: _loadProfileImage(project.emailOwner),
                                  builder: (context, snapshot) {
                                    if (snapshot.connectionState ==
                                        ConnectionState.waiting) {
                                      return CircleAvatar(
                                        child: CircularProgressIndicator(
                                          strokeWidth: 2.0,
                                        ),
                                      );
                                    } else if (snapshot.hasError) {
                                      return CircleAvatar(
                                        child: Icon(Icons.error_outline),
                                      );
                                    } else if (snapshot.hasData &&
                                        snapshot.data != null) {
                                      return CircleAvatar(
                                        backgroundImage: snapshot.data,
                                      );
                                    } else {
                                      return CircleAvatar(
                                        child: Icon(Icons.person_outline),
                                      );
                                    }
                                  },
                                ),
                              ),
                              SizedBox(
                                height: 40,
                                child: ListView.builder(
                                  itemCount: project.members.toInt(),
                                  shrinkWrap: true,
                                  scrollDirection: Axis.horizontal,
                                  itemBuilder: (context, index) {
                                    return Padding(
                                      padding: const EdgeInsets.symmetric(
                                        horizontal: 4.0,
                                      ),
                                      child: Stack(
                                        children: [
                                          CircleAvatar(
                                            child: IconButton(
                                              onPressed: () {
                                                int projectActualIndex =
                                                    projects.indexWhere(
                                                      (p) => p == project,
                                                    );
                                                if (projectActualIndex != -1 &&
                                                    !projects_members[projectActualIndex]
                                                        .contains(user_email) &&
                                                    user_email !=
                                                        project.emailOwner && (project.member_list).length <= int.parse(project.members.toString())) {
                                                  setState(() {
                                                    projects_members[projectActualIndex] = [
                                                      ...projects_members[projectActualIndex],
                                                      user_email,
                                                    ];
                                                  });
                                                  addUserToProject(project.name, projects_members[projectActualIndex]);
                                                }
                                              },
                                              icon: Icon(Icons.add),
                                            ),
                                          ),
                                        ],
                                      ),
                                    );
                                  },
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                    trailing:
                        project.emailOwner == user_email
                            ? IconButton(
                              onPressed: () async {
                                await removeProject(project.name);
                                final loaded = await loadProjects();
                                setState(() {
                                  projects = loaded;
                                });
                              },
                              icon: Icon(Icons.remove),
                            )
                            : Text(""),
                  ),
                );
              }).toList()
              : [
                Column(
                  children: [
                    SizedBox(height: 400),
                    Center(
                      child: Image.asset(
                        "assets/images/waiting.png",
                        height: 100,
                        width: 90,
                      ),
                    ),
                  ],
                ),
              ]),
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
