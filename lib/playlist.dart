import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:on_audio_room/details/rooms/favorites/favorites_entity.dart';
import 'package:on_audio_room/on_audio_room.dart';
import 'package:untitled1/controller.dart';

import 'fav.dart';

class playlist extends StatefulWidget {
  const playlist({super.key});

  @override
  State<playlist> createState() => _playlistState();
}

class _playlistState extends State<playlist> {
  @override
  Widget build(BuildContext context) {
    controller c=Get.put(controller());
    return Scaffold(

      body: FutureBuilder(future: c.get_fav(),builder: (context, snapshot) {
        if(snapshot.connectionState==ConnectionState.done)
          {
            List<FavoritesEntity> list=snapshot.data as  List<FavoritesEntity>;

              return ListTile(
                onTap: () {
                  c.get_chack();
                  Navigator.push(context, MaterialPageRoute(builder: (context) {
                    return fav();
                  },));

                },
              title: Text("Song"),
              subtitle: Text("${list.length}"),
              );
          }else
            {
              return CircularProgressIndicator();
            }
      },),
    );
  }
}
