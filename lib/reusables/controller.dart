import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../allmodules.dart';



class Controller extends GetxController with GetTickerProviderStateMixin{


  RxList<Map<String, Map<String, Widget>>> moduleMenus = <Map<String, Map<String, Widget>>>[
    {'AllModules':{"Module Dash" : MainModules()}},
  ].obs;

  RxList<Map<String, Map<String, Widget>>> lastSelectedSubMenus = <Map<String, Map<String, Widget>>>[
  ].obs;



  var selectedModule = ''.obs;
  var selectedScreen = Rx<Widget?>(null);
  var selectedSubModuleKey = ''.obs;


  late TabController tabController;

  @override
  void onInit(){
    super.onInit();

    if(moduleMenus.isNotEmpty){
      selectedModule.value = moduleMenus[0].keys.first;
      selectedSubModuleKey.value = moduleMenus[0][selectedModule.value]!.keys.first;
      selectedScreen.value = moduleMenus[0][selectedModule.value]![selectedSubModuleKey.value];
      lastSelectedSubMenus.add({selectedModule.value : {selectedSubModuleKey.value : selectedScreen.value!} });

      print("last selected ${lastSelectedSubMenus}");
      _initializeTabController();

    }

    ever(moduleMenus, (_) {
      _initializeTabController();
    });

  }

  void _initializeTabController() {
    // Initialize the tabController only when moduleMenus is not empty
    if (moduleMenus.isNotEmpty) {
      tabController = TabController(length: moduleMenus.length, vsync: this);
    }
  }



  void addMainModule(String moduleName, [Map<String ,Widget>? submodules]){
    print("before adding ${moduleMenus}");

    bool exists = moduleMenus.any((module) => module.containsKey(moduleName));

    if(!exists && submodules!= null && submodules.isNotEmpty){
      moduleMenus.add({moduleName : submodules});

      selectedModule.value = moduleName;
      selectedScreen.value = submodules.values.first;
      lastSelectedSubMenus.add({moduleName:submodules});

    }else{

      selectedModule.value= moduleName;
      selectedScreen.value = moduleMenus[moduleMenus.indexWhere((elem)=> elem.containsKey(moduleName))][selectedModule.value]!.values.first;
      bool exists = lastSelectedSubMenus.any((module) => module.containsKey(moduleName));
      if(exists){
        int index = lastSelectedSubMenus.indexWhere((elem)=> elem.containsKey(moduleName));
        print(lastSelectedSubMenus[index][selectedModule.value]!.values.first);
        selectedSubModuleKey.value = lastSelectedSubMenus[index][selectedModule.value]!.keys.first;
      }

    }
    print("after adding ${moduleMenus}");

    print("the selected module is${selectedModule.value}");
  }


  void addSubModule(Map<String ,Widget> submodules){


    print("module is ${submodules.keys}");

    int index = moduleMenus.indexWhere((elem)=> elem.containsKey(selectedModule.value));

    Map<String, Widget> existingSubmodules = moduleMenus[index][selectedModule.value]!;

    int indexed = lastSelectedSubMenus.indexWhere((elem)=> elem.containsKey(selectedModule.value));


    if(!existingSubmodules.containsKey(submodules.keys.first)){
      existingSubmodules[submodules.keys.first] = submodules.values.first;
      moduleMenus[index] = {selectedModule.value : existingSubmodules};
      lastSelectedSubMenus[indexed][selectedModule.value] = submodules;
    }else{

      // selectedSubModuleKey.value = submodules.keys.first;

    }

    selectedSubModuleKey.value = submodules.keys.first;

  }


  Widget getCurrentWidget(){

    int index = moduleMenus.indexWhere((elem) => elem.containsKey(selectedModule.value));
    return moduleMenus[index][selectedModule.value]![selectedSubModuleKey.value] ?? Text('no data to show');

  }


}




