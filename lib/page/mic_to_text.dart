
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:speech_to_text/speech_to_text.dart';

class MicToText extends StatefulWidget {
  const MicToText({super.key});

  @override
  State<MicToText> createState() => _MicToTextState();
}

class _MicToTextState extends State<MicToText> {

  void checMic()async{
    bool micAvailable = await speechToText.initialize();
    if(micAvailable){
      print("Mic avilable");
    }else{
      print("user denide to speech mic");
    }
  }

  SpeechToText speechToText = SpeechToText();
  var isListening = false;
  var textspeech = "Click mic to record";
  @override
  void initState() {
    super.initState();
    checMic();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: SingleChildScrollView(
          child: Column(
            children: [
              Text(textspeech),
              GestureDetector(
                onTap: ()async{
                  if(!isListening){
                    bool micAvailable = await speechToText.initialize();
                    if(micAvailable){
                      setState(() {
                        isListening = true;
                      });
                      speechToText.listen(
                         listenFor: Duration(seconds: 20),
                        onResult: (result){
                          setState(() {
                            textspeech = result.recognizedWords;
                            isListening = false;
                          });
                        }
                      );
                    }
                  }else{
                    setState(() {
                      isListening = false;
                      speechToText.stop();
                    });
                  }
                },
                child: CircleAvatar(
                  child: isListening ? Icon(Icons.record_voice_over) : Icon(Icons.mic),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
