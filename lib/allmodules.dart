import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:multimodule/commonLayout.dart';
import 'package:multimodule/modules/accounts/Accnts.dart';
import 'package:multimodule/reusables/RoundedContainer.dart';
import 'package:multimodule/reusables/constants.dart';

import 'modules/school/schooldash.dart';
import 'modules/school/trialInput.dart';

class Menus{
  final Icon icona;
  final String title;
  final Widget widget;

  Menus({
    required this.widget,
    required this.title,
    required this.icona,
  });
  
}

Map<String, Widget> menus ={
  // "Dash":Text('School dash'),
  // "Students":Text('${sidebarController.selectedModule.value} Student'),
  "Students":TrailInput(),
  "Teachers":Text('${sidebarController.selectedModule.value} Teachers'),
};

List<Menus> menusListed = [
  Menus(icona: Icon(Icons.school, size: 40), title: 'School', widget: CommonLayout(modMenus: menus)),
  Menus(icona: Icon(Icons.house, size: 40), title: 'Home', widget: Text('Home')),
  Menus(icona: Icon(Icons.house, size: 40), title: 'Account', widget: Accounting()),
];

class Allmodules extends StatelessWidget {
   Allmodules({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [

          Expanded(
            // child: Obx( () => Text("${sidebarController.selectedScreen.value}" )?? Text('')),
            child: Obx( () => sidebarController.selectedScreen.value ?? Text('no screen selected')),
          ),

          Obx(() =>Row(
            children: [
              Expanded(
                child: Container(
                  height: 30,
                    color: Colors.blue.withOpacity(0.2),
                    child: Row(
                      children: [
                        ...List.generate(sidebarController.moduleMenus.length, (index) {
                          // String moduleName = sidebarController.moduleMenus.value.elementAt(index);
                          String moduleName = sidebarController.moduleMenus[index].keys.first;
                          return InkWell(
                            onTap: (){
                              sidebarController.addMainModule(moduleName);
                            },
                            child: Container(
                              padding: EdgeInsets.only(left: 12),
                              child: Text('${moduleName}'),
                            ),
                          );
                        })
                      ],
                    )
                ),
              ),
            ],
          )
          )
        ],
      ),
    );
  }
}

class MainModules extends StatelessWidget {
  MainModules({super.key});
  //

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          ...menusListed.map((module) => InkWell(
            onTap: (){
              // print("adding ${module.title}");
              sidebarController.addMainModule(module.title, {module.title : module.widget});
            },
            child: SContainer(
              child: Row(
                children: [
                  module.icona,
                  Text('${module.title}'),
                ],
              ),
            ),
          )),
        ],
      ),
    );
  }
}