/*
class Controller extends GetxController with GetTickerProviderStateMixin{

  var selectedModule = ''.obs;
  var selectedScreen = Rx<Widget?>(null);
  // final selectedsubScreen = Rx<Widget?>(null);

  // Widget selectedScreen = Container();
  // Widget selectedSubScreen = Container(child: Text('Sub screen'),);
  var selectedSubScreenKey = ''.obs;

  final lastSelectedSubMenus = <String, Map<String, Widget>>{}.obs; // moduleName -> submenuKey


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
      selectedScreen.value = moduleMenus[firstModule]![firstScreen]!;
      // selectedSubScreenKey.value = moduleMenus[moduleMenus.keys.first]!.keys.first;
      // print("initial screen is ${ moduleMenus[moduleMenus.keys.first]!.keys.first}");
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



  // void addModule(String moduleName, [Map<String, Widget>? screen] ){
  //   if(!moduleMenus.containsKey(moduleName)){
  //     print("not containing module");
  //     selectedModule.value = moduleName;
  //     moduleMenus[moduleName] = screen!;
  //     if(screen.isNotEmpty){
  //       selectedScreen.value = screen.values.first;
  //       selectedsubScreen.value = screen.values.first;
  //       lastSelectedSubMenus[moduleName] = screen;
  //     }else{
  //
  //       // selectedsubScreen.value = moduleMenus[moduleName]!.values.first;
  //       selectedsubScreen.value = lastSelectedSubMenus[moduleName]!.values.first;
  //       // lastSelectedSubMenus
  //     }
  //     print("upated to ${lastSelectedSubMenus}");
  //
  //   }else{
  //     print("contains module thus switching to it");
  //     selectedModule.value = moduleName;
  //     selectedScreen.value = moduleMenus[moduleName]!.values.first;
  //     print("current saved is  ${lastSelectedSubMenus}");
  //     if(screen == null || screen.isEmpty){
  //       selectedsubScreen.value = lastSelectedSubMenus[moduleName]!.values.first;
  //       // selectedsubScreen.value = moduleMenus[moduleName]!.values.first;
  //     }else{
  //       if(!moduleMenus[moduleName]!.containsKey(screen.keys.first)){
  //         print("not containing submenu");
  //         // moduleMenus[moduleName] = screen!;
  //         final updatedMap = Map<String, Widget>.from(moduleMenus[moduleName]!);
  //         updatedMap.addAll({screen.keys.first: screen.values.first});
  //         moduleMenus[moduleName] = updatedMap;
  //         selectedsubScreen.value = screen.values.first;
  //
  //         lastSelectedSubMenus[moduleName] = screen;
  //
  //       }else{
  //         // selectedsubScreen.value = lastSelectedSubMenus[moduleName]!.values.first;
  //         selectedsubScreen.value = screen.values.first;
  //         lastSelectedSubMenus[moduleName] = screen;
  //       }
  //     }
  //
  //
  //   }
  // }


  void addMainMoodule(String moduleName, [Map<String, Widget>? screns]){
    print("current modules ${moduleMenus}");
    if(!moduleMenus.containsKey(moduleName)){
      print("not containing module adding it");
      moduleMenus[moduleName] = screns!;
      selectedModule.value = moduleName;
      // selectedSubScreenKey.value = screns.keys.first;

      // selectedScreen.value = screns.values.first;
      selectedScreen.value = screns.values.first;
      lastSelectedSubMenus[moduleName] = screns;
      // print("selected submainscreen is ${screns.values.first}");
      // selectedSubScreenKey.value = screns.keys.first;

    }else{
      print('contains the module');
      selectedModule.value = moduleName;
      print("current last screens on switching is ${lastSelectedSubMenus[moduleName]}");

      if(lastSelectedSubMenus[moduleName] != null){
        selectedScreen.value = moduleMenus[moduleName]!.values.first;

      }else{
        selectedScreen.value = moduleMenus[moduleName]!.values.first;
      }
    }
    // addSubModule(screns!);
    // getCurrentWidget();
  }

  void addSubModule(Map<String, Widget> submodule){
    print("selected submodule key is ${selectedSubScreenKey}");
    if(!moduleMenus[selectedModule.value]!.containsKey(submodule.keys.first)){
      selectedSubScreenKey.value = submodule.keys.first;
      moduleMenus[selectedModule.value]![submodule.keys.first] = submodule.values.first;
      lastSelectedSubMenus[selectedModule.value] = submodule;
      print("after adding ${moduleMenus[selectedModule.value]}");
      selectedSubScreenKey.value = submodule.keys.first;

    }else{
      print("submodule exists switching to it");
      selectedSubScreenKey.value = submodule.keys.first;
    }

    // getCurrentWidget();
  }

  Widget getCurrentWidget(){

    // return (selectedSubScreenKey.isEmpty || selectedSubScreenKey.isNull) ? moduleMenus[selectedModule.value]!.values.first: moduleMenus[selectedModule.value]![selectedSubScreenKey.value] ?? Text('No module to show');

    // return  moduleMenus[selectedModule.value]![selectedSubScreenKey.value] ?? Container();

    return moduleMenus[selectedModule.value]![selectedSubScreenKey.value] ?? Text('No submodule found');
  }

*/
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
  }*//*



*/
/*void addModule(String moduleName, *//*
*/
/*Map<String, Widget>screns*//*
*/
/*[Map<String, Widget>? screns]) {
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

  }*//*


}*/
