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
      appBar: AppBar(
        title: Text(
          "Notes",
          style: TextStyle(fontSize: 30, color: appTitle),
        ),
        centerTitle: true,
        backgroundColor: appBarColor,
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.pushReplacement(
              context, MaterialPageRoute(builder: (context) => NotesCreate()));
        },
        child: Icon(
          Icons.add,
          size: 30,
          color: appWhite,
        ),
        backgroundColor: appAddButton,
        elevation: 15,
      ),
      backgroundColor: appBackGround,
      body: FutureBuilder<List<NotesModel>>(
        future: notesList,
        builder: (context, snapshot) {
          if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return Center(
              child: Text(
                'No notes available.',
                style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: appAddButton),
              ),
            );
          } else {
            return GridView.builder(
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                crossAxisSpacing: 8.0,
                mainAxisSpacing: 8.0,
              ),
              itemCount: snapshot.data!.length,
              itemBuilder: (context, index) {
                var note = snapshot.data![index];
                return InkWell(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => UpdateScreen(note: note),
                      ),
                    );
                  },

                  // Dismissible is used for deleting the notes
                  child: Dismissible(
                    direction: DismissDirection.endToStart,
                    key: ValueKey<int>(note.id!),
                    background: Container(
                      color: Colors.red.shade300,
                      child: Icon(
                        Icons.delete,
                        size: 50,
                      ),
                    ),
                    onDismissed: (DismissDirection direction) {
                      setState(() {
                        dataBaseHandler!.delete(note.id!);
                        notesList = dataBaseHandler!.getNotesList();
                        snapshot.data!.remove(note);
                      });
                    },

                    // Card view
                    child: Card(
                      color: Colors.white,
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              note.title,
                              style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                              ),
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                            ),
                            SizedBox(height: 8),

                            // Message
                            Text(
                              note.message,
                              style: TextStyle(fontSize: 16),
                              maxLines: 5, // Limit the number of lines for the message
                              overflow: TextOverflow.ellipsis,
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
