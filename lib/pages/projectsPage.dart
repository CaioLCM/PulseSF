import 'dart:convert';
import 'dart:math'; 

import 'package:flutter/material.dart';
import 'package:jwt_decoder/jwt_decoder.dart';
import 'package:pulsesf/http/communication.dart'; 
import 'package:pulsesf/pages/createProjectMenu.dart';
import 'package:pulsesf/pages/displayProfiles.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Projectspage extends StatefulWidget {
  const Projectspage({super.key});

  @override
  State<Projectspage> createState() => _ProjectspageState();
}

class _ProjectspageState extends State<Projectspage> {
  String user_email = '';
  List<project> projects = [];
  List<List<String>> projects_members_ui_state = [];
  bool _isLoadingProjects = true;

  @override
  void initState() {
    super.initState();
    _initializePageData();
  }

  Future<void> _initializePageData() async {
    if (mounted) {
      setState(() {
        _isLoadingProjects = true;
      });
    }
    await _loadUserEmail();
    await _fetchProjectsAndUpdateState();
  }

  Future<List<project>> _internalLoadProjects() async {
    try {
      List<project>? result = await getProjects(); 
      return result ?? <project>[]; 
    } catch (e) {
      print("Erro em _internalLoadProjects: $e");
      return <project>[]; 
    }
  }

  Future<void> _fetchProjectsAndUpdateState() async {
    if (!_isLoadingProjects && mounted) {
       setState(() { _isLoadingProjects = true; });
    }

    List<project> loadedProjectsList = await _internalLoadProjects(); 

    if (mounted) {
      setState(() {
        projects = loadedProjectsList;
        
        projects_members_ui_state = projects.map((p) {
          List<dynamic>? rawMemberList = p.member_list; 
          if (rawMemberList != null) {
            return List<String>.from(rawMemberList.map((item) => item.toString()));
          }
          return <String>[];
        }).toList();
        
        _isLoadingProjects = false;
      });
    }
  }

  Future<void> _loadUserEmail() async {
    final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString("jwt_token");
    if (token == null || token.isEmpty) {
      print("Projectspage: Token JWT não encontrado.");
      if (mounted) setState(() => _isLoadingProjects = false);
      return;
    }
    try {
      final decoded = JwtDecoder.decode(token);
      final String? emailFromToken = decoded['user']?['email'] as String?;
      if (mounted) {
        setState(() {
          user_email = emailFromToken ?? '';
          if (user_email.isEmpty) print("Projectspage: Email não encontrado no token.");
        });
      }
    } catch (e) {
      print("Projectspage: Erro ao decodificar token JWT: $e");
      if (mounted) setState(() => _isLoadingProjects = false);
    }
  }

  Future<ImageProvider<Object>?> _loadProfileImage(String email) async {
    if (email.isEmpty) return null;
    try {
      final String? imageString = await searchForProfilePicture(email);
      if (imageString != null && imageString.isNotEmpty) {
        if (imageString.length % 4 == 0 && RegExp(r'^[a-zA-Z0-9+/]*={0,2}$').hasMatch(imageString)) {
          return MemoryImage(base64Decode(imageString));
        } else {
           print("Projectspage: String de imagem para $email não parece ser Base64: $imageString");
           return null;
        }
      }
    } catch (e) {
      print("Projectspage: Erro ao carregar/decodificar imagem para $email: $e");
    }
    return null;
  }

