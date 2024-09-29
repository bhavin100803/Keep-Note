import 'dart:io';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:keep_note_clone/color.dart';
import 'package:keep_note_clone/page/home_page.dart';
import 'package:keep_note_clone/services/database.dart';
import 'package:share_plus/share_plus.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../model/notemodel.dart';
import 'editnote.dart';
class NoteView extends StatefulWidget {
  Note? note;
  NoteView({required this.note});

  @override
  _NoteViewState createState() => _NoteViewState();
}

class _NoteViewState extends State<NoteView> {
  @override
  String? _imagePath;
  void initState() {
    _loadImage();
    super.initState();
  }
  Future<void> _loadImage() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      _imagePath = prefs.getString('saved_image');
    });
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
              onPressed: ()async {
                 _shareTitleAndContent();
              },
              icon: Icon(Icons.share)),
          IconButton(
              splashRadius: 17,
              onPressed: ()async {
                await NoteDatabase.instance.pinnote(widget.note);
                Navigator.pushReplacement(context, MaterialPageRoute(builder: (_)=>HomePage()));
              },
              icon: Icon(widget.note!.pin ? Icons.push_pin : Icons.push_pin_outlined)),
          IconButton(
              splashRadius: 17,
              onPressed: ()async {
                await NoteDatabase.instance.archivenote(widget.note);
                Navigator.pushReplacement(context, MaterialPageRoute(builder: (_)=>HomePage()));
              },
              icon: Icon(widget.note!.isArchive ? Icons.archive : Icons.archive_outlined)),
          IconButton(
              splashRadius: 17,
              onPressed: () async{
                 await NoteDatabase.instance.deletenote(widget.note);
                 Navigator.pushReplacement(context, MaterialPageRoute(builder: (_)=>HomePage()));
              },
              icon: Icon(Icons.delete_forever_outlined)),
          IconButton(
              splashRadius: 17,
              onPressed: () {
                Navigator.push(context, MaterialPageRoute(builder: (_)=>Editnote(note: widget.note!)));
              },
              icon: Icon(Icons.edit_outlined))
        ],
      ),

      body: SingleChildScrollView(
        physics: BouncingScrollPhysics(),
        child: Container(
          padding: EdgeInsets.all(15),
          child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children : [
                  Text("Created on ${DateFormat('dd-MM-yyyy - KK:mm').format(widget.note!.createdTime)}",),
                    // style: TextStyle(color: color.white),
                SizedBox(height: 10,),
                Text(widget.note!.title , style: TextStyle(fontSize: 23 , fontWeight: FontWeight.bold),),
                    // color: Colors.white ,
                SizedBox(height: 10,),
                Text(widget.note!.content,
                  // style: TextStyle(color: Colors.white),
                ),
                SizedBox(height: 10,),
                Container(
                  child:  widget.note!.attachImage!.isEmpty
                      ? Text('')
                      : Image.file(File(widget.note!.attachImage!)),
                )
              ]
          ),
        ),
      ),
    );
  }
  void _shareTitleAndContent() {
    String title = widget.note!.title;
    String content = widget.note!.content;
    String messageToShare = "$title\n$content";
    Share.share(messageToShare);
  }
}