import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
// import 'package:flutter/material.dart' hide CarouselController;
import 'package:keep_note_clone/model/notemodel.dart';
import 'package:keep_note_clone/services/database.dart';
import 'package:keep_note_clone/services/login_info.dart';

class firedatabase {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  createNewNoteFirestore(Note note,) async {
    LocalDataSaver.getSync().then((isSyncon)async{
      if(isSyncon.toString() == "true"){
        final User? current_user = _auth.currentUser;
        await FirebaseFirestore.instance
            .collection("notes")
            .doc(current_user!.email)
            .collection("usernotes")
            .doc(note.uniqueId)
            .set({
          "Title": note.title,
          "content": note.content,
          "uniqueId": note.uniqueId,
          "date": note.createdTime,
          "attachImage":note.attachImage,
        }).then((_) {
          print("DATA ADDED SUCCESSFULLY");
        });
      }
    });

  }

  getAllStoredNotes() async {
    LocalDataSaver.getSync().then((isSyncon)async{
      if(isSyncon.toString() == "true")  {
        final User? current_user = _auth.currentUser;
        await FirebaseFirestore.instance
            .collection("notes")
            .doc(current_user!.email)
            .collection("usernotes")
            .orderBy("date")
            .get()
            .then((querySnapshot) {
          querySnapshot.docs.forEach((result) {
            Map note = result.data();

            NoteDatabase.instance.InsertEntry(Note(
                title: note["Title"],
                uniqueId: note["uniqueId"],
                content: note["content"],
                createdTime: note["date"],
                attachImage: note["attachImage"],
                pin: false,
                isArchive: false)); //Add Notes In Database
          });
        });
      }
    });

  }

  updateNoteFirestore(Note note) async {
    LocalDataSaver.getSync().then((isSyncon)async{
      if(isSyncon.toString() == "true")  {
        final User? current_user = _auth.currentUser;
        await FirebaseFirestore.instance
            .collection("notes")
            .doc(current_user!.email)
            .collection("usernotes")
            .doc(note.uniqueId.toString())
            .update({"Title": note.title.toString(), "content": note.content}).then(
                (_) {
              print("DATA ADDED SUCCESFULLY");
            });
      }
    });

  }

  deleteNoteFirestore(Note note) async {
    LocalDataSaver.getSync().then((isSyncon)async{
      print(isSyncon);
      if(isSyncon.toString() == "true")  {
        final User? current_user = _auth.currentUser;
        await FirebaseFirestore.instance
            .collection("notes")
            .doc(current_user!.email.toString())
            .collection("usernotes")
            .doc(note.uniqueId.toString())
            .delete()
            .then((_) {
          print("DATA DELETED SUCCESS FULLY");
        });
      }
    });

  }
}
