import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:on_audio_query/on_audio_query.dart';
import 'package:untitled1/controller.dart';

import 'albumpage.dart';

class albums extends StatefulWidget {
  const albums({super.key});

  @override
  State<albums> createState() => _albumsState();
}

class _albumsState extends State<albums> {
  @override
  Widget build(BuildContext context) {
    controller c=Get.put(controller());
    return Scaffold(
      backgroundColor: Colors.black,
      body: FutureBuilder(future: c.get_album(),builder: (context, snapshot) {
        if(snapshot.connectionState==ConnectionState.done)
        {
          print("hello");
          List<AlbumModel> l=snapshot.data as List<AlbumModel>;
          return ListView.builder(itemCount: l.length,itemBuilder: (context, index) {
            return Card(color: Colors.black,
              shadowColor: Colors.white,
              child: ListTile(
                onTap: () {
                  Navigator.push(context, MaterialPageRoute(builder: (context) {
                    return albumpage(l[index]);
                  },));
                },
                title: Text("${l[index].album}",style: TextStyle(color: Colors.red)),
                subtitle: Text("${l[index].numOfSongs}",style: TextStyle(color: Colors.red)),
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
