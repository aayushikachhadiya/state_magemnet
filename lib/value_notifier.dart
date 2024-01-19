import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

void main()
{
  runApp(MaterialApp(home: value_notifier(),debugShowCheckedModeBanner: false,));
}
class value_notifier extends StatelessWidget {
  const value_notifier({super.key});

  @override
  Widget build(BuildContext context) {
    TextEditingController  t1=new TextEditingController();
    TextEditingController t2=new TextEditingController();
    ValueNotifier <int> sum= ValueNotifier(0);
    return Scaffold(
      appBar: AppBar(title: Text("Value Notifer")),
      body: Column(children: [
        TextField(
          controller: t1,
        ),
        TextField(
          controller: t2,
        ),
        ElevatedButton(onPressed: () {
          sum.value=int.parse(t1.text)+int.parse(t2.text);
        }, child: Text("Submit")),
        ValueListenableBuilder(valueListenable: sum, builder: (context, value, child) {
          return Text("Sum=${sum.value}");
        },)
      ]),
    );
  }
}
