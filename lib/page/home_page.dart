import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:keep_note_clone/color.dart';
import 'package:keep_note_clone/page/createnote.dart';
import 'package:keep_note_clone/page/drawing.dart';
import 'package:keep_note_clone/model/notemodel.dart';
import 'package:keep_note_clone/services/database.dart';
import 'package:keep_note_clone/services/login_info.dart';
import 'package:provider/provider.dart';
import 'package:speech_to_text/speech_to_text.dart';
import 'package:uuid/uuid.dart';
import '../theme.dart';
import 'noteview.dart';
import 'searchpage.dart';
import 'sidemenubar.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
   var _isDarkMode;
  late String? ImgUrl;
  bool isStaggered = true;
  bool isLoading = true;
  List<Note> noteList = [];
  List<Note> pinNoteList = [];
  List<Note> archiveNoteList = [];



  // String note2 =
  //     "This is Note This is Note This is Note This is Note This is Note This is Note This is Note This is Note This is Note This is Note"
  //     "This is Note This is Note This is Note This is Note This is Note This is Note This is Note This is Note This is Note This is Note"
  //     "This is Note This is Note This is Note This is Note This is Note This is Note This is Note This is Note This is Note This is Note";
  // String note1 = "This is Note This is Note This ";
  GlobalKey<ScaffoldState> _draewrKey = GlobalKey();
  @override
  void initState() {
    super.initState();
    // createEntry(Note(
    //     pin: false,
    //     title: "Hello",
    //     content:
    //         "This is my Profile This is my Profile This is my Profile This is my Profile ",
    //     createdTime: DateTime.now()));
    getAllNotes();
    checMic();
    // LocalDataSaver.saveSync(false);
    // updateonenote();
    // getOneNote();
    // deletenote();
  }


  // Define different pages for navigation
  final List<Widget> _pages = [
    HomePage(),
    // RemindersPage(),
    // ArchivedPage(),
    // SettingsPage(),
  ];

  Future createEntry(Note note) async {
    await NoteDatabase.instance.InsertEntry(note);
  }

  Future getAllNotes() async {
    LocalDataSaver.getImg().then((value) {
      if (this.mounted) {
        setState(() {
          ImgUrl = value;
        });
      }
    });

    this.noteList = await NoteDatabase.instance.readAllNotes();
    this.pinNoteList = await NoteDatabase.instance.pinall();
    this.archiveNoteList = await NoteDatabase.instance.readAllArchive();

    if (this.mounted) {
      setState(() {
        isLoading = false;
      });
    }
  }

  Future getOneNote(int id) async {
    await NoteDatabase.instance.readOneNote(id);
  }

  Future updateonenote(Note note) async {
    await NoteDatabase.instance.upadatenotes(note);
  }

  Future deletenote(Note note) async {
    await NoteDatabase.instance.deletenote(note);
  }

  var uuid = Uuid();
  void checMic() async {
    bool micAvailable = await speechToText.initialize();
    if (micAvailable) {
      print("Mic avilable");
    } else {
      print("user denide to speech mic");
    }
  }

  void Thame(){
    if(_isDarkMode){

    }else{

    }
  }



  SpeechToText speechToText = SpeechToText();
  var isListening = false;
  var textspeech = "Click mic to record";

  int _selectedIndex = 3;

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }
  @override
  Widget build(BuildContext context) {
    return isLoading
        ? Scaffold(
            // backgroundColor: color.bgcolor,
            body: Center(
              child: CircularProgressIndicator(
                // color: color.white,
              ),
            ),
          )
        : Scaffold(
            floatingActionButton: FloatingActionButton(
              onPressed: () {
                Navigator.push(
                    context, MaterialPageRoute(builder: (_) => Createnote()));
              },
               // backgroundColor: color.cardcolor,
              child: Image.asset(
                "assets/add.png",
                height: 28,
                width: 28,
              ),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(50.00),
              ),
            ),
            floatingActionButtonLocation:
                FloatingActionButtonLocation.endDocked,
            bottomNavigationBar: BottomAppBar(
              // color: color.cardcolor,
              notchMargin: 10.0,
              shape: CircularNotchedRectangle(), // This creates the notch
              child: Row(
                // mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Column(
                    // crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      SizedBox(
                        height: 10.00,
                      ),
                      GestureDetector(
                          onTap: () async {
                            _onItemTapped(0);
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (_) => DrawingPage()));
                          },
                          child: Image.asset(
                            "assets/brush.png",
                            height: 32,
                            width: 32,
                          )),
                    ],
                  ),
                  // Column(
                  //   children: [
                  //     GestureDetector(
                  //       onTap: () {
                  //         _onItemTapped(1);
                  //       },
                  //       child:Icon(Icons.home,color: color.white,)
                  //     ),
                  //     Text(
                  //       "Home",
                  //         style: TextStyle(color: _selectedIndex == 1 ? Colors.white : Colors.grey)
                  //     )
                  //   ],
                  // ),
                  // Column(
                  //   children: [
                  //     GestureDetector(
                  //       onTap: () {
                  //         _onItemTapped(3);
                  //       },
                  //       child: Icon(Icons.message_outlined,color: color.white,)
                  //     ),
                  //     Text(
                  //       "Message",
                  //       style: TextStyle(color: _selectedIndex == 2 ? Colors.white : Colors.grey)
                  //     )
                  //   ],
                  // ),
                  // Column(
                  //   children: [
                  //     GestureDetector(
                  //       onTap: () {
                  //         _onItemTapped(4);
                  //       },
                  //       child:Icon(Icons.person,color: color.white,)
                  //
                  //          ),
                  //     Text(
                  //       "Profile",
                  //       style: TextStyle(color: _selectedIndex == 3 ? Colors.white : Colors.grey)
                  //     )
                  //   ],
                  // ),
                  SizedBox(width: 60), // Space for the center icon
                ],
              ),
            ),
            endDrawerEnableOpenDragGesture: true,
            key: _draewrKey,
            drawer: Sidemenubar(),
            // backgroundColor: color.bgcolor,
            body: SafeArea(
              child: Column(
                children: <Widget>[
                  Container(
                    margin: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                    width: MediaQuery.of(context).size.width,
                    height: 55,
                    decoration: BoxDecoration(
                          // color: Colors.red,
                        borderRadius: BorderRadius.circular(20),
                        border: Border.all(color: Colors.grey)
                        // boxShadow: [
                        //   BoxShadow(
                        //       // color: Colors.black.withOpacity(0.2),
                        //       spreadRadius: 1,
                        //       blurRadius: 3)
                        // ]
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: [
                            IconButton(
                                onPressed: () {
                                  _draewrKey.currentState!.openDrawer();
                                },
                                icon: Icon(
                                  Icons.menu,
                                  // color: Colors.white,
                                )),
                            SizedBox(
                              width: 10,
                            ),
                            GestureDetector(
                              onTap: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => SearchView()));
                              },
                              child: Container(
                                width: MediaQuery.of(context).size.width / 2.8,
                                height: 200,
                                // decoration: BoxDecoration(border: Border.all(color: Colors.white)),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      "Search Your Notes",
                                      style: TextStyle(
                                          // color: Colors.white.withOpacity(0.5),
                                          fontSize: 15),
                                    ),
                                  ],
                                ),
                              ),
                            )
                          ],
                        ),
                        Container(
                          margin: EdgeInsets.symmetric(horizontal: 5),
                          child: Row(
                            children: [
                              GestureDetector(
                                onTap: (){
                                  setState(() {
                                    isStaggered = !isStaggered;
                                  });
                                },
                                child: isStaggered
                                    ? Icon(
                                  Icons.grid_view,
                                  // color: Colors.white,
                                )
                                    : Icon(
                                  Icons.splitscreen,
                                  // color: Colors.white,
                                ),
                              ),
                              SizedBox(width: 15,),
                              GestureDetector(
                                // onTap: () {
                                //   signOut();
                                //   LocalDataSaver.saveLoginData(false);
                                //   Navigator.pushReplacement(
                                //       context,
                                //       MaterialPageRoute(
                                //           builder: (_) => Login()));
                                // },
                                child: CircleAvatar(
                                  onBackgroundImageError: (object, StackTrace) {
                                    print("Ok");
                                  },
                                  radius: 16,
                                  backgroundImage:
                                      NetworkImage(ImgUrl.toString()),
                                ),
                              )
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  // First ListView, height adjusted by contents

                  // isStaggered ? notesectionall() : listsection()

                  pinNoteList.length > 0
                      ? ListView.builder(
                          shrinkWrap: true,
                          physics: NeverScrollableScrollPhysics(),
                          itemCount: 1,
                          itemBuilder: (BuildContext context, int index) {
                            return pinNoteList[index].pin
                                ? Container(
                                    height:
                                        MediaQuery.sizeOf(context).height / 4.5,
                                    child: SingleChildScrollView(
                                      child: Column(
                                        children: [
                                          Container(
                                            margin: EdgeInsets.symmetric(
                                                horizontal: 25, vertical: 10),
                                            child: Row(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Text(
                                                  "Pin",
                                                  style: TextStyle(

                                                      fontSize: 15,
                                                      fontWeight:
                                                          FontWeight.bold),
                                                ),
                                              ],
                                            ),
                                          ),
                                          Container(
                                            padding: EdgeInsets.symmetric(
                                                horizontal: 10, vertical: 15),
                                            // height: MediaQuery.of(context).size.height / 2,
                                            child: isStaggered
                                                ? StaggeredGridView
                                                    .countBuilder(
                                                    physics:
                                                        NeverScrollableScrollPhysics(),
                                                    shrinkWrap: true,
                                                    itemCount:
                                                        pinNoteList.length,
                                                    mainAxisSpacing: 12,
                                                    crossAxisSpacing: 12,
                                                    crossAxisCount: 4,
                                                    staggeredTileBuilder:
                                                        (index) =>
                                                            StaggeredTile.fit(
                                                                2),
                                                    itemBuilder: (context,
                                                            index) =>
                                                        InkWell(
                                                            onTap: () {
                                                              Navigator.push(
                                                                  context,
                                                                  MaterialPageRoute(
                                                                      builder: (_) =>
                                                                          NoteView(
                                                                            note:
                                                                                pinNoteList[index],
                                                                          )));
                                                            },
                                                            child: pinNoteList[
                                                                        index]
                                                                    .pin
                                                                ? Container(
                                                                    padding:
                                                                        EdgeInsets.all(
                                                                            10),
                                                                    decoration: BoxDecoration(
                                                                        border: Border.all(
                                                                            color: Colors.grey
                                                                        ),
                                                                        borderRadius:
                                                                            BorderRadius.circular(7)),
                                                                    child:
                                                                        Column(
                                                                      crossAxisAlignment:
                                                                          CrossAxisAlignment
                                                                              .start,
                                                                      children: [
                                                                        Text(
                                                                          pinNoteList[index]
                                                                              .title,
                                                                          style: TextStyle(
                                                                              // color: color.white,
                                                                              fontSize: 20,
                                                                              fontWeight: FontWeight.bold),
                                                                        ),
                                                                        SizedBox(
                                                                          height:
                                                                              10,
                                                                        ),
                                                                        Text(
                                                                          pinNoteList[index].content.length > 250
                                                                              ? "${pinNoteList[index].content.substring(0, 250)}..."
                                                                              : pinNoteList[index].content,
                                                                          // style: TextStyle(color: color.white),
                                                                        )
                                                                      ],
                                                                    ),
                                                                  )
                                                                : Container()),
                                                  )
                                                : ListView.builder(
                                                    physics:
                                                        NeverScrollableScrollPhysics(),
                                                    shrinkWrap: true,
                                                    itemCount:
                                                        pinNoteList.length,
                                                    itemBuilder: (context,
                                                            index) =>
                                                        GestureDetector(
                                                            onTap: () {
                                                              Navigator.push(
                                                                  context,
                                                                  MaterialPageRoute(
                                                                      builder: (_) =>
                                                                          NoteView(
                                                                            note:
                                                                                pinNoteList[index],
                                                                          )));
                                                            },
                                                            child: pinNoteList[
                                                                        index]
                                                                    .pin
                                                                ? Container(
                                                                    padding:
                                                                        EdgeInsets.all(
                                                                            10),
                                                                    decoration: BoxDecoration(
                                                                        border: Border.all(
                                                                            color: Colors.grey
                                                                        ),
                                                                        borderRadius:
                                                                            BorderRadius.circular(7)),
                                                                    child:
                                                                        Column(
                                                                      crossAxisAlignment:
                                                                          CrossAxisAlignment
                                                                              .start,
                                                                      children: [
                                                                        Text(
                                                                          pinNoteList[index]
                                                                              .title,
                                                                          style: TextStyle(
                                                                              // color: color.white,
                                                                              fontSize: 20,
                                                                              fontWeight: FontWeight.bold),
                                                                        ),
                                                                        SizedBox(
                                                                          height:
                                                                              10,
                                                                        ),
                                                                        Text(
                                                                          pinNoteList[index].content.length > 250
                                                                              ? "${pinNoteList[index].content.substring(0, 250)}..."
                                                                              : pinNoteList[index].content,
                                                                          // style: TextStyle(color: color.white),
                                                                        )
                                                                      ],
                                                                    ),
                                                                  )
                                                                : Container()),
                                                  ),
                                          )
                                        ],
                                      ),
                                    ),
                                  )
                                : Container(
                                    child: Text("data"),
                                  );
                          })
                      : Container(),
                  Flexible(
                    child: ListView.builder(
                      itemCount: 1, // Number of items in ListView 2
                      itemBuilder: (context, index) {
                        return Column(
                          children: [
                            Container(
                              margin: EdgeInsets.symmetric(
                                  horizontal: 25, vertical: 10),
                              child: Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    "All",
                                    style: TextStyle(

                                        fontSize: 15,
                                        fontWeight: FontWeight.bold),
                                  ),
                                ],
                              ),
                            ),
                            Container(
                              padding: EdgeInsets.symmetric(
                                  horizontal: 10, vertical: 15),
                              // height: MediaQuery.of(context).size.height,
                              child: isStaggered
                                  ? StaggeredGridView.countBuilder(
                                      physics: NeverScrollableScrollPhysics(),
                                      shrinkWrap: true,
                                      itemCount: noteList.length,
                                      mainAxisSpacing: 12,
                                      crossAxisSpacing: 12,
                                      crossAxisCount: 4,
                                      staggeredTileBuilder: (index) =>
                                          StaggeredTile.fit(2),
                                      itemBuilder: (context, index) => InkWell(
                                          onTap: () {
                                            Navigator.push(
                                                context,
                                                MaterialPageRoute(
                                                    builder: (_) => NoteView(
                                                          note: noteList[index],
                                                        )));
                                          },
                                          child: noteList[index].isArchive
                                              ? Container()
                                              : Container(
                                                  padding: EdgeInsets.all(10),
                                                  decoration: BoxDecoration(
                                                      border: Border.all(
                                                          color: Colors.grey
                                                      ),
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              7)),
                                                  child: Column(
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .start,
                                                    children: [
                                                      Text(
                                                        noteList[index].title,
                                                        style: TextStyle(
                                                            // color: color.white,
                                                            fontSize: 20,
                                                            fontWeight:
                                                                FontWeight
                                                                    .bold),
                                                      ),
                                                      SizedBox(
                                                        height: 10,
                                                      ),
                                                      Text(
                                                        noteList[index]
                                                                    .content
                                                                    .length >
                                                                250
                                                            ? "${noteList[index].content.substring(0, 250)}..."
                                                            : noteList[index]
                                                                .content,
                                                        // style: TextStyle(color: color.white),
                                                      )
                                                    ],
                                                  ),
                                                )),
                                    )
                                  : ListView.builder(
                                      physics: NeverScrollableScrollPhysics(),
                                      shrinkWrap: true,
                                      itemCount: noteList.length,
                                      itemBuilder: (context, index) =>
                                          GestureDetector(
                                        onTap: () {
                                          Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                  builder: (_) => NoteView(
                                                        note: noteList[index],
                                                      )));
                                        },
                                        child: noteList[index].isArchive
                                            ? Container()
                                            : Container(
                                                padding: EdgeInsets.all(10),
                                                margin:
                                                    EdgeInsets.only(bottom: 10),
                                                decoration: BoxDecoration(
                                                    border: Border.all(
                                                        color:  Colors.grey
                                                    ),
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            7)),
                                                child: Column(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  children: [
                                                    Text(
                                                      noteList[index].title,
                                                      style: TextStyle(
                                                          // color: color.white,
                                                          fontSize: 20,
                                                          fontWeight:
                                                              FontWeight.bold),
                                                    ),
                                                    SizedBox(
                                                      height: 10,
                                                    ),
                                                    Text(
                                                      noteList[index]
                                                                  .content
                                                                  .length >
                                                              250
                                                          ? "${noteList[index].content.substring(0, 250)}..."
                                                          : noteList[index]
                                                              .content,
                                                      // style: TextStyle(color: color.white),
                                                    )
                                                  ],
                                                ),
                                              ),
                                      ),
                                    ),
                            ),
                          ],
                        );
                      },
                    ),
                  ),
                  // ListView.builder(
                  //   shrinkWrap: true, // This makes the ListView adjust height based on content
                  //   physics: NeverScrollableScrollPhysics(), // Disable scrolling for this ListView
                  //   itemCount: 5, // Number of items in ListView 1
                  //   itemBuilder: (context, index) {
                  //     return ListTile(
                  //       title: Text('Item ${index + 1} in ListView 1'),
                  //     );
                  //   },
                  // ),
                  //
                  // // Second ListView, takes remaining space
                  // Flexible(
                  //   child: ListView.builder(
                  //     itemCount: 20, // Number of items in ListView 2
                  //     itemBuilder: (context, index) {
                  //       return ListTile(
                  //         title: Text('Item ${index + 1} in ListView 2'),
                  //       );
                  //     },
                  //   ),
                  // ),
                ],
              ),
            ),
          );

    // SafeArea(
    //   child: SingleChildScrollView(
    //     child: Container(
    //       child: Column(
    //         crossAxisAlignment: CrossAxisAlignment.start,
    //         children: [
    //
    //           // Container(
    //           //   padding: EdgeInsets.symmetric(horizontal: 10, vertical: 15),
    //           //   height: MediaQuery.of(context).size.height,
    //           //   child: StaggeredGridView.countBuilder(
    //           //     physics: NeverScrollableScrollPhysics(),
    //           //     shrinkWrap: true,
    //           //     itemCount: 10,
    //           //     mainAxisSpacing: 12,
    //           //     crossAxisSpacing: 12,
    //           //     crossAxisCount: 4,
    //           //     staggeredTileBuilder: (index) => StaggeredTile.fit(2),
    //           //     itemBuilder: (context, index) => Container(
    //           //       padding: EdgeInsets.all(10),
    //           //       decoration: BoxDecoration(
    //           //         color:index.isEven? Colors.green[900] : Colors.blue[900],
    //           //           border: Border.all(color: color.white.withOpacity(0.4)),
    //           //           borderRadius: BorderRadius.circular(7)),
    //           //       child: Column(
    //           //         crossAxisAlignment: CrossAxisAlignment.start,
    //           //         children: [
    //           //           Text(
    //           //             "Heading",
    //           //             style: TextStyle(
    //           //                 color: color.white,
    //           //                 fontSize: 20,
    //           //                 fontWeight: FontWeight.bold),
    //           //           ),
    //           //           SizedBox(
    //           //             height: 10,
    //           //           ),
    //           //           Text(
    //           //             index.isEven ? note : note1,
    //           //             style: TextStyle(color: color.white),
    //           //           )
    //           //         ],
    //           //       ),
    //           //     ),
    //           //   ),
    //           // ),
    //
    //         ],
    //       ),
    //     ),
    // ),
    // ),
    // );
  }

  // Widget notesectionall() {
  //   return Column(
  //     children: <Widget>[
  //       ListView.builder(
  //           shrinkWrap: true,
  //           physics: NeverScrollableScrollPhysics(),
  //           itemCount: pinNoteList.length,
  //           itemBuilder: (BuildContext context, int index) {
  //             return pinNoteList[index].pin
  //                 ? Container(
  //                     child: Column(
  //                       children: [
  //                         Container(
  //                           margin: EdgeInsets.symmetric(
  //                               horizontal: 25, vertical: 10),
  //                           child: Row(
  //                             crossAxisAlignment: CrossAxisAlignment.start,
  //                             children: [
  //                               Text(
  //                                 "Pin",
  //                                 style: TextStyle(
  //                                     color: color.white.withOpacity(0.5),
  //                                     fontSize: 15,
  //                                     fontWeight: FontWeight.bold),
  //                               ),
  //                             ],
  //                           ),
  //                         ),
  //                         Container(
  //                           padding: EdgeInsets.symmetric(
  //                               horizontal: 10, vertical: 15),
  //                           height: MediaQuery.of(context).size.height / 2,
  //                           child: StaggeredGridView.countBuilder(
  //                             physics: NeverScrollableScrollPhysics(),
  //                             shrinkWrap: true,
  //                             itemCount: pinNoteList.length,
  //                             mainAxisSpacing: 12,
  //                             crossAxisSpacing: 12,
  //                             crossAxisCount: 4,
  //                             staggeredTileBuilder: (index) =>
  //                                 StaggeredTile.fit(2),
  //                             itemBuilder: (context, index) => InkWell(
  //                                 onTap: () {
  //                                   Navigator.push(
  //                                       context,
  //                                       MaterialPageRoute(
  //                                           builder: (_) => NoteView(
  //                                                 note: pinNoteList[index],
  //                                               )));
  //                                 },
  //                                 child: pinNoteList[index].pin
  //                                     ? Container(
  //                                         padding: EdgeInsets.all(10),
  //                                         decoration: BoxDecoration(
  //                                             border: Border.all(
  //                                                 color: color.white
  //                                                     .withOpacity(0.4)),
  //                                             borderRadius:
  //                                                 BorderRadius.circular(7)),
  //                                         child: Column(
  //                                           crossAxisAlignment:
  //                                               CrossAxisAlignment.start,
  //                                           children: [
  //                                             Text(
  //                                               pinNoteList[index].title,
  //                                               style: TextStyle(
  //                                                   color: color.white,
  //                                                   fontSize: 20,
  //                                                   fontWeight:
  //                                                       FontWeight.bold),
  //                                             ),
  //                                             SizedBox(
  //                                               height: 10,
  //                                             ),
  //                                             Text(
  //                                               pinNoteList[index]
  //                                                           .content
  //                                                           .length >
  //                                                       250
  //                                                   ? "${pinNoteList[index].content.substring(0, 250)}..."
  //                                                   : pinNoteList[index]
  //                                                       .content,
  //                                               style: TextStyle(
  //                                                   color: color.white),
  //                                             )
  //                                           ],
  //                                         ),
  //                                       )
  //                                     : Container()),
  //                           ),
  //                         ),
  //                       ],
  //                     ),
  //                   )
  //                 : Container();
  //           }),
  //       Flexible(
  //         child: ListView.builder(
  //           itemCount: noteList.length, // Number of items in ListView 2
  //           itemBuilder: (context, index) {
  //             return Column(
  //               children: [
  //                 Container(
  //                   margin: EdgeInsets.symmetric(horizontal: 25, vertical: 10),
  //                   child: Row(
  //                     crossAxisAlignment: CrossAxisAlignment.start,
  //                     children: [
  //                       Text(
  //                         "All",
  //                         style: TextStyle(
  //                             color: color.white.withOpacity(0.5),
  //                             fontSize: 15,
  //                             fontWeight: FontWeight.bold),
  //                       ),
  //                     ],
  //                   ),
  //                 ),
  //                 Container(
  //                   padding: EdgeInsets.symmetric(horizontal: 10, vertical: 15),
  //                   // height: MediaQuery.of(context).size.height,
  //                   child: StaggeredGridView.countBuilder(
  //                     physics: NeverScrollableScrollPhysics(),
  //                     shrinkWrap: true,
  //                     itemCount: noteList.length,
  //                     mainAxisSpacing: 12,
  //                     crossAxisSpacing: 12,
  //                     crossAxisCount: 4,
  //                     staggeredTileBuilder: (index) => StaggeredTile.fit(2),
  //                     itemBuilder: (context, index) => InkWell(
  //                         onTap: () {
  //                           Navigator.push(
  //                               context,
  //                               MaterialPageRoute(
  //                                   builder: (_) => NoteView(
  //                                         note: noteList[index],
  //                                       )));
  //                         },
  //                         child: noteList[index].isArchive
  //                             ? Container()
  //                             : Container(
  //                                 padding: EdgeInsets.all(10),
  //                                 decoration: BoxDecoration(
  //                                     border: Border.all(
  //                                         color: color.white.withOpacity(0.4)),
  //                                     borderRadius: BorderRadius.circular(7)),
  //                                 child: Column(
  //                                   crossAxisAlignment:
  //                                       CrossAxisAlignment.start,
  //                                   children: [
  //                                     Text(
  //                                       noteList[index].title,
  //                                       style: TextStyle(
  //                                           color: color.white,
  //                                           fontSize: 20,
  //                                           fontWeight: FontWeight.bold),
  //                                     ),
  //                                     SizedBox(
  //                                       height: 10,
  //                                     ),
  //                                     Text(
  //                                       noteList[index].content.length > 250
  //                                           ? "${noteList[index].content.substring(0, 250)}..."
  //                                           : noteList[index].content,
  //                                       style: TextStyle(color: color.white),
  //                                     )
  //                                   ],
  //                                 ),
  //                               )),
  //                   ),
  //                 ),
  //               ],
  //             );
  //           },
  //         ),
  //       ),
  //     ],
  //   );
  // }

  Widget listsection() {
    return Container(
      child: Column(
        children: [
          Container(
            margin: EdgeInsets.symmetric(horizontal: 25, vertical: 10),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "All",
                  style: TextStyle(

                      fontSize: 15,
                      fontWeight: FontWeight.bold),
                ),
              ],
            ),
          ),
          Container(
            padding: EdgeInsets.symmetric(horizontal: 10, vertical: 15),
            // height: MediaQuery.of(context).size.height,
            child: ListView.builder(
              physics: NeverScrollableScrollPhysics(),
              shrinkWrap: true,
              itemCount: noteList.length,
              itemBuilder: (context, index) => GestureDetector(
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (_) => NoteView(
                                note: noteList[index],
                              )));
                },
                child: Container(
                  padding: EdgeInsets.all(10),
                  margin: EdgeInsets.only(bottom: 10),
                  decoration: BoxDecoration(
                      border: Border.all(color: color.white.withOpacity(0.4)),
                      borderRadius: BorderRadius.circular(7)),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        noteList[index].title,
                        style: TextStyle(
                            // color: color.white,
                            fontSize: 20,
                            fontWeight: FontWeight.bold),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Text(
                        noteList[index].content.length > 250
                            ? "${noteList[index].content.substring(0, 250)}..."
                            : noteList[index].content,
                        // style: TextStyle(color: color.white),
                      )
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
