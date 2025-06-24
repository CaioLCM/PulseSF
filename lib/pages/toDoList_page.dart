import 'package:flutter/material.dart';
import 'package:pulsesf/http/communication.dart';

class TodolistPage extends StatefulWidget {
  final String email;
  const TodolistPage({super.key, required this.email});

  @override
  State<TodolistPage> createState() => _TodolistPageState();
}

class _TodolistPageState extends State<TodolistPage> {
  final _formKey = GlobalKey<FormState>();
  String title_content = "";
  List<Map<String, dynamic>> toDoList = [];
  Map<int, String?> selectedTags = {};

  List<Map<String, String>> tags = [];

  Future<void> _submit() async {
    final isValid = _formKey.currentState?.validate();
    if (isValid!) {
      Navigator.of(context).pop();
      await updateToDoList(widget.email, title_content);
      _loadToDoList().then(
        (_) => setState(() {
          title_content = "";
        }),
      );
    }
  }

  Future<void> _loadToDoList() async {
    loadToDoList(widget.email).then((loaded) {
      setState(() {
        toDoList = loaded;
        
        selectedTags.clear();

        for (int i = 0; i < toDoList.length; i ++){
          final tag = toDoList[i]["tag"];

          if (tag != null && tag.isNotEmpty){
            final tagName = tag[0]["tagname"];
            final color = tag[0]["color"];

            final foundIndex = tags.indexWhere((element) => element["name"] == tagName && element["color"] == color);
          
            if (foundIndex != -1){
              selectedTags[i] = "Tag$foundIndex";
            } else {
              selectedTags[i] = null;
            }
          
          }
        }

      });
    });
  }

  Future<void> _updateToDoList(String title) async {
    await updateToDoList(widget.email, title);
  }

  Future<void> _removeToDoItem(String title) async {
    await removeToDoItem(widget.email, title);
    await _loadToDoList();
  }

  Future<void> _addTagToToDoEvent(String title, String tagName, String color) async {
    addTagToToDoEvent(widget.email, title, tagName, color).then((_) => _loadToDoList());
  }

