import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:multimodule/reusables/RoundedContainer.dart';
import 'package:multimodule/reusables/controller.dart';
import 'package:multimodule/reusables/keepAlive.dart';

class CommonLayout extends StatefulWidget  {
  final String tagline;
  final Map<String , Widget> modMenus;
  CommonLayout({super.key,required this.modMenus,required this.tagline});

  @override
  State<CommonLayout> createState() => _CommonLayoutState();
}

class _CommonLayoutState extends State<CommonLayout> with TickerProviderStateMixin{
  late TabController tabController;

  Controller get controller => Get.find<Controller>(tag: widget.tagline);


  @override
  void initState(){
    super.initState();
    controller.addModule("Dashboard", Text('School Dashboard'));
    tabController = TabController(
        length: controller.mainModules.keys.length,
        vsync: this
    );

  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Row(
        children: [
          // Column(
          //   children: [
          //   Text('${widget.modMenus}')
          //   ],
          // ),

          Container(
            color: Colors.blue,
            child: Column(
              // children: widget.modMenus.entries.map((item)=>InkWell(
              children: widget.modMenus.entries.map((item)=>InkWell(
                  onTap: (){
                    controller.addModule(item.key, item.value);
                  },
                  child: Text('${item.key}'))).toList(),
            ),
          ),

          GetBuilder<Controller>(
              tag: "${widget.tagline}",
              builder: (controller) {

                if (tabController.length != controller.mainModules.keys.length) {
                  int newLength = controller.mainModules.keys.length;
                  int previousLength = tabController.length;

                  tabController.dispose();
                  tabController = TabController(
                    length: newLength,
                    vsync: this,
                    initialIndex: newLength > previousLength ? newLength - 1 : 0,
                  );

                  // If a new tab was added, we want to animate to it
                  if (newLength > previousLength) {
                    WidgetsBinding.instance.addPostFrameCallback((_) {
                      tabController.animateTo(newLength - 1);
                    });
                  }
                }

                // Listen to tab changes to update the selected module
                if (!tabController.hasListeners) {
                  tabController.addListener(() {
                    if (!tabController.indexIsChanging) {
                      final modulesList = controller.mainModules.keys.toList();
                      if (tabController.index < modulesList.length) {
                        // controller.switchTo(modulesList[tabController.index]);
                      }
                    }
                  });
                }

                // Find the current index for the selected module
                final List<String> modulesList = controller.mainModules.keys.toList();
                final int selectedIndex = modulesList.indexOf(controller.selectedModule.value);

                // If tabController index doesn't match selected module, update it
                if (selectedIndex >= 0 && tabController.index != selectedIndex && !tabController.indexIsChanging) {
                  WidgetsBinding.instance.addPostFrameCallback((_) {
                    tabController.animateTo(selectedIndex);
                  });
                }


                return Expanded(
                  child: Column(children: [
                    SContainer(
                      color:Colors.blue.withOpacity(0.5),
                      child: Row(
                        children: [
                          ...controller.mainModules.keys.map((elmKey)=>InkWell(
                              onTap: (){
                                controller.switchTo(elmKey);
                              },
                              child: Text('${elmKey}'))).toList(),
                        ],
                      ),
                    ),


                    Expanded(
                      child: TabBarView(
                        controller: tabController,
                        children: modulesList.map((moduleKey) {
                          // For each module, display its content
                          Widget moduleWidgets = controller.mainModules[moduleKey]!;
                          Widget firstWidget = moduleWidgets;
                          return KeepPageAlive(child: firstWidget);
                        }).toList(),),
                    )
                  ],),
                );
              }),
        ],
      ),

    );
  }
}

