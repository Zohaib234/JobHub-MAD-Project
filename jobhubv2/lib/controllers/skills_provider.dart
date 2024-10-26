import 'package:flutter/material.dart';

class SkillsNotifier extends ChangeNotifier {


  bool skills = false;
  bool get getskills => skills;
  
  set setskills(bool value) {
    skills = value;
    notifyListeners();
  }

  String skillsId = "";
  
  String get getskillsId => skillsId;

  set setskillsId(String value) {
    skillsId = value;
    notifyListeners();
  }

  String logo = "";
  
  String get getlogo => logo;

  void setlogo(String value) {
    logo = value;
    notifyListeners();
  }


  
}