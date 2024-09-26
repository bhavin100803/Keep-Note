import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:keep_note_clone/color.dart';
import 'package:keep_note_clone/page/home_page.dart';
import 'package:keep_note_clone/services/auth.dart';
import 'package:keep_note_clone/services/firebase_database.dart';
import 'package:keep_note_clone/services/login_info.dart';

class Login extends StatefulWidget {
  const Login({super.key});

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: color.bgcolor,
      appBar: AppBar(
        backgroundColor: color.bgcolor,
        title: Text("Login To App",style: TextStyle(color: color.white),),
      ),
      body: Container(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // SignInButton(Buttons.GoogleDark, onPressed: () async {
            //   await signInWithGoogle();
            //   final User? currentUser = await _auth.currentUser;
            //   LocalDataSaver.saveLoginData(true);
            //   LocalDataSaver.saveImg(currentUser!.photoURL.toString());
            //   LocalDataSaver.saveMail(currentUser.email.toString());
            //   LocalDataSaver.saveName(currentUser.displayName.toString());
            //   LocalDataSaver.saveSync(false);
            //   firedatabase().getAllStoredNotes();
            //   Navigator.pushReplacement(
            //       context, MaterialPageRoute(builder: (_) => HomePage()));
            // }),
            Padding(
              padding: const EdgeInsets.all(20),
              child: ElevatedButton(
                onPressed: ()async{
                  await signInWithGoogle();
                  final User? currentUser = await _auth.currentUser;
                  LocalDataSaver.saveLoginData(true);
                  LocalDataSaver.saveImg(currentUser!.photoURL.toString());
                  LocalDataSaver.saveMail(currentUser.email.toString());
                  LocalDataSaver.saveName(currentUser.displayName.toString());
                  LocalDataSaver.saveSync(false);
                  firedatabase().getAllStoredNotes();
                  Navigator.pushReplacement(
                      context, MaterialPageRoute(builder: (_) => HomePage()));
                },
                style:   ButtonStyle(
                  backgroundColor: MaterialStateProperty.resolveWith<Color>(
                        (Set<MaterialState> states) {
                      if (states.contains(MaterialState.pressed)) {
                        return Colors.green; // Background color when pressed
                      }
                      return Colors.white; // Default background color
                    },
                  ),
                  foregroundColor: MaterialStateProperty.all<Color>(Colors.white),
                ),
                child: Center(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Image.asset("assets/google.png",height: 30,),
                      SizedBox(width: 10,),
                      Text("Sign In With Google",style: TextStyle(color: color.black,fontSize: 18),)
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
