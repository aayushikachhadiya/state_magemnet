import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';
import 'package:on_audio_room/on_audio_room.dart';
import 'package:untitled1/playlist.dart';
import 'package:untitled1/song.dart';

import 'albums.dart';
import 'artists.dart';
import 'controller.dart';

class music extends StatefulWidget {
  const music({super.key});

  @override
  State<music> createState() => _musicState();
}

class _musicState extends State<music> {
  @override
  Widget build(BuildContext context) {
    controller c = Get.put(controller());
    return DefaultTabController(length: 4, child: Scaffold(
      appBar: AppBar(
        backgroundColor:Colors.black,
        bottom: TabBar(dividerColor: Colors.black,indicatorColor: Colors.red,labelColor: Colors.red,tabs: [
          Tab(
            child: Text("Songs",style: TextStyle(color: Colors.white,fontSize: 15)),
          ),
          Tab(
            child: Text("Artists",style: TextStyle(color: Colors.white,fontSize: 15)),
          ),
          Tab(
            child: Text("Albums",style: TextStyle(color: Colors.white,fontSize: 15)),
          ),
          Tab(
            child: Text("Playlists",style: TextStyle(color: Colors.white,fontSize: 15)),
          )
        ]),
      ),
      bottomNavigationBar: Column(mainAxisSize: MainAxisSize.min,
          children: [
            ListTile(
              onTap: () {
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
                        child: Obx(() => Text("${c.song_list.value[c.cur_ind.value].title}",style: TextStyle(fontSize: 20,color: Colors.white)),)
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
              },
              title: Obx(() => Text("${c.song_list.value[c.cur_ind.value].title}",style: TextStyle(color: Colors.red),)),
              trailing: Obx(() => c.islpyar.value?IconButton(onPressed: () {
                controller.player.pause();
                c.islpyar.value=!c.islpyar.value;
              }, icon: Icon(Icons.pause,color: Colors.white,)):IconButton(onPressed: () {
                c.islpyar.value=!c.islpyar.value;
                controller.player.play(DeviceFileSource(c.song_list.value[c.cur_ind.value].data));
              }, icon: Icon(Icons.play_arrow,color: Colors.white,))),
            ),
        SliderTheme(
            data: SliderTheme.of(context)
                .copyWith(activeTrackColor: Colors.red, trackHeight: 2),
            child: Obx(() => Slider(
              min: 0,
              max: c.song_list.value.length>0?c.song_list.value[c.cur_ind.value].duration!.toDouble():0,
              value: c.duration.value,
              onChanged: (value) {},
            ))),

      ]),
      backgroundColor: Colors.black,
      body: TabBarView(children: [
        song(),
        artists(),
        albums(),
        playlist(),
      ]),
    ));
  }
}
