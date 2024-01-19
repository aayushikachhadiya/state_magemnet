import 'package:get/get.dart';

class sumclass extends GetxController
{

  int s1=0,s2=0;
  RxInt sum=0.obs;
    fun_sum(String a,String b)
    {

      s1=int.parse(a);
      s2=int.parse(b);

      sum.value=s1+s2;
    }
}
