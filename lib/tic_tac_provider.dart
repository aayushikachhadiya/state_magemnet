import 'dart:js';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:untitled1/logic_tic.dart';

void main()
{
  runApp(MaterialApp(home: MultiProvider(providers: [
    ChangeNotifierProvider(create: (context) => logic(),)
  ],
    child: tic_tac(),
  ),

  )
  );
}
class tic_tac extends StatelessWidget {
  // const tic_tac({super.key});

  @override
  Widget build(BuildContext context) {
    logic m=Provider.of(context);
    return Scaffold(
      appBar: AppBar(title: Text("Tic tac"),),
      body: Column(children: [
        Expanded(child: Container(
            height: double.infinity,
            width: double.infinity,
            alignment: Alignment.center,
            color: Colors.grey,
            child: Text("${m.wins}",style: TextStyle(fontSize: 30)),
        )),
        Expanded(child: Row(children: [
          button(context,m,0),
          button(context,m,1),
          button(context,m,2),
          
        ],)),
        Expanded(child: Row(children: [
          button(context,m,3),
          button(context,m,4),
          button(context,m,5),
        ],)),
        Expanded(child: Row(children: [
          button(context,m,6),
          button(context,m,7),
          button(context,m,8),
        ],)),
        reset(context,m),
      ]),
    );
  }
  button(BuildContext context ,logic  m,int i)
  {
    return Expanded(child: InkWell(
        onTap: () {
               m.get(i);
        },
      child: Container(
        margin: EdgeInsets.all(5),
        alignment: Alignment.center,
        height: double.infinity,
        width: double.infinity,
        color: Colors.grey,
         child: Text("${m.l[i]}"),
      ),
    ));
  }
  reset(BuildContext context,logic m)
  {
    return ElevatedButton(onPressed: () {
      m.reset();
    }, child: Text("reset"));
  }
}
