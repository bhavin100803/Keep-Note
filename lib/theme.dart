import 'package:flutter/material.dart';
import 'package:keep_note_clone/color.dart';

class UiProvider extends ChangeNotifier {

  bool _isdark = false;
  bool get isDark => _isdark;

  final darkTheme = ThemeData(
      primaryColor: Colors.black,
      brightness: Brightness.dark,
      primaryColorDark: Colors.black,
    floatingActionButtonTheme: FloatingActionButtonThemeData(backgroundColor: color.bgcolor)

  );
  final lightTheme = ThemeData(
      primaryColor: Colors.white,
      brightness: Brightness.light,
      primaryColorDark: Colors.white,
    floatingActionButtonTheme: FloatingActionButtonThemeData(backgroundColor: Colors.red)
  );

  changeTheme(){

    _isdark =  !isDark;
    notifyListeners();
  }

  init(){
    notifyListeners();
  }

}
// import 'package:flutter/material.dart';

// class AppThemes {
//   static final ThemeData lightTheme = ThemeData(
//     brightness: Brightness.light,
//     primarySwatch: Colors.blue,
//     appBarTheme: AppBarTheme(
//       backgroundColor: Colors.white,
//       titleTextStyle: TextStyle(color: Colors.black, fontSize: 20),
//       iconTheme: IconThemeData(color: Colors.black),
//     ),
//     scaffoldBackgroundColor: Colors.white,
//     floatingActionButtonTheme: FloatingActionButtonThemeData(
//       backgroundColor: Colors.blue,
//     ),
//     textTheme: TextTheme(
//       bodyLarge: TextStyle(color: Colors.black),
//       bodyMedium: TextStyle(color: Colors.black),
//       bodySmall: TextStyle(color: Colors.black),
//     ),
//   );
//
//   static final ThemeData darkTheme = ThemeData(
//     brightness: Brightness.dark,
//     primarySwatch: Colors.blue,
//     appBarTheme: AppBarTheme(
//       backgroundColor: Colors.white,
//       titleTextStyle: TextStyle(color: Colors.white, fontSize: 20),
//       iconTheme: IconThemeData(color: Colors.white),
//     ),
//     scaffoldBackgroundColor: Colors.black,
//     floatingActionButtonTheme: FloatingActionButtonThemeData(
//       backgroundColor: Colors.blue,
//     ),
//     textTheme: TextTheme(
//       bodyLarge: TextStyle(color: Colors.white),
//       bodyMedium: TextStyle(color: Colors.white),
//       bodySmall: TextStyle(color: Colors.white),
//     ),
//   );
// }
