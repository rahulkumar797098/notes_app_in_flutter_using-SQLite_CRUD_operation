
import 'package:sqflite/sqflite.dart';
import 'NotesModel.dart';
import 'dart:async';
import 'package:path/path.dart';

class DataBaseHandler {
  static final DataBaseHandler _instance = DataBaseHandler.internal();
  factory DataBaseHandler() => _instance;

  static Database? _db;

  DataBaseHandler.internal();

  Future<Database> get db async {
    if (_db != null) {
      return _db!;
    }
    _db = await initDb();
    return _db!;
  }

  initDb() async {
    String databasesPath = await getDatabasesPath();
    String path = join(databasesPath, 'notes.db');

    var db = await openDatabase(path, version: 1, onCreate: _onCreate);
    return db;
  }

  void _onCreate(Database db, int newVersion) async {
    await db.execute(
        'CREATE TABLE Notes(id INTEGER PRIMARY KEY, title TEXT, message TEXT)');
  }

  // Insert a note into the database
  Future<int> insert(NotesModel note) async {
    var dbClient = await db;
    var result = await dbClient.insert('notes', note.toMap());
    return result;
  }

  // Get all notes from the database
  Future<List<NotesModel>> getNotesList() async {
    var dbClient = await db;
    final List<Map<String, Object?>> queryResult = await dbClient.query('notes',);
    return queryResult.map((e) => NotesModel.fromMap(e)).toList();
  }

  /////////// Delete ///
Future<int> delete(int id) async{
var dbClient = await db ;
return await dbClient.delete("notes" , where:"id = ?" , whereArgs: [id]);
}

////////// Update ///////////////////////
Future<int> update(NotesModel notesModel) async {
    var dbClient = await db ;
    return await dbClient!.update("notes", notesModel.toMap() ,
    where: "id = ?" ,
      whereArgs:[notesModel.id]
    ) ;
}





}
