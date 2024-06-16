import 'package:flutter/material.dart';
import 'package:notes_new/database/NotesModel.dart';
import 'package:notes_new/database/databasehandler.dart';
import 'package:notes_new/screen/updatescreen.dart';

import '../colors.dart';
import 'createnotesscreen.dart';

class HomeScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  DataBaseHandler? dataBaseHandler;
  late Future<List<NotesModel>> notesList;

  @override
  void initState() {
    super.initState();
    dataBaseHandler = DataBaseHandler();
    notesList = Future.value([]);
    loadData();
  }

  ///////// Load Data
  Future<void> loadData() async {
    notesList = dataBaseHandler!.getNotesList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      ////////////////////// Title //////////////////////
      appBar: AppBar(
        title: Text(
          "Notes",
          style: TextStyle(fontSize: 30, color: appTitle),
        ),
        centerTitle: true,
        backgroundColor: appBarColor,
      ),

      ////////// Floating action Button ////// Notes Add Button ////////////
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.pushReplacement(
              context, MaterialPageRoute(builder: (context) => NotesCreate()));
        },
        backgroundColor: appAddButton,
        elevation: 15,
        child: const Icon(
          Icons.add,
          size: 30,
          color: appWhite,
        ),
      ),
      backgroundColor: appBackGround,

      ///////////////// Body ////////////////////////
      body: FutureBuilder<List<NotesModel>>(
        future: notesList,
        builder: (context, snapshot) {
          /// if data id not  then show //////////
          if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return const Center(
              child: Text(
                'No notes available.',
                style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: appAddButton),
              ),
            );
          } else {
            // if data is available
            return GridView.builder(
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                crossAxisSpacing: 8.0,
                mainAxisSpacing: 8.0,
              ),
              itemCount: snapshot.data!.length,
              itemBuilder: (context, index) {
                var noteIndex = snapshot.data![index];   // this is id index

                ////// here Inkwell is use for single Click on item then show update screen
                return InkWell(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => UpdateScreen(note: noteIndex),
                      ),
                    );
                  },

                  // Dismissible is used for deleting the notes
                  child: Dismissible(
                    direction: DismissDirection.endToStart,
                    key: ValueKey<int>(noteIndex.id!),
                    background: Container(
                      color: Colors.red.shade300,
                      child: const Icon(
                        Icons.delete,
                        size: 50,
                      ),
                    ),
                    onDismissed: (DismissDirection direction) {
                      setState(() {
                        dataBaseHandler!.delete(noteIndex.id!);
                        notesList = dataBaseHandler!.getNotesList();
                        snapshot.data!.remove(noteIndex);
                      });
                    },

                    // Card view   //////// Data Show in this Part ////////
                    child: Card(
                      color: Colors.white,
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [

                            /// title Show
                            Text(
                              noteIndex.title,
                              style: const TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                              ),
                              maxLines: 1,

                            ),
                            SizedBox(height: 8),

                            // Message Show
                            Text(
                              noteIndex.message,
                              style: TextStyle(fontSize: 16),
                              maxLines: 5, // Limit the number of lines for the message

                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                );
              },
            );
          }
        },
      ),
    );
  }
}
