
import 'package:flutter/material.dart';

class logic extends ChangeNotifier
{
  int cnt=0;
  String wins="";
  List l=List.filled(9, "");
  get(int i)
  {
    if(wins=="") {
      if (l[i] == "") {
        if (cnt % 2 == 0) {
          l[i] = 'x';
        } else {
          l[i] = 'o';
        }
        cnt++;
      }
      win();
    }
      notifyListeners();
    }
  win()
  {
    if(l[0]=="x" && l[1]=="x" && l[2]=="x"||
        l[3]=="x" && l[4]=="x" && l[5]=="x"||
        l[6]=="x" && l[7]=="x" && l[8]=="x"||
        l[0]=="x" && l[3]=="x" && l[6]=="x"||
        l[1]=="x" && l[4]=="x" && l[7]=="x"||
        l[2]=="x" && l[5]=="x" && l[8]=="x"||
        l[0]=="x" && l[4]=="x" && l[8]=="x"||
        l[2]=="x" && l[4]=="x" && l[8]=="x")
    {

      wins="x is win";
    }else     if(l[0]=="o" && l[1]=="o" && l[2]=="o"||
        l[3]=="o" && l[4]=="o" && l[5]=="o"||
        l[6]=="o" && l[7]=="o" && l[8]=="o"||
        l[0]=="o" && l[3]=="o" && l[6]=="o"||
        l[1]=="o" && l[4]=="o" && l[7]=="o"||
        l[2]=="o" && l[5]=="o" && l[8]=="o"||
        l[0]=="o" && l[4]=="o" && l[8]=="o"||
        l[2]=="o" && l[4]=="o" && l[8]=="o")
    {
      wins="o is win";
    }
    notifyListeners();
  }
  reset()
  {
    for(int i=0;i<l.length;i++)
    {
      l[i]="";
      wins="";
    }
    notifyListeners();
  }
  }

