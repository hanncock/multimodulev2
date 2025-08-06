import 'package:flutter/material.dart';
import 'package:get/get.dart';

class Controller extends GetxController with GetTickerProviderStateMixin{

  final String moduleName;
  Controller(this.moduleName);

  var selectedModule = ''.obs;

  var selectedSubScreen = ''.obs;
  Map <String, Widget> mainModules = {};

  void addModule(String moduleName, Widget module){

    if(mainModules.containsKey(moduleName)){
      switchTo(moduleName);
    }else{
      mainModules[moduleName] = module;
      update();
      switchTo(moduleName);
    }

  }

  void switchTo(moduleName){
    selectedModule.value = moduleName;
    update();
  }

  void removeTab(String elmKey){

    if(mainModules.containsKey(elmKey)){
      mainModules.remove(elmKey);
    }else{}
    update();


  }

}
