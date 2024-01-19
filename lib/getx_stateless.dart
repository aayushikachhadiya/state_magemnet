import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:untitled1/sumclass.dart';

void main()
{
  runApp(MaterialApp(home: getx(),debugShowCheckedModeBanner: false,));
}
class getx extends StatelessWidget {
  const getx({super.key});

  @override
  Widget build(BuildContext context) {
    sumclass s=Get.put(sumclass());
    TextEditingController t1=TextEditingController();
    TextEditingController t2=TextEditingController();
    return Scaffold(
      appBar: AppBar(),
      body: Column(children: [
        TextField(
          controller: t1,
        ),
        TextField(
          controller: t2,
        ),
        ElevatedButton(onPressed: () {

          s.fun_sum(t1.text, t2.text);
        }, child: Text("Submit")),
       Obx(() {
         return  Text("Sum=${s.sum.value}");
       })
      ]),
    );
  }
}
