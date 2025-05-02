import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../allmodules.dart';


class Controller extends GetxController with GetTickerProviderStateMixin{

  final selectedModule = ''.obs;
  final selectedScreen = Rx<Widget?>(null);
  final selectedsubScreen = Rx<Widget?>(null);


  final moduleMenus = <String, Map<String, Widget>>{
    "Home": {"HomeDash": MainModules()},
  }.obs;

  late TabController tabController;


  @override
  void onInit() {
    super.onInit();

    // Set initial screen from first module
    if (moduleMenus.isNotEmpty) {
      final firstModule = moduleMenus.keys.first;
      final firstScreen = moduleMenus[firstModule]!.keys.first;

      selectedModule.value = firstModule;
      selectedScreen.value = moduleMenus[firstModule]![firstScreen];

      _initializeTabController();
    }

    // Reinitialize tab controller if moduleMenus changes
    moduleMenus.listen((menus) {
      _initializeTabController();
    });
  }

  // late TabController tabController;

  void _initializeTabController() {
    // Initialize the tabController only when moduleMenus is not empty
    if (moduleMenus.isNotEmpty) {
      tabController = TabController(length: moduleMenus.length, vsync: this);
    }
  }

  void addModule(String moduleName, [Map<String, Widget>? screen] ){
    if(!moduleMenus.containsKey(moduleName)){
      print("not containing module");
      selectedModule.value = moduleName;
      moduleMenus[moduleName] = screen!;
      if(screen.isNotEmpty){
        selectedScreen.value = screen.values.first;
        selectedsubScreen.value = screen.values.first;
      }else{
        selectedsubScreen.value = moduleMenus[moduleName]!.values.first;
      }

    }else{
      print("contains menu thus switching to it");
      selectedModule.value = moduleName;
      selectedScreen.value = moduleMenus[moduleName]!.values.first;
      if(screen == null || screen.isEmpty){
        selectedsubScreen.value = moduleMenus[moduleName]!.values.first;
      }else{
        if(!moduleMenus[moduleName]!.containsKey(screen.keys.first)){
          print("not containing submenu");
          // moduleMenus[moduleName] = screen!;
          moduleMenus[moduleName]!.addAll({screen.keys.first : screen.values.first});

          selectedsubScreen.value = screen.values.first;
        }else{
          selectedsubScreen.value = screen.values.first;
        }
      }


    }
  }


/*  void addModule(String moduleName, [Map<String, Widget>? screns]) {
    if (!moduleMenus.containsKey(moduleName)) {
      if (screns == null || screns.isEmpty) {
        print('No screens provided to create module: $moduleName');
        return;
      }

      moduleMenus[moduleName] = screns;
      selectedModule.value = moduleName;
      // selectedScreen.value = screns.values.first;
      if (screns.isNotEmpty) {
        selectedScreen.value = screns.values.first;
      } else {
        // fallback to first existing screen
        selectedScreen.value = moduleMenus[moduleName]!.values.first;
      }

      print('Newly added module: $moduleName');
    } else {
      print('Switching to existing module: $moduleName');

      // If new screens are provided, try to add them
      if (screns != null && screns.isNotEmpty) {
        final existing = moduleMenus[moduleName]!;
        final newScreens = {
          for (var entry in screns.entries)
            if (!existing.containsKey(entry.key)) entry.key: entry.value
        };

        if (newScreens.isNotEmpty) {
          existing.addAll(newScreens);
          moduleMenus[moduleName] = existing; // Trigger reactivity
          print('Updated module $moduleName with new screens');
        } else {
          print('No new screens to add for $moduleName');
        }
      }

      // Always switch
      selectedModule.value = moduleName;
      selectedScreen.value = moduleMenus[moduleName]!.values.first;
    }

    print("Current module menus: $moduleMenus");
  }*/


/*void addModule(String moduleName, *//*Map<String, Widget>screns*//*[Map<String, Widget>? screns]) {
    if (!moduleMenus.containsKey(moduleName)) {
      moduleMenus[moduleName] = screns!;
      print('newly added module ${moduleName}');

    }else {
      print('will be switching');
      final existing = moduleMenus[moduleName]!;
      final newScreens = {
       for(var entry in screns!.entries)
         if (!existing.containsKey(entry.key)) entry.key: entry.value
      };

      if (newScreens.isNotEmpty) {
        existing.addAll(newScreens);
        moduleMenus[moduleName] = existing; // Trigger reactivity
        print('Updated module $moduleName with new screens');
      } else {
        print('No new screens to add for $moduleName');
      }
      selectedModule.value = moduleName;
      selectedScreen.value = moduleMenus[moduleName]!.values.first;


    }

    print("these are the ${moduleMenus}");

  }*/

}