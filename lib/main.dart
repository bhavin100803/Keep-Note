import 'dart:async';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:keep_note_clone/page/login/login.dart';
import 'package:keep_note_clone/services/login_info.dart';
import 'package:keep_note_clone/theme.dart';
import 'package:provider/provider.dart';
import 'page/home_page.dart';

Future main() async {
  WidgetsFlutterBinding.ensureInitialized();
  if (kIsWeb) {
    await Firebase.initializeApp(
      options: FirebaseOptions(
        apiKey: "AIzaSyBXH_PEhEiuMtIbskFj1xChfvYZ7h-wh2A",
        appId: "1:6330705937:android:2ebe238f636405c94ce9b0",
        messagingSenderId: "6330705937",
        projectId: "keepnotes-e6170",
        // Your web Firebase config options
      ),
    );
  } else {
    await Firebase.initializeApp();
  }
  runApp(MyApp());
}
class MyApp extends StatefulWidget {


  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  bool isLogIn = false;
  // bool _isDarkMode = false;

  getLoggedInState() async{
    await LocalDataSaver.getLogData().then((value){
      setState((){
        isLogIn = value.toString() == "null";
      });
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
     getLoggedInState();
  }


  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (BuildContext Context)=>UiProvider()..init(),
      child: Consumer<UiProvider>(
          builder: (context,UiProvider notifire,child) {
            return MaterialApp(
              themeMode: notifire.isDark? ThemeMode.dark : ThemeMode.light,
              darkTheme: notifire.isDark? notifire.darkTheme : notifire.lightTheme,
              home: isLogIn ? Login(): HomePage(),
              debugShowCheckedModeBanner: false,
            );
          }
      ),
    );
    //   ChangeNotifierProvider(
    //   create: (BuildContext Context)=>UiProvider()..init(),
    //   child:Consumer<UiProvider>(
    //       builder: (context,UiProvider notifire,child) {
    //         return MaterialApp(
    //           themeMode: notifire.isDark? ThemeMode.light : ThemeMode.dark,
    //           // darkTheme: notifire.isDark? notifire.lightTheme : notifire.darkTheme,
    //           home: isLogIn ? Login(): HomePage(),
    //           debugShowCheckedModeBanner: false,
    //         );
    //       }
    //   ),
    // );


    //   MaterialApp(
    //     debugShowCheckedModeBanner: false,
    //     title: 'Flutter Demo',
    //      home:  isLogIn ? Login(): HomePage(),
    // );
  }
}


