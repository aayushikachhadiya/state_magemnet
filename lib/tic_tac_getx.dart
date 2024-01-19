import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:untitled1/tictac.dart';

void main() {
  runApp(GetMaterialApp(
    debugShowCheckedModeBanner: false,
    home: TicTacToe(),
  ));
}

class TicTacToe extends StatelessWidget {
  tictac l=Get.put(tictac());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("TicTacToe"),
      ),
      body: Column(children: [
        Expanded(child: Text("")),
        Expanded(child: Container(
          height: double.infinity,
          width: double.infinity,
          alignment: Alignment.center,
          color: Colors.grey,
          child:Obx(() =>  Text("${l.wins}",style: TextStyle(fontSize: 30)),)
        )),
        Expanded(child: Text("")),
        Expanded(child: Row(children: [
          button(0),
          button(1),
          button(2),
        ],)),
        Expanded(child: Row(children: [
          button(3),
          button(4),
          button(5),
        ],)),
        Expanded(child: Row(children: [
          button(6),
          button(7),
          button(8),
        ],)),
        reset()
      ]),
    );
  }
  button(int i)
  {
    return Expanded(child: InkWell(onTap: () {
      l.get(i);
    },
      child: Container(
        margin: EdgeInsets.all(5),
        alignment: Alignment.center,
        height: double.infinity,
        width: double.infinity,
        color: Colors.grey,
        child: Obx(() => Text("${l.l[i]}",style: TextStyle(fontSize: 30),)),
      ),
    ));
  }
  reset()
  {
    return ElevatedButton(onPressed: () {
      l.reset();
    }, child: Text("reset"));
  }
}
