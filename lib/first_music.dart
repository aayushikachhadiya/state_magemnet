import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:on_audio_room/on_audio_room.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:untitled1/music.dart';

import 'controller.dart';

Future<void> main() async {
  await OnAudioRoom().initRoom();
  runApp(GetMaterialApp(
    home: first(),
    debugShowCheckedModeBanner: false,
  ));
}

class first extends StatefulWidget {
  const first({super.key});

  @override
  State<first> createState() => _firstState();
}

class _firstState extends State<first> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    permission();
    Future.delayed(Duration(seconds: 3)).then((value) {
      Navigator.push(context, MaterialPageRoute(
        builder: (context) {
          return music();
        },
      ));
    });
  }

  permission() async {
    var status = await Permission.storage.status;
    if (status.isDenied) {
      Map<Permission, PermissionStatus> statuses = await [
        Permission.location,
        Permission.storage,
      ].request();
    }
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        title: Text("Music Player"),
        backgroundColor: Colors.white,
      ),

      backgroundColor: Colors.black,
      body: Container(
        alignment: Alignment.center,
        height: double.infinity,
        width: double.infinity,
        child: Text("Music Player",
            style: TextStyle(fontSize: 30, color: Colors.red)),
      ),
    );
  }
}
