import 'package:flutter/material.dart';
import 'package:keep_note_clone/page/archiveview.dart';
import 'package:keep_note_clone/color.dart';
import 'package:keep_note_clone/page/home_page.dart';
import 'package:keep_note_clone/page/setting.dart';

import '../services/auth.dart';
import '../services/login_info.dart';
import 'login/login.dart';


class Sidemenubar extends StatefulWidget {
  const Sidemenubar({super.key});

  @override
  State<Sidemenubar> createState() => _SidemenubarState();
}

class _SidemenubarState extends State<Sidemenubar> {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Container(
        decoration: BoxDecoration(color: color.bgcolor),
        child: SafeArea(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                  margin: EdgeInsets.symmetric(horizontal: 25, vertical: 10),
                  child: Text(
                    "Google Keep",
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 25,
                        fontWeight: FontWeight.bold),
                  )),
              Divider(
                color: Colors.white.withOpacity(0.3),
              ),
              sectionone(),
              SizedBox(height: 5,),
              sectiontwo(),
              // SizedBox(height: 5,),
              // sectionthree(),
              SizedBox(height: 5,),
              sectionsetting(),
              SizedBox(height: 5,),
              singout()
            ],
          ),
        ),
      ),
    );
  }

  Widget sectionone(){
    return  Container(
      margin: EdgeInsets.only(right: 10),
      child: TextButton(
          style: ButtonStyle(
              backgroundColor: MaterialStateProperty.all(Colors.orangeAccent.withOpacity(0.3)),
              shape: MaterialStateProperty.all<RoundedRectangleBorder>(RoundedRectangleBorder(
                  borderRadius: BorderRadius.only(
                    topRight: Radius.circular(50),
                    bottomRight: Radius.circular(50),
                  )
              ))
          ),
          onPressed: () {
            Navigator.pushReplacement(context, MaterialPageRoute(builder: (_)=>HomePage()));
          },
          child: Container(
            padding: EdgeInsets.all(5),
            child: Row(
              children: [
                Icon(Icons.lightbulb,size: 25,color: color.white.withOpacity(0.7),),
                SizedBox(
                  width: 27,
                ),
                Text(
                  "Notes",
                  style: TextStyle(
                      color: Colors.white.withOpacity(0.7), fontSize: 18),
                )
              ],
            ),
          )),
    );
  }

  Widget sectiontwo(){
    return  Container(
      margin: EdgeInsets.only(right: 10),
      child: TextButton(
          style: ButtonStyle(
              // backgroundColor: MaterialStateProperty.all(Colors.orangeAccent.withOpacity(0.3)),
              shape: MaterialStateProperty.all<RoundedRectangleBorder>(RoundedRectangleBorder(
                  borderRadius: BorderRadius.only(
                    topRight: Radius.circular(50),
                    bottomRight: Radius.circular(50),
                  )
              ))
          ),
          onPressed: () {
              Navigator.push(context, MaterialPageRoute(builder: (_)=>Archiveview()));
          },
          child: Container(
            padding: EdgeInsets.all(5),
            child: Row(
              children: [
                Icon(Icons.archive_outlined,size: 25,color: color.white.withOpacity(0.7),),
                SizedBox(
                  width: 27,
                ),
                Text(
                  "Archive",
                  style: TextStyle(
                      color: Colors.white.withOpacity(0.7), fontSize: 18),
                )
              ],
            ),
          )),
    );
  }

  // Widget sectionthree(){
  //   return  Container(
  //     margin: EdgeInsets.only(right: 10),
  //     child: TextButton(
  //         style: ButtonStyle(
  //           // backgroundColor: MaterialStateProperty.all(Colors.orangeAccent.withOpacity(0.3)),
  //             shape: MaterialStateProperty.all<RoundedRectangleBorder>(RoundedRectangleBorder(
  //                 borderRadius: BorderRadius.only(
  //                   topRight: Radius.circular(50),
  //                   bottomRight: Radius.circular(50),
  //                 )
  //             ))
  //         ),
  //         onPressed: () {
  //             // Navigator.push(context, MaterialPageRoute(builder: (_)=>pinview()));
  //         },
  //         child: Container(
  //           padding: EdgeInsets.all(5),
  //           child: Row(
  //             children: [
  //               Icon(Icons.push_pin_outlined,size: 25,color: color.white.withOpacity(0.7),),
  //               SizedBox(
  //                 width: 27,
  //               ),
  //               Text(
  //                 "Pin Note",
  //                 style: TextStyle(
  //                     color: Colors.white.withOpacity(0.7), fontSize: 18),
  //               )
  //             ],
  //           ),
  //         )),
  //   );
  // }

  Widget sectionsetting(){
    return  Container(
      margin: EdgeInsets.only(right: 10),
      child: TextButton(
          style: ButtonStyle(
            // backgroundColor: MaterialStateProperty.all(Colors.orangeAccent.withOpacity(0.3)),
              shape: MaterialStateProperty.all<RoundedRectangleBorder>(RoundedRectangleBorder(
                  borderRadius: BorderRadius.only(
                    topRight: Radius.circular(50),
                    bottomRight: Radius.circular(50),
                  )
              ))
          ),
          onPressed: () {
            Navigator.push(context, MaterialPageRoute(builder: (_)=>Setting()));
          },
          child: Container(
            padding: EdgeInsets.all(5),
            child: Row(
              children: [
                Icon(Icons.settings_outlined,size: 25,color: color.white.withOpacity(0.7),),
                SizedBox(
                  width: 27,
                ),
                Text(
                  "Setting",
                  style: TextStyle(
                      color: Colors.white.withOpacity(0.7), fontSize: 18),
                )
              ],
            ),
          )),
    );
  }

  Widget singout(){
    return  Container(
      margin: EdgeInsets.only(right: 10),
      child: TextButton(
          style: ButtonStyle(
            // backgroundColor: MaterialStateProperty.all(Colors.orangeAccent.withOpacity(0.3)),
              shape: MaterialStateProperty.all<RoundedRectangleBorder>(RoundedRectangleBorder(
                  borderRadius: BorderRadius.only(
                    topRight: Radius.circular(50),
                    bottomRight: Radius.circular(50),
                  )
              ))
          ),
          onPressed: () {
            signOut();
            LocalDataSaver.saveLoginData(false);
            Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                    builder: (_) => Login()));
          },
          child: Container(
            padding: EdgeInsets.all(5),
            child: Row(
              children: [
                Icon(Icons.logout,size: 25,color: color.white.withOpacity(0.7),),
                SizedBox(
                  width: 27,
                ),
                Text(
                  "Log-out",
                  style: TextStyle(
                      color: Colors.white.withOpacity(0.7), fontSize: 18),
                )
              ],
            ),
          )),
    );
  }
}
