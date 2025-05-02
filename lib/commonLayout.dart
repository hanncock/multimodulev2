import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:multimodule/reusables/constants.dart';

class CommonLayout extends StatelessWidget {
  final Map<String , Widget> modMenus;
  const CommonLayout({super.key,required this.modMenus});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Row(
        children: [
          Column(
            children: modMenus.entries.map((item)=>InkWell(
                onTap: (){
                  // print(item.runtimeType);
                  // print(sidebarController.selectedModule);
                  sidebarController.addModule(sidebarController.selectedModule.value,{item.key:item.value});
                  print(sidebarController.moduleMenus);
                },
                child: Text('${item.key}'))).toList(),
          ),
          Expanded(
            child: Column(
              children: [
                Obx(() => Column(
                  children: [
                    Text("${sidebarController.moduleMenus[sidebarController.selectedModule.value]}" )?? SizedBox(),
                    // Text("${sidebarController.selectedsubScreen.value}" )?? SizedBox(),
                  ],
                )),

                /*Obx(()=> Row(
                    children: [
                      Expanded(
                        child: Container(
                          color: Colors.blue,
                          child: Row(
                            children: [
                              ...List.generate(sidebarController.moduleMenus[sidebarController.selectedModule.value]!.keys.length, (index) {
                                var submoduleName = sidebarController.moduleMenus[sidebarController.selectedModule.value]!.keys.elementAt(index);
                                var submoduleNameValue = sidebarController.moduleMenus[sidebarController.selectedModule.value]!.values.elementAt(index);
                                return InkWell(
                                  onTap: (){
                                    sidebarController.addModule(sidebarController.selectedModule.value, {submoduleName:submoduleNameValue});
                        
                                  },
                                  child: Container(
                                    padding: EdgeInsets.only(left: 12),
                                    child: Text('${submoduleName}'),
                                  ),
                                );
                              })
                            ],
                          ),
                          // child: Text('All current menus go here'),
                        ),
                      ),
                    ],
                  ),
                ),*/
                Expanded(
                  // child: Obx(()=> sidebarController.selectedScreen.value ?? Text('')?? Text('${sidebarController.selectedModule}')),
                  child: Obx(() =>Text('${sidebarController.selectedsubScreen.value}')),
                )
              ],
            ),
          ),
        ],
      ),

    );
  }
}
