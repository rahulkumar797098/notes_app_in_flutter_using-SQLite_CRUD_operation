import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:notes_new/database/NotesModel.dart';
import 'package:notes_new/database/databasehandler.dart';
import 'package:notes_new/screen/home_screen.dart';

import '../colors.dart';

class NotesCreate extends StatefulWidget{
  @override
  State<StatefulWidget> createState() => _NotesCreate();

}
class _NotesCreate extends State<NotesCreate>{

  var titleController = TextEditingController() ;
  var messageController = TextEditingController() ;

  DataBaseHandler? dataBaseHandler ;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    dataBaseHandler = DataBaseHandler();
  }

  @override
  Widget build(BuildContext context) {
   return Scaffold( appBar: AppBar(
     title: Row(
       mainAxisAlignment: MainAxisAlignment.spaceBetween,
       children: [
         Text(
         " Write Notes",
         style: TextStyle(fontSize: 30, color: appTitle),
            ),
         IconButton(onPressed: () async {
           dataBaseHandler!.insert(NotesModel(title: titleController.text.toString(), message: messageController.text.toString()));
           Navigator.push(context, MaterialPageRoute(builder: (context) => HomeScreen()));

         }, icon: Icon(Icons.check_circle_outline_rounded , size: 40 ,) ,splashColor: Colors.orange,
         )
       ],
     ) ,
         backgroundColor: appBarColor
   ) ,
       backgroundColor: appBackGround,
     body: Column(
       children: [

         //////////////////////////////////////////////// Title Box  //////////////////
         Padding(
           padding: const EdgeInsets.only(top: 10 , left: 8 , right: 10),
           child: TextField(
             controller: titleController,
             minLines: 1,
             maxLines: 2,
             cursorColor:appTitle,
             autofocus: true,
             style: TextStyle(fontSize: 20 , fontWeight: FontWeight.bold ),
             decoration: InputDecoration(
               hintText: "Write Title" ,
               border: InputBorder.none

             ),
           ),
         ) ,


         /////////////////////////////  Message Box ////////////////
         Padding(
           padding: const EdgeInsets.only(left: 8 , right: 10),
           child: TextField(
             controller: messageController,
             minLines: 1,
             maxLines: 10,
             cursorColor: appTitle,
             style: TextStyle(fontSize: 20),
             decoration: InputDecoration(
               border: InputBorder.none,
               hintText: "Write Notes"
             ),
           ),
         ) ,
       ],
     ),
    );
  }

}