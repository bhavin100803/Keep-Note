import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:keep_note_clone/color.dart';
import 'package:keep_note_clone/services/login_info.dart';
import 'package:keep_note_clone/theme.dart';
import 'package:provider/provider.dart';

class Setting extends StatefulWidget {
  const Setting({super.key});

  @override
  State<Setting> createState() => _SettingState();
}

class _SettingState extends State<Setting> {
 bool? value;
  getSync()async{
    LocalDataSaver.getSync().then((valuefromdb){
      setState(() {
        value = valuefromdb!;
      });
    });
  }
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getSync();
  }
  @override
  Widget build(BuildContext context) {
    var theme = context.watch<UiProvider>();
    return Scaffold(
      // backgroundColor: color.bgcolor,
      appBar: AppBar(
        // foregroundColor: color.white,
        // backgroundColor: color.bgcolor,elevation: 0.0,
        title: Text("Settings"),
      ),
      body:Consumer<UiProvider>(
          builder: (context , UiProvider notifier,child) {
            return Column(
              children: [
                ListTile(
                  // leading: Icon(Icons.dark_mode),
                  title: Text("Dark Mode"),
                  trailing: Switch(
                      value: notifier.isDark,
                      onChanged: (value)=>theme.changeTheme()
                  ),
                ),
                Container(
                  padding: EdgeInsets.all(20),
                  child: Column(
                    children: [
                      Row(
                        children: [
                          Text("Sync",style: TextStyle(fontSize: 18),),
                          Spacer(),
                          Transform.scale(scale: 1.1,
                        child:  Switch.adaptive(value: value!, onChanged: (switchvalue){
                            setState(() {
                              this.value = switchvalue;
                              LocalDataSaver.saveSync(switchvalue);
                              print(switchvalue);
                            });
                          }),)
                        ],
                      )
                    ],
                  ),
                ),
              ],

            );
          }
      ),

    );
  }
}