  void _openProjectCreationModal(BuildContext context) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      builder: (_) => Createprojectmenu(),
    ).then((_) {
      _fetchProjectsAndUpdateState();
    });
  }

  void _handleJoinProject(project targetProject, int projectIndex) {
    if (projectIndex < 0 || projectIndex >= projects_members_ui_state.length) {
      print("Projectspage: Índice de projeto inválido _handleJoinProject: $projectIndex");
      return;
    }

    List<String> currentLocalMembersCopy = List.from(projects_members_ui_state[projectIndex]);
    
    bool isOwner = user_email == targetProject.emailOwner;
    bool alreadyMember = currentLocalMembersCopy.contains(user_email);
    bool hasSlots = currentLocalMembersCopy.length < targetProject.members.toInt();

    if (user_email.isEmpty) {
       ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Usuário não identificado.")));
       return;
    }

    if (!isOwner && !alreadyMember && hasSlots) {
      currentLocalMembersCopy.add(user_email);

      setState(() {
        projects_members_ui_state[projectIndex] = currentLocalMembersCopy;
      });

      addUserToProject(targetProject.name, currentLocalMembersCopy); 
    } else {
      String message = "Not possible to join the project";
      if (isOwner) message = "You are the owner";
      else if (alreadyMember) message = "Already member";
      else if (!hasSlots) message = "Project full";
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(message)));
    }
  }

  void _handleRemoveProject(String projectName) async {
    final bool? confirmDelete = await showDialog<bool>(
      context: context,
      builder: (BuildContext ctx) => AlertDialog(
        title: Text('Confirm'),
        content: Text('Are you sure about deleting "$projectName"?'),
        actions: [
          TextButton(onPressed: () => Navigator.of(ctx).pop(false), child: Text('Cancel')),
          TextButton(
              onPressed: () => Navigator.of(ctx).pop(true),
              child: Text('Exclude', style: TextStyle(color: Colors.red))),
        ],),
    );
    if (confirmDelete == true) {
      await removeProject(projectName);
      _fetchProjectsAndUpdateState();
    }
  }

  Future<String> getProfilePictureString(String email)async{
    final profile_string = await searchForProfilePicture(email);
    return profile_string;
  }

  Widget _buildMemberAvatar(String email) {
    return GestureDetector(
      onTap: () async {
        String profilePicture = await getProfilePictureString(email);
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (builder) => Displayprofiles(email: email, profile_picture: profilePicture),
          ),
        );
      },
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 2.0),
        child: FutureBuilder<ImageProvider<Object>?>(
          key: ValueKey(email),
          future: _loadProfileImage(email),
          builder: (context, snapshot) {
            Widget placeholder = CircleAvatar(
              radius: 20,
              backgroundColor: Colors.grey[350], 
              child: Text(email.isNotEmpty ? email[0].toUpperCase() : "?", style: TextStyle(fontSize: 12, color: Colors.black87)),
            );
            if (snapshot.connectionState == ConnectionState.waiting) {
              return CircleAvatar(radius: 20, child: SizedBox(width: 15, height: 15, child: CircularProgressIndicator(strokeWidth: 1.5)));
            } else if (snapshot.hasError || !snapshot.hasData || snapshot.data == null) {
              return placeholder;
            } else {
              return CircleAvatar(radius: 20, backgroundImage: snapshot.data);
            }
          },
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
           Container(
            color: Colors.purple,
            width: double.infinity,
            height: 90,
            child: Row(
              children: [
                IconButton(onPressed: () => Navigator.pop(context), icon: Icon(Icons.exit_to_app), iconSize: 40, color: Colors.red,),
                SizedBox(width: 60,),
                Text("Projects", style: TextStyle(
                  fontFamily: "Fredoka",
                  fontSize: 17,
                  fontWeight: FontWeight.bold
                ),)
              ],
            ),
          ),
          Expanded(
            child: _isLoadingProjects
                ? const Center(child: CircularProgressIndicator())
                : projects.isEmpty
                    ? Center(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Image.asset("assets/images/waiting.png", height: 100, width: 90),
                            const SizedBox(height: 10),
                            const Text("Nothing to show", style: TextStyle(fontSize: 16)),
                          ],
                        ),
                      )
                    : ListView.builder(
                        itemCount: projects.length,
                        itemBuilder: (context, projectIndex) {
                          final project currentProject = projects[projectIndex];
                          final List<String> currentProjectSpecificMembers =
                              (projectIndex < projects_members_ui_state.length)
                                  ? projects_members_ui_state[projectIndex]
                                  : <String>[];

                          bool canUserJoin = user_email.isNotEmpty &&
                              currentProjectSpecificMembers.length < currentProject.members.toInt() &&
                              user_email != currentProject.emailOwner &&
                              !currentProjectSpecificMembers.contains(user_email);

                          return Card(
                            elevation: 3,
                            margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 7),
                            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                            child: Padding(
                              padding: const EdgeInsets.all(12.0),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Expanded(
                                        child: Text(
                                          currentProject.name,
                                          style: Theme.of(context).textTheme.titleLarge?.copyWith(fontWeight: FontWeight.bold),
                                          overflow: TextOverflow.ellipsis,
                                        ),
                                      ),
                                      if (currentProject.emailOwner == user_email)
                                        IconButton(
                                          iconSize: 24,
                                          padding: EdgeInsets.zero,
                                          constraints: const BoxConstraints(),
                                          visualDensity: VisualDensity.compact,
                                          onPressed: () => _handleRemoveProject(currentProject.name),
                                          icon: Icon(Icons.delete_outline, color: Colors.red[600]),
                                        ),
                                    ],
                                  ),
                                  const SizedBox(height: 6),
                                  Text(currentProject.bio, style: Theme.of(context).textTheme.bodyMedium),
                                  const SizedBox(height: 12),
                                  Container(
                                    height: 40,
                                    child: Row(
                                      children: [
                                        _buildMemberAvatar(currentProject.emailOwner),
                                        const SizedBox(width: 4),
                                        Expanded(
                                          child: ListView.builder(
                                            scrollDirection: Axis.horizontal,
                                            itemCount: currentProjectSpecificMembers.length,
                                            itemBuilder: (context, memberIdx) {
                                              final String memberEmail = currentProjectSpecificMembers[memberIdx];
                                              if (memberEmail == currentProject.emailOwner) {
                                                return const SizedBox.shrink();
                                              }
                                              return _buildMemberAvatar(memberEmail);
                                            },
                                          ),
                                        ),
                                        if (canUserJoin)
                                          Padding(
                                            padding: const EdgeInsets.only(left: 4.0),
                                            child: CircleAvatar(
                                              radius: 20,
                                              backgroundColor: Theme.of(context).colorScheme.secondaryContainer,
                                              child: IconButton(
                                                iconSize: 20,
                                                padding: EdgeInsets.zero,
                                                icon: Icon(Icons.add, color: Theme.of(context).colorScheme.onSecondaryContainer),
                                                onPressed: () {
                                                  _handleJoinProject(currentProject, projectIndex);
                                                },
                                              ),
                                            ),
                                          ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          );
                        },
                      ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          _openProjectCreationModal(context);
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}