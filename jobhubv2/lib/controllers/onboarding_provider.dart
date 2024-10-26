import 'package:flutter/material.dart';

class OnBoardNotifier extends ChangeNotifier {
  
  bool _islastpage = false;

  bool get islastpage => _islastpage;
  
  set islastpage(bool newvalue){
    _islastpage=newvalue;
    notifyListeners();
  }

}
