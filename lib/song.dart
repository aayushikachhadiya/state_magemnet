import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:on_audio_query/on_audio_query.dart';

import 'controller.dart';

class song extends StatefulWidget {
  const song({super.key});

  @override
  State<song> createState() => _songState();
}

class _songState extends State<song> {
  @override
  Widget build(BuildContext context) {
    print("Good");
    controller c=Get.put(controller());
    return Scaffold(
      backgroundColor: Colors.black,
      body: FutureBuilder(future: c.get_song(),builder: (context, snapshot) {
        if(snapshot.connectionState==ConnectionState.done)
        {
          print("hello");
          List<SongModel> l=snapshot.data as List<SongModel>;
          return ListView.builder(itemCount: l.length,itemBuilder: (context, index) {
            return Card(color: Colors.black,
              shadowColor: Colors.white,
              child: ListTile(
                onTap: () {
                  c.get_duration();
                  c.islpyar.value=true;
                  if(c.cur_ind.value==index)
                    {

                    }else
                      {
                        c.cur_ind.value=index;
                        controller.player.play(DeviceFileSource(c.song_list.value[c.cur_ind.value].data));
                      }
                },
                title: Text("${l[index].title}",style: TextStyle(color: Colors.red)),
                subtitle: Text("${l[index].artist}",style: TextStyle(color: Colors.red)),
                trailing: Wrap(children: [
                  Obx(() => c.cur_ind==index &&
                      c.islpyar.value?
                  Image.network("https://i.pinimg.com/originals/cb/17/b8/cb17b80a942d7c317a35ff1324fae12f.gif",width: 40,height: 40):Text(""))
                ]),
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
