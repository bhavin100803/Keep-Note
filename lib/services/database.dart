import 'package:firebase_auth/firebase_auth.dart';
import 'package:keep_note_clone/model/notemodel.dart';
import 'package:keep_note_clone/services/firebase_database.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class NoteDatabase {
  static final NoteDatabase instance = NoteDatabase._init();
  static Database? _database;
  NoteDatabase._init();



  Future<Database?> get database async {
    final FirebaseAuth _auth = FirebaseAuth.instance;
    final User? current_user = _auth.currentUser;
    if (_database != null) return _database;
    _database = await _initializeDB('NewNotes.db');
    return _database;
  }

  Future<Database> _initializeDB(String filepath) async {
    final dbpath = await getDatabasesPath();
    final path = join(dbpath, filepath);

    return await openDatabase(path, version: 1, onCreate: _createDB);
  }

  Future _createDB(Database db, int version) async {
    final idType = 'INTEGER PRIMARY KEY AUTOINCREMENT';
    final boolType = 'BOOLEAN NOT NULL';
    final textType = 'TEXT NOT NULL';
    await db.execute('''
    CREATE TABLE Notes(
    ${notesimpnames.id} $idType,
    ${notesimpnames.uniqueId} $textType,
    ${notesimpnames.pin} $boolType,
    ${notesimpnames.isArchive} $boolType,
    ${notesimpnames.title} $textType,
    ${notesimpnames.content} $textType,
    ${notesimpnames.attachImage} $textType,
    ${notesimpnames.createdTime} $textType
    )
    ''');
  }

  Future<Note?> InsertEntry(Note note) async {

    final db = await instance.database;
   final id =  await db!.insert(notesimpnames.tablename,note.toJson());
    await firedatabase().createNewNoteFirestore(note);
    return note.copy(id:  id);
  }



  Future<List<Note>> readAllNotes() async {
    final db = await instance.database;
    final orderBy = '${notesimpnames.createdTime} ASC';
    final query_result = await db!.query(notesimpnames.tablename, orderBy: orderBy);
     // print(query_result);
     return query_result.map((Json)=>Note.fromJson(Json)).toList();
  }


  Future<List<Note>> readAllArchive() async {
    final db = await instance.database;
    final orderBy = '${notesimpnames.createdTime} ASC';
    final query_result = await db!.query(notesimpnames.tablename, orderBy: orderBy,where:'${notesimpnames.isArchive} = 1' );
    // print(query_result);
    return query_result.map((Json)=>Note.fromJson(Json)).toList();
  }
  Future<List<Note>> pinall() async {
    final db = await instance.database;
    final orderBy = '${notesimpnames.createdTime} ASC';
    final query_result = await db!.query(notesimpnames.tablename, orderBy: orderBy,where:'${notesimpnames.pin} = 1' );
    // print(query_result);
    return query_result.map((Json)=>Note.fromJson(Json)).toList();
  }

  Future<Note?> readOneNote(int id) async {
    final db = await instance.database;
    final map = await db!
        .query(notesimpnames.tablename, columns: notesimpnames.values, where: '${notesimpnames.id} = ?', whereArgs: [id]);
    if(map.isNotEmpty){
      return Note.fromJson(map.first);
    }else{
      return null;
    }
  }

  Future upadatenotes(Note note) async {
    await firedatabase().updateNoteFirestore(note);
    final db = await instance.database;
    return await db!.update(notesimpnames.tablename, note.toJson(),
        where: '${notesimpnames.id} = ?', whereArgs: [note.id]);
  }
  Future pinnote(Note? note) async {
    final db = await instance.database;
    return await db!.update(notesimpnames.tablename, {notesimpnames.pin : !note!.pin ? 1 : 0},
        where: '${notesimpnames.id} = ?', whereArgs: [note.id]);
  }
  Future archivenote(Note? note) async {
    final db = await instance.database;
    return await db!.update(notesimpnames.tablename, {notesimpnames.isArchive : !note!.isArchive  ? 1 : 0},
        where: '${notesimpnames.id} = ?', whereArgs: [note.id]);
  }


  Future deletenote(Note? note) async {
    await firedatabase().deleteNoteFirestore(note!);
    final db = await instance.database;
    await db!.delete(notesimpnames.tablename, where: '${notesimpnames.uniqueId} = ?', whereArgs: [note.uniqueId]);
  }

  Future<List<int>> getNoteString(String query) async {
    final db = await instance.database;
    final result = await db!.query(notesimpnames.tablename);
    List<int> resultIds = [];
    result.forEach((element) {
      if (element["title"].toString().toLowerCase().contains(query) ||
          element["content"].toString().toLowerCase().contains(query)) {
        resultIds.add(element["id"] as int);
      }
    }
    );
    return resultIds;
  }

  Future close() async {
    final db = await instance.database;
    if (db != null) {
      await db.close();
    }
  }
}

