import 'dart:io';
import 'dart:ui';
import 'package:keep_note_clone/page/createnote.dart';
import 'package:painter/painter.dart';
import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';
import 'package:uuid/uuid.dart';
import '../color.dart';

// class Drawing extends StatefulWidget {
//    Drawing({super.key });
//
//   @override
//   State<Drawing> createState() => _DrawingState();
// }
//
// class _DrawingState extends State<Drawing> {
//
//   final _sketch = SketchController();
//   final _scroll = ScrollController();
//
//
//   @override
//   void initState() {
//     _sketch.addListener((){
//       setState(() {
//
//       });
//     });
//     super.initState();
//   }
//
//   Widget _buildSketch(){
//     return Sketch(controller: _sketch, scrollController: _scroll);
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text("Drawing"),
//       ),
//       body: Stack(
//         fit: StackFit.expand,
//         children: [
//           _buildSketch(),
//           Center(
//             child: Text(""),
//           ),
//           Positioned(
//             left: 0,
//             right: 0,
//             bottom: 0,
//             child: Material(
//               elevation: 5.0,
//               child: Row(
//                 children: [
//                   IconButton(onPressed: ()=> _sketch.setActiveTool(
//                     SketchTool.pencil
//                   ), icon: Icon(Icons.edit)),
//                   IconButton(onPressed: ()=> _sketch.setActiveTool(
//                       SketchTool.eraser
//                   ), icon: Icon(Icons.delete_outline_outlined)),
//                   IconButton(onPressed: ()=> _sketch.setActiveTool(
//                       SketchTool.highlighter
//                   ), icon: Icon(Icons.highlight)),
//                   IconButton(onPressed: ()=> _sketch.setActiveColor(
//                     Colors.red
//                   ), icon: Icon(Icons.palette,color: Colors.red,)),
//                   IconButton(onPressed: ()=> _sketch.setActiveColor(
//                       Colors.blue
//                   ), icon: Icon(Icons.palette,color: Colors.blue,)),
//                 ],
//               ),
//             ),
//           )
//         ],
//       ),
//     );
//   }
// }

// class DrawingScreen extends StatefulWidget {
//   @override
//   _DrawingScreenState createState() => _DrawingScreenState();
// }
//
// class _DrawingScreenState extends State<DrawingScreen> {
//   late PainterController _controller;
//
//   @override
//   void initState() {
//     super.initState();
//     _controller = _newController();
//   }
//
//   PainterController _newController() {
//     PainterController controller = PainterController();
//     controller.thickness = 5.0;
//     controller.backgroundColor = Colors.white;
//     return controller;
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Drawing Note'),
//         // actions: <Widget>[
//         //   IconButton(
//         //     icon: Icon(Icons.save),
//         //     onPressed: () async {
//         //       // Here you can save the drawn image
//         //       final picture = _controller.finish();
//         //       // Save or use the image here.
//         //     },
//         //   )
//         // ],
//       ),
//       body: Center(
//         child: Painter(_controller),
//       ),
//       floatingActionButton: FloatingActionButton(
//         onPressed: () {
//           setState(() {
//             _controller = _newController();
//           });
//         },
//         child: Icon(Icons.clear),
//       ),
//     );
//   }
// }

class DrawingPage extends StatefulWidget {


  @override
  _DrawingPageState createState() => _DrawingPageState();
}

class _DrawingPageState extends State<DrawingPage> {
  late PainterController _controller;
  Color _selectedColor = Colors.black;


  @override
  void initState() {
    super.initState();
    _controller = _newController();
  }

  PainterController _newController() {
    PainterController controller = PainterController();
    controller.thickness = 5.0;
    controller.backgroundColor = Colors.white;
    controller.drawColor = _selectedColor;
    return controller;
  }

  void _onColorSelected(Color color) {
    setState(() {
      _selectedColor = color;
      _controller.drawColor = color;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // backgroundColor: color.bgcolor,
      appBar: AppBar(
        // backgroundColor: color.bgcolor,
        // iconTheme: IconThemeData(color: color.white),
        title: Text('Drawing Note',
          // style: TextStyle(color: color.white),
        ),
        actions: [
          IconButton(
            icon: Icon(Icons.save),
            onPressed: (){
              _saveAsImage();

            },
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10 ,vertical: 10),
        child: Column(
          children: [
            Expanded(
              child: Painter(_controller),
            ),
            // SizedBox(height: 10),
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                children: [
                  _buildColorPicker(),
                  IconButton(
                    // color: color.white,
                    icon: Icon(Icons.format_bold),
                    onPressed: _toggleBold,  // Function to toggle bold strokes
                  ),
                  IconButton(
                    // color: color.white,
                    icon: Icon(Icons.undo),
                    onPressed: () {
                      if (_controller.isEmpty) {
                        showModalBottomSheet(
                            context: context,
                            builder: (context) => Text("Nothing to undo"));
                      } else {
                        _controller.undo();
                      }
                    },
                  ),
                  IconButton(
                    // color: color.white,
                    icon: Icon(Icons.clear),
                    onPressed: () => _controller.clear(),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),

    );
  }

  Widget _buildColorPicker() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        _colorButton(Colors.black),
        _colorButton(Colors.red),
        _colorButton(Colors.blue),
        _colorButton(Colors.green),
        _colorButton(Colors.yellow),
      ],
    );
  }

  void _saveAsImage() async {
    var uuid = Uuid();
    // Render the drawing into an image
    final picture = _controller.finish(); // Complete the drawing
    final image = await picture.toImage(); // Convert it to an image with size
    final byteData = await image.toByteData(format: ImageByteFormat.png);
    final pngBytes = byteData?.buffer.asUint8List();

    // Save the PNG bytes to a file or do further processing
    final directory = await getApplicationDocumentsDirectory();
    final filePath = '${directory.path}/${uuid.v1()}.png';
    final file = File(filePath);
    await file.writeAsBytes(pngBytes!);
    print('Image saved to $filePath');
    Navigator.push(context, MaterialPageRoute(builder: (_)=>Createnote(file: file,)));

    setState(() {
      _controller = _newController(); // Reset the controller after saving
    });

    // Example: Displaying a confirmation dialog
    // showDialog(
    //   context: context,
    //   builder: (context) {
    //     return AlertDialog(
    //       content: Text('Drawing saved as PNG image.'),
    //     );
    //   },
    //
    // );
  }
  Widget _colorButton(Color color) {
    return GestureDetector(
      onTap: () => _onColorSelected(color),
      child: Container(
        margin: EdgeInsets.all(8.0),
        width: 40,
        height: 40,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: color,
          border: Border.all(
            color: _selectedColor == color  ? Colors.black : Colors.white,
            width: 3,
          ),
        ),
      ),
    );
  }

  void _toggleBold() {
    setState(() {
      if (_controller.thickness == 5.0) {
        _controller.thickness = 10.0;
      } else if(_controller.thickness == 10.0){
        _controller.thickness = 15.0;
      } else if(_controller.thickness == 15.0){
        _controller.thickness = 20.0;
      } else if(_controller.thickness == 20.0){
        _controller.thickness = 25.0;
      }else if(_controller.thickness == 25.0){
        _controller.thickness = 45.0;
      }
      else {
        _controller.thickness = 5.0;
      }
    });
  }
}
