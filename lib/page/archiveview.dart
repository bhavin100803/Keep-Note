import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:keep_note_clone/color.dart';
import 'package:keep_note_clone/page/createnote.dart';
import 'package:keep_note_clone/page/searchpage.dart';
import 'package:keep_note_clone/page/sidemenubar.dart';
import 'package:keep_note_clone/services/login_info.dart';

import '../model/notemodel.dart';
import '../services/database.dart';
import 'noteview.dart';

class Archiveview extends StatefulWidget {
  const Archiveview({super.key});

  @override
  State<Archiveview> createState() => _ArchivePageState();
}

class _ArchivePageState extends State<Archiveview> {
  List<Note> noteList = [];
  bool isLoading = true;
  // String note =
  //     "This is Note This is Note This is Note This is Note This is Note This is Note This is Note This is Note This is Note This is Note";
  // String note1 = "This is Note This is Note This ";
  GlobalKey<ScaffoldState> _draewrKey = GlobalKey();
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getAllNotes();
  }
  Future getAllNotes() async{
    this.noteList =  await NoteDatabase.instance.readAllArchive();
    if(this.mounted){
      setState(() {
        isLoading = false;
      });
    }
  }
  @override
  Widget build(BuildContext context) {
    return  isLoading
        ? Scaffold(
      backgroundColor: color.bgcolor,
      body: Center(
        child: CircularProgressIndicator(
          color: color.white,
        ),
      ),
    )
        : Scaffold(
      endDrawerEnableOpenDragGesture: true,
      key: _draewrKey,
      drawer: Sidemenubar(),
      backgroundColor: color.bgcolor,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Container(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  margin: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                  width: MediaQuery.of(context).size.width,
                  height: 55,
                  decoration: BoxDecoration(
                      color: color.cardcolor,
                      borderRadius: BorderRadius.circular(10),
                      boxShadow: [
                        BoxShadow(
                            color: Colors.black.withOpacity(0.2),
                            spreadRadius: 1,
                            blurRadius: 3)
                      ]),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          IconButton(
                              onPressed: () {
                               Navigator.pop(context);
                              },
                              icon: Icon(
                                Icons.arrow_back_sharp,
                                color: Colors.white,
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
                              width: MediaQuery.of(context).size.width/3,
                              height: 200,
                              // decoration: BoxDecoration(border: Border.all(color: Colors.white)),
                              child: Column(
                                mainAxisAlignment:
                                MainAxisAlignment.center,
                                crossAxisAlignment:
                                CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    "Search Your Notes",
                                    style: TextStyle(
                                        color:
                                        Colors.white.withOpacity(0.5),
                                        fontSize: 15),
                                  ),
                                ],
                              ),
                            ),
                          )
                        ],
                      ),
                      Container(
                        margin: EdgeInsets.symmetric(horizontal: 6),
                        child: Row(
                          children: [
                            // TextButton(
                            //     style: ButtonStyle(
                            //         shape: MaterialStateProperty.all<
                            //             RoundedRectangleBorder>(
                            //             RoundedRectangleBorder(
                            //                 borderRadius:
                            //                 BorderRadius.circular(50.00)))),
                            //     onPressed: () {},
                            //     child: Icon(
                            //       Icons.grid_view,
                            //       color: Colors.white,
                            //     )),
                            // SizedBox(
                            //   width: 4,
                            // ),
                            // CircleAvatar(
                            //   radius: 16,
                            //   backgroundColor: Colors.orange,
                            // )
                          ],
                        ),
                      ),
                    ],
                  ),
                ),

                // Container(
                //   padding: EdgeInsets.symmetric(horizontal: 10, vertical: 15),
                //   height: MediaQuery.of(context).size.height,
                //   child: StaggeredGridView.countBuilder(
                //     physics: NeverScrollableScrollPhysics(),
                //     shrinkWrap: true,
                //     itemCount: 10,
                //     mainAxisSpacing: 12,
                //     crossAxisSpacing: 12,
                //     crossAxisCount: 4,
                //     staggeredTileBuilder: (index) => StaggeredTile.fit(2),
                //     itemBuilder: (context, index) => Container(
                //       padding: EdgeInsets.all(10),
                //       decoration: BoxDecoration(
                //         color:index.isEven? Colors.green[900] : Colors.blue[900],
                //           border: Border.all(color: color.white.withOpacity(0.4)),
                //           borderRadius: BorderRadius.circular(7)),
                //       child: Column(
                //         crossAxisAlignment: CrossAxisAlignment.start,
                //         children: [
                //           Text(
                //             "Heading",
                //             style: TextStyle(
                //                 color: color.white,
                //                 fontSize: 20,
                //                 fontWeight: FontWeight.bold),
                //           ),
                //           SizedBox(
                //             height: 10,
                //           ),
                //           Text(
                //             index.isEven ? note : note1,
                //             style: TextStyle(color: color.white),
                //           )
                //         ],
                //       ),
                //     ),
                //   ),
                // ),
                notesectionall(),
                // listsection()
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget notesectionall() {
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
                      color: color.white.withOpacity(0.5),
                      fontSize: 15,
                      fontWeight: FontWeight.bold),
                ),
              ],
            ),
          ),
          Container(
            padding: EdgeInsets.symmetric(horizontal: 10, vertical: 15),
            // height: MediaQuery.of(context).size.height,
            child: StaggeredGridView.countBuilder(
              physics: NeverScrollableScrollPhysics(),
              shrinkWrap: true,
              itemCount: noteList.length,
              mainAxisSpacing: 12,
              crossAxisSpacing: 12,
              crossAxisCount: 4,
              staggeredTileBuilder: (index) => StaggeredTile.fit(2),
              itemBuilder: (context, index) => InkWell(
                onTap: () {
                   Navigator.push(context, MaterialPageRoute(builder: (_) => NoteView(note: noteList[index],)));
                },
                child: Container(
                  padding: EdgeInsets.all(10),
                  decoration: BoxDecoration(
                      border: Border.all(color: color.white.withOpacity(0.4)),
                      borderRadius: BorderRadius.circular(7)),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        noteList[index].title,
                        style: TextStyle(
                            color: color.white,
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
                        style: TextStyle(color: color.white),
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

  // Widget listsection() {
  //   return Container(
  //     child: Column(
  //       children: [
  //         Container(
  //           margin: EdgeInsets.symmetric(horizontal: 25, vertical: 10),
  //           child: Row(
  //             crossAxisAlignment: CrossAxisAlignment.start,
  //             children: [
  //               Text(
  //                 "LIST VIEW",
  //                 style: TextStyle(
  //                     color: color.white.withOpacity(0.5),
  //                     fontSize: 15,
  //                     fontWeight: FontWeight.bold),
  //               ),
  //             ],
  //           ),
  //         ),
  //         Container(
  //           padding: EdgeInsets.symmetric(horizontal: 10, vertical: 15),
  //           // height: MediaQuery.of(context).size.height,
  //           child: ListView.builder(
  //             physics: NeverScrollableScrollPhysics(),
  //             shrinkWrap: true,
  //             itemCount: 10,
  //             itemBuilder: (context, index) => Container(
  //               padding: EdgeInsets.all(10),
  //               margin: EdgeInsets.only(bottom: 10),
  //               decoration: BoxDecoration(
  //                   border: Border.all(color: color.white.withOpacity(0.4)),
  //                   borderRadius: BorderRadius.circular(7)),
  //               child: Column(
  //                 crossAxisAlignment: CrossAxisAlignment.start,
  //                 children: [
  //                   Text(
  //                     "Heading",
  //                     style: TextStyle(
  //                         color: color.white,
  //                         fontSize: 20,
  //                         fontWeight: FontWeight.bold),
  //                   ),
  //                   SizedBox(
  //                     height: 10,
  //                   ),
  //                   Text(
  //                     index.isEven
  //                         ? note.length > 250
  //                         ? "${note.substring(0, 250)}..."
  //                         : note
  //                         : note1,
  //                     style: TextStyle(color: color.white),
  //                   )
  //                 ],
  //               ),
  //             ),
  //           ),
  //         ),
  //       ],
  //     ),
  //   );
  // }
}
