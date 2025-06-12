import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:pulsesf/http/communication.dart';

class Createevent extends StatefulWidget {
  final email;
  const Createevent({required this.email});

  @override
  State<Createevent> createState() => _CreateeventState();
}


class _CreateeventState extends State<Createevent> {
  TextEditingController titleController = new TextEditingController();
  TextEditingController descriptionController = new TextEditingController();  
  String? date = null;
  _showDatePicker(BuildContext context) async {
  final pickedDate = await showDatePicker(
    context: context,
    firstDate: DateTime.now(),
    lastDate: DateTime(2025, 8, 30),
  );
  setState(() {
    if (pickedDate != null) {
      date = DateFormat('yyyy-MM-dd').format(pickedDate).toString();
    }
  });
}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Text("Create a new event", style: TextStyle(fontFamily: "Fredoka"),),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              controller: titleController,
              decoration: InputDecoration(
                label: Text("Event title", style: TextStyle(fontFamily: "Fredoka")),
              ),
              style: TextStyle(fontFamily: "Fredoka"),
            ),
          ),
          SizedBox(height: 15,),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              maxLines: 10,
              minLines: 1,
              controller: descriptionController,
              decoration: InputDecoration(label: Text("Event description", style: TextStyle(fontFamily: "Fredoka"),)),
              style: TextStyle(fontFamily: "Fredoka"),
            ),
          ),
          SizedBox(height: 10,),
          ElevatedButton(
            onPressed: () {
              _showDatePicker(context);
            },
            child: Text(date?? "Select date", style: TextStyle(fontFamily: "Fredoka"),),
          ),
          SizedBox(height: 30,),
          ElevatedButton(onPressed: (){
            if (date != null && titleController.text != "" && descriptionController.text != "") {
              addEvent(widget.email, titleController.text, descriptionController.text, date!);
              Navigator.of(context).pop();
            } else {
              if(date == null && titleController.text != "" && descriptionController.text != ""){
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text("Please select a date.", style: TextStyle(fontFamily: "Fredoka"))),
              );
              }
              else if (titleController.text == "" && date != null && descriptionController.text != ""){
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text("Select a valid title"))
                );
              }
              else if (descriptionController.text == "" && titleController.text != "" && date != null){
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text("Select a valid description"))
                );
              }
              else if (descriptionController.text == "" && titleController.text == "" && date != null){
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text("Select a valid title and description"))
                );
              }
              else if (descriptionController.text == "" && date == null && titleController.text != ""){
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text("Select a valid description and date"))
                );
              }
              else if (titleController.text == "" && date == null && descriptionController.text != ""){
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text("Select a valid title and date"))
                );
              }
              else {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text("Select a valid title, date and description"))
                );
              }
            }
            }, child: Text("Save", style: TextStyle(fontFamily: "Fredoka"),))
        ],
      ),
    );
  }
}
