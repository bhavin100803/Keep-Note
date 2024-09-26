// import 'package:flutter/material.dart';
// import 'package:share_plus/share_plus.dart';
//
// class ShareTextExample extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Share Text Example'),
//       ),
//       body: Center(
//         child: ElevatedButton(
//           onPressed: () {
//             // The text to share
//             String textToShare = "Check out this cool Flutter app!";
//
//             // Share the text
//             Share.share(textToShare);
//           },
//           child: Text('Share Text'),
//         ),
//       ),
//     );
//   }
// }
//
//
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:share_plus/share_plus.dart';

class ShareTextExample extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text('Share Text Example'),
        ),
        body: Center(
          child: ElevatedButton(
            onPressed: () {
              _shareText();
            },
            child: Text('Share Text'),
          ),
        ),
      ),
    );
  }

  void _shareText() {
    Share.share('Check out this cool app!', subject: 'Look at this!');
  }
}