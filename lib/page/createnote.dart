import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:keep_note_clone/page/home_page.dart';
import 'package:keep_note_clone/model/notemodel.dart';
import 'package:keep_note_clone/services/database.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:speech_to_text/speech_to_text.dart';
import 'package:uuid/uuid.dart';
import '../color.dart';
// import 'package:path/path.dart' as path;

class Createnote extends StatefulWidget {
  File? file;
   Createnote({Key? key, this.file}) : super(key: key);

  @override
  State<Createnote> createState() => _CreatenoteState();
}

class _CreatenoteState extends State<Createnote> {
  TextEditingController title = TextEditingController();
  TextEditingController content = TextEditingController();

  File? _image;
  String? _imagePath;

  Future<void> _pickImageGallery() async {
    final picker = ImagePicker();
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);

    if (pickedFile != null) {
      setState(() {
        _image = File(pickedFile.path);
        _imagePath = pickedFile.path;
        print(pickedFile.path);
      });
    }
  }

  Future<void> _pickImagecamera() async {
    final picker = ImagePicker();
    final pickedFile = await picker.pickImage(source: ImageSource.camera);

    if (pickedFile != null) {
      setState(() {
        _image = File(pickedFile.path);
        _imagePath = pickedFile.path;
        print(pickedFile.path);
      });
    }
  }

  Future<void> _saveImagePath(String path) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('saved_image', path);
  }
  // Future<void> _loadImage() async {
  //   final prefs = await SharedPreferences.getInstance();
  //   setState(() {
  //     _imagePath = prefs.getString('saved_image');
  //   });
  // }


  var uuid = Uuid();
  void checMic() async {
    bool micAvailable = await speechToText.initialize();
    if (micAvailable) {
      print("Mic avilable");
    } else {
      print("user denide to speech mic");
    }
  }

  SpeechToText speechToText = SpeechToText();
  var isListening = false;
  var textspeech = "Click mic to record";
  @override
  void initState() {
    super.initState();
    // _loadImage();
    checMic();
    if (widget.file == null) {
      content.text = "";
    } else {
      _imagePath = widget.file!.path;
    }
  }

  @override
  void dispose() {
    super.dispose();
    title.dispose();
    content.dispose();
  }

  void showPhotoOption() {
    showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            backgroundColor: color.cardcolor,
            title: Text("Upload Photo",style: TextStyle(color: color.white),),
            content: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                ListTile(
                  onTap: () {
                    Navigator.pop(context);
                    _pickImageGallery();
                  },
                  leading: Icon(
                    Icons.photo_album,
                     color: color.white,
                  ),
                  title: Text("Select from Gallery",style: TextStyle(color: color.white),),
                ),
                ListTile(
                  onTap: () {
                    Navigator.pop(context);
                    _pickImagecamera();
                  },
                  leading: Icon(
                    Icons.camera_alt,
                    color: color.white,
                  ),
                  title: Text("Take a photo from Camera",style: TextStyle(color: color.white),),
                )
              ],
            ),
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // resizeToAvoidBottomInset: true,
      backgroundColor: color.bgcolor,
      appBar: AppBar(
        foregroundColor: color.white,
        backgroundColor: color.bgcolor,
        elevation: 0.0,
        actions: [
          IconButton(onPressed: (){
            showPhotoOption();
            if(_imagePath == null) {
              Text('');
            }
            else{
              Image.file(File(_imagePath!));
            }
          }, icon: Icon(Icons.attachment_outlined)),
          IconButton(
              splashRadius: 17,
              onPressed: () async {
                _imagePath != null ?
                await NoteDatabase.instance.InsertEntry(Note(
                  pin: false,
                  title: title.text,
                  uniqueId: uuid.v1(),
                  isArchive: false,
                  content: content.text,
                  createdTime: DateTime.now(),
                  attachImage: _imagePath!
                )) : await NoteDatabase.instance.InsertEntry(Note(
                    pin: false,
                    title: title.text,
                    uniqueId: uuid.v1(),
                    isArchive: false,
                    content: content.text,
                    createdTime: DateTime.now(),
                ));
                // await _saveImagePath(_imagePath!);
                Navigator.pushReplacement(
                    context, MaterialPageRoute(builder: (_) => HomePage()));
              },
              icon: Icon(Icons.save_outlined)),

        ],
      ),
      body: SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: 15, vertical: 10),
          child: Column(
            children: [
              TextField(
                controller: title,
                cursorColor: color.white,
                style: TextStyle(
                    fontSize: 25,
                    color: color.white,
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
                      color: Colors.grey.withOpacity(0.8),
                    )),
              ),
              Container(
                height: 300,
                child: TextField(
                  controller: content,
                  cursorColor: color.white,
                  keyboardType: TextInputType.multiline,
                  minLines: 50,
                  maxLines: null,
                  style: TextStyle(fontSize: 17, color: color.white),
                  decoration: InputDecoration(
                      border: InputBorder.none,
                      errorBorder: InputBorder.none,
                      focusedBorder: InputBorder.none,
                      enabledBorder: InputBorder.none,
                      disabledBorder: InputBorder.none,
                      hintText: "Note",
                      hintStyle: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Colors.grey.withOpacity(0.8),
                      )),
                ),
              ),
              Container(
                child:  _imagePath == null
                    ? Text('')
                    : Image.file(File(_imagePath!)),
              )
            ],
          ),
        ),
      ),
      floatingActionButton: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Padding(
            padding: const EdgeInsets.all(15.00),
            // child: ElevatedButton(
            //     onPressed: () {
            //       _pickImage();
            //     },
            //     child: Text("Photo")),
          ),
          FloatingActionButton(
            onPressed: () async {
              if (!isListening) {
                bool micAvailable = await speechToText.initialize();
                if (micAvailable) {
                  setState(() {
                    isListening = true;
                  });
                  speechToText.listen(
                      listenFor: Duration(seconds: 20),
                      onResult: (result) {
                        setState(() {
                          textspeech = result.recognizedWords;
                          isListening = false;
                          content.text = textspeech.toString();
                        });
                      });
                }
              } else {
                setState(() {
                  isListening = false;
                  speechToText.stop();
                });
              }
            },
            backgroundColor: color.cardcolor,
            child: isListening
                ? Icon(
                    Icons.record_voice_over,
                    color: color.white,
                  )
                : Icon(
                    Icons.mic,
                    color: color.white,
                  ),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(50.00),
            ),
          ),
        ],
      ),
    );
  }
}
