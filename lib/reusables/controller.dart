import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../allmodules.dart';



class Controller extends GetxController with GetTickerProviderStateMixin{

  final String moduleName;
  Controller(this.moduleName);

  var selectedModule = ''.obs;
  var selectedSubScreen = ''.obs;
  Map <String, Widget> mainModules = {};
  // Map<String, Map<String, Widget>> mainModules = {};

  void addModule(String moduleName, Widget module){
    print("adding module ${moduleName}, ${module}");

    if(mainModules.containsKey(moduleName)){
      switchTo(moduleName);
    }else{
      mainModules[moduleName] = module;
      update();

    }

    // print(mainModules);

  }

  void switchTo(moduleName){
    selectedModule.value = moduleName;
    update();
  }

}
