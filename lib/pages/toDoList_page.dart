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
  List<dynamic> toDoList = [];

  Future<void> _submit() async{
    final isValid = _formKey.currentState?.validate();
    if (isValid!){
      Navigator.of(context).pop();
      await updateToDoList(widget.email, title_content);
      _loadToDoList().then((_) => setState(() {
        title_content = "";
      }));
    }
  }

  Future<void> _loadToDoList() async {
    loadToDoList(widget.email).then((loaded){
    setState(() {
      toDoList = loaded;
    });
    });
  }

  Future<void> _updateToDoList(String title) async {
    await updateToDoList(widget.email, title);
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _loadToDoList();
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
        mainAxisAlignment: toDoList.isEmpty? MainAxisAlignment.center: MainAxisAlignment.start,
        children: [
          toDoList.isEmpty 
          ? Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text("Create an event!", style: TextStyle(fontFamily: "Fredoka", fontSize: 20),),
            ],
          )
          :ListView.builder(
            shrinkWrap: true,
            itemCount: toDoList.length,
            itemBuilder: (context, index) {
              return Column(
                children: [
                  Container(
                    margin: EdgeInsets.all(10),
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(children: [Text(toDoList[index])]),
                    ),
                  ),
                  Divider(),
                ],
              );
            },
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(onPressed: (){
        showModalBottomSheet(context: context, builder: (context) {
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
                          decoration: InputDecoration(label: Text("Title", style: TextStyle(fontFamily: "Fredoka"),)),
                          validator: (name){
                            final _name = name ?? '';
                            if (_name.trim().length < 3){
                              return "You need to put more words ; )";
                            }
                            return null;
                          },
                        ),
                      ),
                      ElevatedButton(onPressed: (){_submit();}, child: Text("Save", style: TextStyle(fontFamily: "Fredoka"),))
                    ],
                  )
                )
              ],
            ),
          );
        },);
      }, child: Icon(Icons.add),),
    );
  }
}
