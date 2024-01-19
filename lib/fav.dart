import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:on_audio_room/details/rooms/favorites/favorites_entity.dart';
import 'package:on_audio_room/on_audio_room.dart';
import 'package:untitled1/controller.dart';

class fav extends StatelessWidget {
  const fav({super.key});

  @override
  Widget build(BuildContext context) {
    controller c=Get.put(controller());
    return Scaffold(
      appBar: AppBar(backgroundColor: Colors.black,),
      body: FutureBuilder(future: c.get_fav(),builder: (context, snapshot) {
        if(snapshot.connectionState==ConnectionState.done)
          {
            List<FavoritesEntity> list=snapshot.data as  List<FavoritesEntity>;
            return ListView.builder(itemCount: list.length,itemBuilder: (context, index) {
              return Card(
                child: ListTile(
                  onTap: () {
                    for(int i=0;i<c.song_list.length;i++)
                    {
                      if(c.song_list.value[i].id==list[index].id)
                      {
                        print(c.song_list[i].id);
                        print(list[index].id);
                        if(i==c.cur_ind.value)
                        {
                          showModalBottomSheet(isScrollControlled: true,context: context, builder: (context) {
                            return Container(
                              // height: h-app_bar,
                              color: Colors.black87,
                              child: Column(children: [
                                Container(
                                  margin: EdgeInsets.all(10),
                                  width: 300,
                                  height: 300,
                                  decoration: BoxDecoration(  color: Colors.black54,borderRadius: BorderRadius.circular(20)),
                                  child: IconButton(onPressed: () {

                                  },icon: Icon(Icons.music_note,size: 200,color: Colors.grey,)),
                                ),
                                Container(
                                  child: StatefulBuilder(
                                    builder: (context, setState1) {
                                      return Obx(() => Slider(
                                        activeColor: Colors.red,
                                        inactiveColor: Colors.black,
                                        min: 0,
                                        max: c.song_list.value.length>0?c.song_list.value[c.cur_ind.value].duration!.toDouble():0,
                                        value: c.duration.value,
                                        onChanged: (value) {},
                                      ));
                                    },
                                  ),
                                ),
                                Expanded(child: Container(
                                    alignment: Alignment.center,
                                    child: Obx(() => Text("${list[index].title}",style: TextStyle(fontSize: 20,color: Colors.white)),)
                                )),
                                Expanded(
                                    child: Row(mainAxisAlignment: MainAxisAlignment.spaceEvenly,children: [
                                      Expanded(child: Container(
                                        child:      IconButton(onPressed: () {
                                          if(c.cur_ind.value>0)
                                          {
                                            c.cur_ind.value--;
                                            c.islpyar.value=true;
                                            controller.player.play(DeviceFileSource(c.song_list.value[c.cur_ind.value].data));
                                          }

                                        }, icon: Icon(Icons.skip_previous,color: Colors.red,size: 60,)),
                                      )),
                                      Obx(() =>Expanded(child: Container(
                                        child:  c.islpyar.value?IconButton(onPressed: () {
                                          controller.player.pause();
                                          c.islpyar.value=!c.islpyar.value;
                                        }, icon: Icon(Icons.pause,color: Colors.red,size: 60)):IconButton(onPressed: () {
                                          c.islpyar.value=!c.islpyar.value;
                                          controller.player.play(DeviceFileSource(c.song_list.value[c.cur_ind.value].data));
                                        }, icon: Icon(Icons.play_arrow,color: Colors.red,size: 60,)),
                                      ))),
                                      Expanded(child: Container(
                                        child:    IconButton(onPressed: () {
                                          if(c.cur_ind.value<c.song_list.length-1)
                                          {
                                            c.cur_ind.value++;
                                            c.islpyar.value=true;
                                            controller.player.play(DeviceFileSource(c.song_list.value[c.cur_ind.value].data));
                                          }
                                        }, icon: Icon(Icons.skip_next,color: Colors.red,size: 60,)),
                                      ))
                                    ],)
                                ),
                                Expanded(child: Text("")),
                                Expanded(child: Row(mainAxisAlignment: MainAxisAlignment.spaceEvenly,children: [
                                  Expanded(child: Container(
                                    child: IconButton(onPressed: () {

                                    },icon: Icon(Icons.menu,color: Colors.white,)),
                                  )),
                                  Expanded(child: Container(
                                      child: Obx(() => c.fav.value?IconButton(onPressed: () async {
                                        bool deleteFromResult = await OnAudioRoom().deleteFrom(
                                            RoomType.FAVORITES,
                                            c.song_list.value[c.cur_ind.value].id
                                          //playlistKey,
                                        );
                                        c.get_chack();
                                      },icon: Icon(Icons.favorite,color: Colors.white,)):
                                      IconButton(onPressed: () async {
                                        int? addToResult = await OnAudioRoom().addTo(
                                            RoomType.FAVORITES,
                                            c.song_list.value[c.cur_ind.value].getMap.toFavoritesEntity()
                                        );
                                        c.get_chack();
                                      },icon: Icon(Icons.favorite_border,color: Colors.white,)),)
                                  )),
                                  Expanded(child: Container(
                                    child: IconButton(onPressed: () {

                                    },icon: Icon(Icons.autorenew_sharp,color: Colors.white,)),
                                  )),
                                  Expanded(child: Container(
                                    child: IconButton(onPressed: () {

                                    },icon: Icon(Icons.more_horiz,color: Colors.white,)),
                                  ))
                                ],))
                              ]),
                            );
                          },);
                          c.get_chack();
                        }else
                        {
                          c.cur_ind.value=i;
                          controller.player.play(DeviceFileSource(c.song_list.value[c.cur_ind.value].data));
                        }
                      }
                    }

                  },
                  title: Text("${list[index].title}"),
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
