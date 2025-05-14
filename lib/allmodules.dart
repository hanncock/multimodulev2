import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:multimodule/commonLayout.dart';
import 'package:multimodule/modules/accounts/Accnts.dart';
import 'package:multimodule/reusables/RoundedContainer.dart';
import 'package:multimodule/reusables/constants.dart';
import 'package:multimodule/reusables/controller.dart';
import 'package:multimodule/reusables/keepAlive.dart';
import 'homepage.dart';
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

List<Menus> menusListed = [
  Menus(icona: Icon(Icons.school, size: 40), title: 'School', widget: SchoolScreen()),
  Menus(icona: Icon(Icons.house, size: 40), title: 'Home', widget: Text('Home')),
  Menus(icona: Icon(Icons.house, size: 40), title: 'Account', widget: Dekstop()),
];

class Allmodules extends StatefulWidget {
   Allmodules({super.key});

  @override
  State<Allmodules> createState() => _AllmodulesState();
}

class _AllmodulesState extends State<Allmodules> with TickerProviderStateMixin{
   late TabController tabController;
   
   Controller controller = Get.put(Controller("allhomes"), tag: "allhomes");

   @override
   void initState(){
     super.initState();
     controller.addModule("Modules", MainModules());
     tabController = TabController(
         length: controller.mainModules.keys.length,
         vsync: this
     );

   }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      /*bottomNavigationBar: Container(
        height:30,
        // margin: EdgeInsets.only(left: 24,),
        padding: EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: Colors.blueGrey.withOpacity(0.8),
          borderRadius: BorderRadius.all(Radius.circular(5))
        ),
        width: MediaQuery.of(context).size.width* 0.2,
        child: Row(
          children: List.generate(5, (index)=>Icon(Icons.abc)),
        ),
        // child: TabBar(
        //   controller: tabController,
        //   labelColor: Colors.white,
        //   unselectedLabelColor: Colors.white70,
        //   indicatorColor: Colors.white,
        //   tabs: [
        //     Tab(icon: Icon(Icons.dashboard), text: "Dashboard"),
        //     // Tab(icon: Icon(Icons.file_copy), text: "My Batches"),
        //     // Tab(icon: Icon(Icons.people), text: "BAs"),
        //     // Tab(icon: Icon(Icons.category_sharp), text: "BA Assigned"),
        //   ],
        // ),
      ),*/
      body: Column(
        children: [

          GetBuilder<Controller>(
              tag: "allhomes",
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


                    Expanded(
                      child: TabBarView(
                        controller: tabController,
                        children: modulesList.map((moduleKey) {
                          // For each module, display its content
                          Widget moduleWidgets = controller.mainModules[moduleKey]!;
                          Widget firstWidget = moduleWidgets;
                          return KeepPageAlive(child: firstWidget);
                        }).toList(),),
                    ),
                    Row(
                      mainAxisSize: MainAxisSize.min,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Expanded(
                          child: Container(
                            color: Color(0xFFA0A7D6),
                            child: Row(
                              children: [
                                Expanded(
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                  
                                    children: [
                                      ...controller.mainModules.keys.map((elmKey)=>InkWell(
                                          onTap: (){
                                  
                                            print("switching");
                                            controller.switchTo(elmKey);
                                          },
                                          child: Padding(
                                            padding: const EdgeInsets.all(8.0),
                                            child: Text('${elmKey}',style: TextStyle(color: Colors.white),),
                                          ))).toList(),
                                  
                                    ],
                                  ),
                                ),
                                Icon(Icons.settings,color: Colors.white,),
                                SizedBox()

                              ],
                            ),
                          ),
                        ),
                      ],
                    ),


                  ],),
                );
              })
        ],
      ),
    );
  }
}

class MainModules extends StatelessWidget {
  MainModules({super.key});
  //
  final Controller controller = Get.find<Controller>(tag: 'allhomes');



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          ...menusListed.map((module) => InkWell(
            onTap: (){
              controller.addModule(module.title ,module.widget);
            },
            child: SContainer(
              color: Colors.white,
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


