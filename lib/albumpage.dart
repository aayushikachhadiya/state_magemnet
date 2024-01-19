import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:on_audio_query/on_audio_query.dart';
import 'package:on_audio_query_platform_interface/src/models/album_model.dart';
import 'package:untitled1/controller.dart';

class albumpage extends StatelessWidget {
  AlbumModel l;
   albumpage(this.l);

  @override
  Widget build(BuildContext context) {
    controller c=Get.put(controller());
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
      ),
      body: FutureBuilder(future: c.getallsong(l.id) ,builder: (context, snapshot) {
        if(snapshot.connectionState==ConnectionState.done)
          {
            List<SongModel> l=snapshot.data as  List<SongModel>;
            return ListView.builder(itemCount:l.length,itemBuilder: (context, index) {
              return Card(
                child: ListTile(
                  onTap: () {
                    c.islpyar.value=true;
                    for(int i=0;i<c.song_list.length;i++)
                      {
                        if(c.song_list.value[i].id==l[index].id)
                          {
                            print(c.song_list[i].id);
                            print(l[index].id);
                            if(i==c.cur_ind.value)
                              {

                              }else
                                {
                                  c.cur_ind.value=i;
                                  controller.player.play(DeviceFileSource(c.song_list.value[c.cur_ind.value].data));
                                }
                          }
                      }
                  },
                  title: Text("${l[index].title}"),
                  trailing: Wrap(children: [
                    Obx(() =>(c.song_list.value[index].albumId==l[index].album) &&
                        c.islpyar.value?
                    Image.network("https://i.pinimg.com/originals/cb/17/b8/cb17b80a942d7c317a35ff1324fae12f.gif",width: 40,height: 40)
                  :  Text("")),
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
