import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:multimodule/modules/accounts/Accnts.dart';
import 'package:multimodule/reusables/RoundedContainer.dart';
import 'package:multimodule/reusables/constants.dart';

import 'modules/school/schooldash.dart';

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

List<Menus> menusListed = [
  Menus(icona: Icon(Icons.school, size: 40), title: 'School', widget: SchoolScreen()),
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
            child: Obx( () => sidebarController.selectedScreen.value ?? Text('')),
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
                          String moduleName = sidebarController.moduleMenus.keys.elementAt(index);
                          return InkWell(
                            onTap: (){
                              sidebarController.addModule(moduleName);
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
    return Column(
      children: [
        ...menusListed.map((module) => InkWell(
          // onTap: ()=> sidebarController.addModule(module.title,['School Dash']),
          onTap: (){
            // print(module.title);
            sidebarController.addModule(module.title, {"${module.title} Dash" : module.widget});
            // sidebarController.selectedModule.value == module;
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
    );
  }
}


