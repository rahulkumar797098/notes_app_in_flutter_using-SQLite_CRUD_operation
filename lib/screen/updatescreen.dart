import 'package:flutter/material.dart';
import 'package:notes_new/database/NotesModel.dart';
import 'package:notes_new/database/databasehandler.dart';
import 'package:notes_new/screen/home_screen.dart';

import '../colors.dart';

class UpdateScreen extends StatefulWidget {
  final NotesModel note;

  UpdateScreen({required this.note});

  @override
  State<StatefulWidget> createState() => _UpdateScreenState();
}

class _UpdateScreenState extends State<UpdateScreen> {
  var titleController = TextEditingController();
  var messageController = TextEditingController();

  DataBaseHandler? dataBaseHandler;

  @override
  void initState() {
    super.initState();
    dataBaseHandler = DataBaseHandler();
    titleController.text = widget.note.title;
    messageController.text = widget.note.message;
  }

  Future<void> updateNote() async {
    var updatedNote = NotesModel(
      id: widget.note.id,
      title: titleController.text,
      message: messageController.text,
    );
    await dataBaseHandler!.update(updatedNote);
    Navigator.pushReplacement(
        context, MaterialPageRoute(builder: (context) => HomeScreen()));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "Notes | Read | Update",
                style: TextStyle(fontSize: 25, color: appTitle),
              ),
              IconButton(
                onPressed: () async {
                  await updateNote();
                },
                icon: Icon(
                  Icons.check_circle_outline_rounded,
                  size: 40,
                ),
                splashColor: Colors.orange,
              )
            ],
          ),
          backgroundColor: appBarColor),
      backgroundColor: appBackGround,
      body: Column(
        children: [
          //////////////////////////////////////////////// Title Box  //////////////////
          Padding(
            padding: const EdgeInsets.only(top: 10, left: 8, right: 10),
            child: TextField(
              controller: titleController,
              minLines: 1,
              maxLines: 2,
              cursorColor: appTitle,
              autofocus: true,
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              decoration: InputDecoration(
                  hintText: "Write Title", border: InputBorder.none),
            ),
          ),

          /////////////////////////////  Message Box ////////////////
          Padding(
            padding: const EdgeInsets.only(left: 8, right: 10),
            child: TextField(
              controller: messageController,
              minLines: 1,
              maxLines: 10,
              cursorColor: appTitle,
              style: TextStyle(fontSize: 20),
              decoration: InputDecoration(
                  border: InputBorder.none, hintText: "Write Notes"),
            ),
          ),
        ],
      ),
    );
  }
}
