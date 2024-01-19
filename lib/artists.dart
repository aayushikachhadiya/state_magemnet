import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:on_audio_query/on_audio_query.dart';
import 'package:on_audio_room/on_audio_room.dart';
import 'package:untitled1/controller.dart';
import 'package:untitled1/song.dart';

class artists extends StatefulWidget {
  const artists({super.key});

  @override
  State<artists> createState() => _artistsState();
}
class _artistsState extends State<artists> {
  @override
  Widget build(BuildContext context) {
    controller c=Get.put(controller());
    return Scaffold(
      backgroundColor: Colors.black,
      body: FutureBuilder(future: c.get_artist(),builder: (context, snapshot) {
        if(snapshot.connectionState==ConnectionState.done)
        {
          print("hello");
          List<ArtistModel> l=snapshot.data as List<ArtistModel>;
          return ListView.builder(itemCount: l.length,itemBuilder: (context, index) {
            return Card(color: Colors.black,
              shadowColor: Colors.white,
              child: ListTile(onTap: () {
                Navigator.push(context, MaterialPageRoute(builder: (context) {
                  return song();
                },));
              },
                title: Text("${l[index].artist}",style: TextStyle(color: Colors.red)),
              ),
            );
          },);
        }else
        {
          return CircularProgressIndicator();
        }
      },),
    );
  }
}
