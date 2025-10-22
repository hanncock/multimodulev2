import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:multimodule/reusables/RoundedContainer.dart';
import 'package:multimodule/reusables/controller.dart';
import 'package:multimodule/reusables/keepAlive.dart';

class CommonLayout extends StatefulWidget  {
  final String tagline;
  // final Map<String , Widget> modMenus;
  final List modMenus;
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
      backgroundColor: Color(0xFFF1F3FF),
      body: Row(
        children: [

          SContainer(
            height: MediaQuery.of(context).size.height * 0.8,
            width: 200,
            color: Colors.white,
            child: SingleChildScrollView(
              scrollDirection: Axis.vertical,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: widget.modMenus.map((item)=>ListTile(
                  onTap: (){
                    controller.addModule(item.title, item.widget);
                  },
                  leading: SvgPicture.asset("assets/icons/${item.imagePath}",color: Colors.black,),
                  title: Text("${item.title}",style: TextStyle(color: Colors.black,fontSize: 12,fontWeight: FontWeight.bold),),
                )).toList(),
                /* children: widget.modMenus.entries.map((item)=>InkWell(
                    onTap: (){
                      controller.addModule(item.key, item.value);
                    },
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text('${item.key}'),
                    ))).toList(),*/
              ),
            ),
          ),
          SizedBox(width: 5,),
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
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 8.0,horizontal: 15),
                      child: SContainer(
                        // color:Color(0xFF6C63FF),
                        color:Color(0xFFF1F3FF),
                        child: SingleChildScrollView(
                          scrollDirection: Axis.horizontal,
                          child: IntrinsicHeight(
                            child: Row(
                              mainAxisSize: MainAxisSize.max,
                              children: [
                                ...controller.mainModules.keys.map((elmKey)=>Container(

                                  margin: const EdgeInsets.symmetric(horizontal: 4),
                                  padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 4),
                                  decoration: BoxDecoration(
                                    color: controller.selectedModule.value == elmKey
                                        ? Colors.blueAccent.withOpacity(0.2)
                                        : Colors.white.withOpacity(0.5),


                                    borderRadius: BorderRadius.circular(4),
                                    // border: Border.all(
                                    //   color: controller.selectedModule.value == elmKey
                                    //       ? Colors.blue
                                    //       : Colors.grey.shade400,
                                    // ),

                                    border: Border(
                                      bottom: BorderSide(
                                        color: controller.selectedModule.value == elmKey
                                            ? Colors.blueAccent
                                            : Colors.transparent,
                                        width: 1,
                                      ),
                                      right: BorderSide(
                                        color: controller.selectedModule.value == elmKey
                                            ? Colors.blueAccent
                                            : Colors.transparent,
                                        width: 1,
                                      ),
                                    ),



                                  ),
                                  child: Row(
                                    children: [
                                      Padding(
                                        padding: const EdgeInsets.only(right: 20.0),
                                        child: InkWell(
                                            onTap: (){
                                              controller.switchTo(elmKey);
                                            },
                                            child: Text('${elmKey}',style: TextStyle(fontSize: 12),)),
                                      ),
                                      elmKey=='Dashboard' ? Text('') :Transform.translate(
                                        offset: const Offset(0, -6), // Lift the icon upward
                                        child: GestureDetector(
                                          onTap: () {
                                            controller.removeTab(elmKey);
                                          },
                                          child: const Icon(
                                            Icons.close,
                                            size: 10, // Small size for superscript look
                                            color: Colors.redAccent,
                                          ),
                                        ),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.symmetric(vertical: 4.0),
                                        child: VerticalDivider(thickness: 1,color: Colors.blueAccent,),
                                      ),
                                    ],
                                  ),
                                )
                                ).toList(),
                              ],
                            ),

                            // child: Row(
                            //   mainAxisSize: MainAxisSize.max,
                            //   children: [
                            //     ...controller.mainModules.keys.map(
                            //           (elmKey) => Container(
                            //         margin: const EdgeInsets.symmetric(horizontal: 4),
                            //         padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 6),
                            //         decoration: BoxDecoration(
                            //           color: controller.selectedModule.value == elmKey
                            //               ? Colors.blue.shade100
                            //               : Colors.grey.shade200,
                            //           borderRadius: BorderRadius.circular(4),
                            //           // border: Border.all(
                            //           //   color: controller.selectedModule.value == elmKey
                            //           //       ? Colors.blue
                            //           //       : Colors.grey.shade400,
                            //           // ),
                            //         ),
                            //         child: Row(
                            //           mainAxisSize: MainAxisSize.min,
                            //           children: [
                            //             GestureDetector(
                            //               onTap: () {
                            //                 controller.switchTo(elmKey);
                            //               },
                            //               child: Text(
                            //                 elmKey,
                            //                 style: const TextStyle(
                            //                   fontWeight: FontWeight.w500,
                            //                   color: Colors.black87,
                            //                 ),
                            //               ),
                            //             ),
                            //             SizedBox(width: 5,),
                            //             if (elmKey != 'Dashboard') ...[
                            //               const SizedBox(width: 4),
                            //               Transform.translate(
                            //                 offset: const Offset(0, -6), // Lift the icon upward
                            //                 child: GestureDetector(
                            //                   onTap: () {
                            //                     controller.removeTab(elmKey);
                            //                   },
                            //                   child: const Icon(
                            //                     Icons.close,
                            //                     size: 12, // Small size for superscript look
                            //                     color: Colors.redAccent,
                            //                   ),
                            //                 ),
                            //               ),
                            //             ],
                            //           ],
                            //         ),
                            //       ),
                            //     ),
                            //   ],
                            // ),


                            /*child: Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              // mainAxisAlignment: MainAxisAlignment.start,
                              mainAxisSize: MainAxisSize.max,
                              children: [
                                ...controller.mainModules.keys.map(
                                      (elmKey) => Container(
                                    margin: const EdgeInsets.symmetric(horizontal: 4),
                                    padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                                    decoration: BoxDecoration(
                                      color: controller.selectedModule.value == elmKey
                                          ? Colors.blue.shade100
                                          : Colors.grey.shade200,
                                      borderRadius: BorderRadius.circular(4),
                                      border: Border.all(
                                        color: controller.selectedModule.value == elmKey
                                            ? Colors.blue
                                            : Colors.grey.shade400,
                                      ),
                                    ),
                                    child: Row(
                                      children: [
                                        GestureDetector(
                                          onTap: () {
                                            controller.switchTo(elmKey);
                                          },
                                          child: Text(
                                            elmKey,
                                            style: TextStyle(
                                              fontWeight: FontWeight.w500,
                                              color: Colors.black87,
                                            ),
                                          ),
                                        ),
                                        if (elmKey != 'Dashboard') ...[
                                          const SizedBox(width: 6),
                                          GestureDetector(
                                            onTap: () {
                                              controller.removeTab(elmKey);
                                            },
                                            child: Container(
                                              padding: const EdgeInsets.all(2),
                                              decoration: BoxDecoration(
                                                shape: BoxShape.circle,
                                                color: Colors.redAccent.withOpacity(0.1),
                                              ),
                                              child: const Icon(
                                                Icons.close,
                                                size: 14,
                                                color: Colors.redAccent,
                                              ),
                                            ),
                                          ),
                                        ],
                                      ],
                                    ),
                                  ),
                                ),
                              ],
                            ),*/

                          ),
                        ),
                      ),
                    ),


                    Expanded(
                      child: TabBarView(
                        physics: NeverScrollableScrollPhysics(),
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

