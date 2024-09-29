import 'package:flutter/material.dart';
import 'package:keep_note_clone/color.dart';
import 'package:keep_note_clone/model/notemodel.dart';
import 'package:keep_note_clone/services/database.dart';

import 'home_page.dart';

class Editnote extends StatefulWidget {
  Note note;
  Editnote({super.key, required this.note});

  @override
  State<Editnote> createState() => _EditnoteState();
}

class _EditnoteState extends State<Editnote> {
  late String NewTitle;
  late String NewNoteDetail;

  @override
  void initState() {
    super.initState();
    this.NewTitle = widget.note.title.toString();
    this.NewNoteDetail = widget.note.content.toString();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // backgroundColor: color.bgcolor,
      appBar: AppBar(
        // foregroundColor: color.white,
        // backgroundColor: color.bgcolor,
        elevation: 0.0,
        actions: [
          IconButton(
              splashRadius: 17,
              onPressed: () async {
                Note newNote = Note(
                    content: NewNoteDetail,
                    title: NewTitle,
                     isArchive: widget.note.isArchive,
                    createdTime: widget.note.createdTime,
                    uniqueId: widget.note.uniqueId,
                    pin: widget.note.pin,
                    attachImage: widget.note.attachImage,
                    id: widget.note.id);
                await NoteDatabase.instance.upadatenotes(newNote);
                Navigator.pushReplacement(context, MaterialPageRoute(builder: (_)=>HomePage()));
              },
              icon: Icon(Icons.save_outlined))
        ],
      ),
      body: Container(
        padding: EdgeInsets.symmetric(horizontal: 15, vertical: 10),
        child: Column(
          children: [
            Form(
              child: TextFormField(
                initialValue: NewTitle,
                // cursorColor: color.white,
                onChanged: (value){
                  NewTitle = value;
                },
                style: TextStyle(
                    fontSize: 25,
                    // color: color.white,
                    fontWeight: FontWeight.bold),
                decoration: InputDecoration(
                    border: InputBorder.none,
                    errorBorder: InputBorder.none,
                    focusedBorder: InputBorder.none,
                    enabledBorder: InputBorder.none,
                    disabledBorder: InputBorder.none,
                    hintText: "Title",
                    hintStyle: TextStyle(
                      fontWeight: FontWeight.bold,
                      // color: Colors.grey.withOpacity(0.8),
                    )),
              ),
            ),
            Container(
                height: 300,
                child: Form(
                  child: TextFormField(
                    onChanged: (value){
                      NewNoteDetail = value;
                    },
                    initialValue: NewNoteDetail,
                    // cursorColor: color.white,
                    keyboardType: TextInputType.multiline,
                    minLines: 50,
                    maxLines: null,
                    style: TextStyle(fontSize: 17,
                        // color: color.white
                    ),
                    decoration: InputDecoration(
                        border: InputBorder.none,
                        errorBorder: InputBorder.none,
                        focusedBorder: InputBorder.none,
                        enabledBorder: InputBorder.none,
                        disabledBorder: InputBorder.none,
                        hintText: "Note",
                        hintStyle: TextStyle(
                          fontWeight: FontWeight.bold,
                          // color: Colors.grey.withOpacity(0.8),
                        )),
                  ),
                )),
          ],
        ),
      ),
    );
  }
}
