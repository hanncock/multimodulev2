import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:multimodule/reusables/constants.dart';
import 'package:multimodule/reusables/keepAlive.dart';

class CommonLayout extends StatefulWidget {
  final Map<String , Widget> modMenus;
  const CommonLayout({super.key,required this.modMenus});

  @override
  State<CommonLayout> createState() => _CommonLayoutState();
}

class _CommonLayoutState extends State<CommonLayout>{

  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((_) {
      print("adding to the main of selected module ${sidebarController.selectedModule.value}");

      // sidebarController.selectedSubModuleKey.value.isEmpty ?
      sidebarController.addSubModule({
        "Dash": Text('This is the dashboard an replicate it for all modules'),
      });// : Text('not going null');
    });
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Row(
        children: [
          Column(
            // children: widget.modMenus.entries.map((item)=>InkWell(
            children: widget.modMenus.entries.map((item)=>InkWell(
                onTap: (){
                  sidebarController.addSubModule({item.key : item.value});
                },
                child: Text('${item.key}'))).toList(),
          ),
          Obx(() => Expanded(
            child: Column(
              children: [
                Container(
                  color: Colors.blue,
                  child: Row(
                    children: [
                      ...sidebarController.moduleMenus.firstWhere((module) => module.containsKey(sidebarController.selectedModule.value))[sidebarController.selectedModule.value]!.entries.skip(1).map((entry) =>InkWell(
                          onTap: (){

                            sidebarController.addSubModule({entry.key:entry.value});

                          },
                          child: Text('${entry.key}'))).toList()
                    ],
                  ),
                ),
                Expanded(child: KeepPageAlive(child: sidebarController.getCurrentWidget(),))

              ],
            ),
          ),)
        ],
      ),

    );
  }
}