  void _showDeleteConfirmationDialog(BuildContext context, String title) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text(
            "Confirm delete",
            style: TextStyle(fontFamily: "Fredoka"),
          ),
          content: Text(
            "Are you sure about that?",
            style: TextStyle(fontFamily: "Fredoka"),
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text("Cancel", style: TextStyle(fontFamily: "Fredoka")),
            ),
            TextButton(
              onPressed: () async {
                Navigator.of(context).pop();
                await _removeToDoItem(title);
              },
              child: Text("Delete", style: TextStyle(fontFamily: "Fredoka")),
            ),
          ],
        );
      },
    );
  }

  String colorToHex(Color color) {
    return color.value
        .toRadixString(16)
        .padLeft(8, '0')
        .toUpperCase(); // Ex: FF2196F3
  }

  Color hexToColor(String hex) {
    return Color(int.parse(hex, radix: 16));
  }

  Future<void> _loadTags() async{
    await loadTags(widget.email).then((loaded) {
      setState(() {
        tags = loaded.map<Map<String, String>>((e) => {
          "name": e["tagname"] as String,
          "color": e["color"] as String
        }).toList();
      });
    });
  }

  

  Future<void> _createNewTag(BuildContext context) async{
    TextEditingController tagNameController = TextEditingController();
    Color? selectedColor;

    final List<Color> colors = [
      Colors.red,
      Colors.green,
      Colors.blue,
      Colors.yellow,
      Colors.purple,
      Colors.black
    ];

    showModalBottomSheet(
      context: context,
      builder: (context) {
        return StatefulBuilder(
          builder:
              (context, setState) => Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: TextField(
                      controller: tagNameController,
                      decoration: InputDecoration(
                        label: Text(
                          "Tag name",
                          style: TextStyle(fontFamily: "Fredoka"),
                        ),
                      ),
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: DropdownButton<Color>(
                          hint: Text("Color"),
                          value: selectedColor,
                          items:
                              colors.map((Color color) {
                                return DropdownMenuItem<Color>(
                                  value: color,
                                  child: Row(
                                    children: [
                                      Container(
                                        width: 24,
                                        height: 24,
                                        decoration: BoxDecoration(
                                          color: color,
                                          shape: BoxShape.circle,
                                          border: Border.all(
                                            color: Colors.black26,
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                );
                              }).toList(), // Convert Iterable to List
                          onChanged: (Color? newColor) {
                            setState(() {
                              selectedColor = newColor;
                            });
                          },
                        ),
                      ),
                      SizedBox(width: 80),
                      ElevatedButton(
                        onPressed: () {
                          Navigator.of(context).pop({
                            "name": tagNameController.text,
                            "color": colorToHex(selectedColor!)
                          });
                        },
                        child: Text(
                          "Create",
                          style: TextStyle(fontFamily: "Fredoka"),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
        );
      },
    ).then((_value) async {
      await createTag(widget.email, _value["name"], _value["color"]);
      await _loadTags();
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _loadTagsAndToDos();
  }

  Future<void> _loadTagsAndToDos() async{
    await _loadTags();
    await _loadToDoList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "To-do list",
          style: TextStyle(fontFamily: "Fredoka", color: Colors.white),
        ),
        backgroundColor: Colors.purple,
      ),
      body: Column(
        mainAxisAlignment:
            toDoList.isEmpty
                ? MainAxisAlignment.center
                : MainAxisAlignment.start,
        children: [
          toDoList.isEmpty
              ? Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "Create an event!",
                    style: TextStyle(fontFamily: "Fredoka", fontSize: 20),
                  ),
                ],
              )
              : SizedBox(
                height: 834,
                child: ListView.builder(
                  shrinkWrap: true,
                  itemCount: toDoList.length,
                  itemBuilder: (context, index) {
                    return Column(
                      children: [
                        SizedBox(height: 7),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            SizedBox(width: 15),
                            Expanded(
                              child: Text(
                                "deadline",
                                style: TextStyle(fontFamily: "Fredoka"),
                              ),
                            ),
                            DropdownButton( ////////////////////////////////////////////////////////////////
                              hint: Text("Tag"),
                              value: selectedTags[index],
                              items: [
                                DropdownMenuItem<String>(
                                  value: "None",
                                  child: Text(
                                    "None",
                                    style: TextStyle(fontFamily: "Fredoka"),
                                  ),
                                ),
                                ...tags.asMap().entries.map((entry) {
                                  int index = entry.key;
                                  Map<String, String> tag = entry.value;
                                  return DropdownMenuItem<String>(
                                    value: "Tag$index",
                                    child: Text(
                                      tag["name"] ?? "",
                                      style: TextStyle(fontFamily: "Fredoka", color: hexToColor(tag["color"]!)),
                                    ),
                                  );
                                }),
                                DropdownMenuItem<String>(
                                  value: "Create",
                                  child: Row(
                                    children: [
                                      Icon(Icons.add),
                                      Text(
                                        "Create",
                                        style: TextStyle(fontFamily: "Fredoka"),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                              onChanged: (String? newValue) {
                                if (newValue == "Create") {
                                  _createNewTag(context).then((_){
                                    setState(() {
                                    selectedTags[index] = null;
                                    });  
                                  });
                                } else {
                                  setState(() {
                                    selectedTags[index] = newValue == "None"? null : newValue;
                                    if (newValue != "None"){
                                      final tagIndex = int.parse(newValue!.replaceAll("Tag", ""));
                                      final tag = tags[tagIndex];

                                      final tagName = tag["name"]!;
                                      final color = tag["color"]!;
                                      addTagToToDoEvent(widget.email, toDoList[index]["title"], tagName, color);             
                                    }
                                  });
                                }
                                print(selectedTags);
                              },
                            ),
                            SizedBox(width: 15),
                          ],
                        ),
                        Container(
                          margin: EdgeInsets.all(10),
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Row(
                              children: [
                                Checkbox(
                                  value: toDoList[index]["checked"] as bool,
                                  onChanged: (bool? value) {
                                    setState(() {
                                      toDoList[index]["checked"] =
                                          !(toDoList[index]["checked"] as bool);
                                      updateCheckState(
                                        widget.email,
                                        toDoList[index]["title"],
                                      );
                                    });
                                  },
                                ),
                                Expanded(
                                  child: Text(
                                    toDoList[index]["title"],
                                    style: TextStyle(
                                      fontFamily: "Fredoka",
                                      fontStyle:
                                          toDoList[index]["checked"]
                                              ? FontStyle.italic
                                              : FontStyle.normal,
                                      decoration:
                                          toDoList[index]["checked"]
                                              ? TextDecoration.lineThrough
                                              : TextDecoration.none,
                                    ),
                                  ),
                                ),
                                IconButton(
                                  onPressed: () {
                                    _showDeleteConfirmationDialog(
                                      context,
                                      toDoList[index]["title"],
                                    );
                                  },
                                  icon: Icon(Icons.delete, color: Colors.red),
                                ),
                              ],
                            ),
                          ),
                        ),
                        Divider(),
                      ],
                    );
                  },
                ),
              ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          showModalBottomSheet(
            context: context,
            builder: (context) {
              return Scaffold(
                body: Column(
                  children: [
                    Form(
                      key: _formKey,
                      child: Column(
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(13.0),
                            child: TextFormField(
                              style: TextStyle(fontFamily: "Fredoka"),
                              key: ValueKey("name"),
                              initialValue: title_content,
                              onChanged: (name) => title_content = name,
                              decoration: InputDecoration(
                                label: Text(
                                  "Title",
                                  style: TextStyle(fontFamily: "Fredoka"),
                                ),
                              ),
                              validator: (name) {
                                final _name = name ?? '';
                                if (_name.trim().length < 3) {
                                  return "You need to put more words ; )";
                                }
                                return null;
                              },
                            ),
                          ),
                          ElevatedButton(
                            onPressed: () {
                              _submit();
                            },
                            child: Text(
                              "Save",
                              style: TextStyle(fontFamily: "Fredoka"),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              );
            },
          );
        },
        child: Icon(Icons.add),
      ),
    );
  }
}
