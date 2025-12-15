import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:multimodule/Wrapper.dart';
import 'package:multimodule/modules/vehicle/vehicle_dash.dart';
import 'package:multimodule/reusables/RoundedContainer.dart';
import 'package:multimodule/reusables/controller.dart';
import 'package:multimodule/reusables/keepAlive.dart';
import 'package:multimodule/reusables/menu.dart';
import 'package:multimodule/willdell/formtester.dart';
import 'package:multimodule/willdell/newformtrial.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'Authentication.dart';
import 'modules/accounts/Accnts.dart';
import 'modules/school/schooldash.dart';
import 'modules/settings/SettingDash.dart';



List<Menus> menusListed = [
  // Menus(icona: Icon(Icons.school, size: 40), title: 'School', widget: SchoolScreen()),
  // Menus(icona: Icon(Icons.house, size: 40), title: 'Home', widget: Text('Home')),
  // Menus(icona: Icon(Iconsax.bank, size: 40), title: 'Account', widget: Dekstop()),
  // Menus(imagePath: "",  icona: Icon(Iconsax.bank, size: 40), title: 'Account', widget: Dekstop()),

  Menus(imagePath: "teacher", title: 'School', widget: SchoolScreen()),
  Menus(imagePath: "bank", title: 'Account', widget: Accounting()),
  // Menus(imagePath: "bank", title: 'Form', widget: Formtester()),
  Menus(imagePath: "bank", title: 'Form', widget: DynamicFormScreen()),
  Menus(imagePath: "bank", title: 'Add new ', widget: Newformtrial()),
  Menus(imagePath: "setting", title: 'Setup ', widget: Settingdash()),
  Menus(imagePath: "android", title: 'VMS ', widget: VehicleDash()),
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
      extendBody: true,
      bottomNavigationBar: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          Padding(
            padding: const EdgeInsets.only(bottom: 0.0),
            child: GetBuilder<Controller>(
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


                  return Padding(
                    padding: const EdgeInsets.only(bottom: 12.0),
                    child: Container(
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(16),
                        border: Border.all(color: const Color(0xFFE0E0E0), width: 1),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.05),
                            blurRadius: 12,
                            offset: const Offset(0, -2),
                          ),
                        ],
                      ),
                      constraints: BoxConstraints(
                        minWidth: 150,
                      ),
                      child: IntrinsicHeight(
                        child: Row(
                          mainAxisSize: MainAxisSize.min,

                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.start,

                              children: [

                                /*PopupMenuButton(
                                    icon: Icon(Icons.more_vert_sharp),

                                    offset: Offset(0, -70),
                                    // color: darkmode ? Colors.black: Colors.grey[100],
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(10.0),
                                      side: BorderSide(
                                          width: 1,
                                          color: Colors.grey.shade200
                                      ),
                                    ),

                                    itemBuilder: (BuildContext context){
                                      return[
                                        PopupMenuItem(
                                            child: InkWell(
                                              onTap: (){
                                                showMenu(
                                                  context: context,
                                                  // position: RelativeRect.fromLTRB(
                                                  //   // details.globalPosition.dx,
                                                  //   // details.globalPosition.dy,
                                                  //   // details.globalPosition.dx,
                                                  //   // details.globalPosition.dy,
                                                  // ),
                                                  items: Userdata[0]['companys']?.map((action) {
                                                    return PopupMenuItem(
                                                      child: Text(action.companyName),
                                                      onTap: () {
                                                        print('switching to ${action['companyId']}');
                                                        // Future.delayed(Duration.zero, () {
                                                        //   action.onTap?.call(row);
                                                        // });
                                                      },
                                                    );
                                                  }).toList() ?? [],
                                                );
                                              },
                                              child: Column(
                                                crossAxisAlignment: CrossAxisAlignment.start,
                                                children: [
                                                  Text('Switch Company'),
                                                ],
                                              ),
                                            )
                                        )
                                      ];
                                    },
                                  ),*/

                                PopupMenuButton(
                                  icon: Icon(Icons.more_vert_sharp),
                                  offset: Offset(0, -70),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(10.0),
                                    side: BorderSide(
                                      width: 1,
                                      color: Colors.grey.shade200,
                                    ),
                                  ),
                                  itemBuilder: (BuildContext context) {
                                    return [
                                      PopupMenuItem(
                                        child: InkWell(
                                          onTap: () {
                                            Navigator.pop(context); // Close the first menu before opening the second
                                            final RenderBox overlay = Overlay.of(context).context.findRenderObject() as RenderBox;

                                            showMenu(
                                              context: context,
                                              position: RelativeRect.fromLTRB(
                                                overlay.size.width - 100, // Adjust position to match your UI
                                                100, // Adjust this Y position as needed
                                                10,
                                                0,
                                              ),
                                              items: (Userdata[0]['companys'] ?? []).map<PopupMenuEntry>((company) {
                                                return PopupMenuItem(
                                                  child: Text(company['companyName']),
                                                  onTap: () {
                                                    print('Switching to ${company['companyId']}');
                                                    // Handle the switch logic here
                                                  },
                                                );
                                              }).toList(),
                                            );
                                          },
                                          child: Text('Switch Company'),
                                        ),
                                      ),
                                      PopupMenuItem(
                                        child: InkWell(
                                          onTap: () async{
                                            print('loggin you out');
                                            SharedPreferences preferences = await SharedPreferences.getInstance();
                                            // dynamic alldata = resu2;
                                            // preferences.setString('userData', jsonEncode(alldata));
                                            preferences.clear();
                                            // Navigator.push(context, MaterialPageRoute(builder: (_) =>  Wrapper(sessionStateStream: widget.sessionStateStream,)));
                                            // Navigator.push(context, MaterialPageRoute(builder: (_) =>  Wrapper(sessionStateStream: null,)));
                                            // Navigator.push(context, MaterialPageRoute(builder: (_) =>  Login()));


                                            // Navigator.pop(context); // Close the first menu before opening the second
                                            // final RenderBox overlay = Overlay.of(context).context.findRenderObject() as RenderBox;

                                            // showMenu(
                                            //   context: context,
                                            //   position: RelativeRect.fromLTRB(
                                            //     overlay.size.width - 100, // Adjust position to match your UI
                                            //     100, // Adjust this Y position as needed
                                            //     0,
                                            //     0,
                                            //   ),
                                            //   items: (Userdata[0]['companys'] ?? []).map<PopupMenuEntry>((company) {
                                            //     return PopupMenuItem(
                                            //       child: Text(company['companyName']),
                                            //       onTap: () {
                                            //         print('Switching to ${company['companyId']}');
                                            //         // Handle the switch logic here
                                            //       },
                                            //     );
                                            //   }).toList(),
                                            // );
                                          },
                                          child: Text('Log Out'),
                                        ),
                                      ),
                                    ];
                                  },
                                ),


                                Padding(
                                  padding: const EdgeInsets.symmetric( vertical:  10.0),
                                  child: VerticalDivider(thickness: 1,),
                                ),
                                SizedBox(width: 10,),



                                // InkWell(
                                //     onTap:(){
                                //       PopupMenuButton(
                                //           itemBuilder: (context) =>[
                                //             PopupMenuItem(child: Text('change company'))
                                //           ] );
                                //     },
                                //     child: Icon(Icons.more_vert_sharp)),
                              ],
                            ),
                            Flexible(
                              fit: FlexFit.loose,
                              child: Row(
                                mainAxisSize: MainAxisSize.min,
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  ...controller.mainModules.keys.map((elmKey)=>Material(
                                      color: Colors.transparent,
                                      child: InkWell(
                                        onTap: (){
                                          controller.switchTo(elmKey);
                                        },
                                        borderRadius: BorderRadius.circular(12),
                                        child: Container(
                                          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
                                          margin: const EdgeInsets.symmetric(horizontal: 4),
                                          decoration: BoxDecoration(
                                            color: controller.selectedModule == elmKey
                                                ? const Color(0xFF4C42C7).withOpacity(0.1)
                                                : Colors.transparent,
                                            borderRadius: BorderRadius.circular(12),
                                            border: controller.selectedModule == elmKey
                                                ? Border.all(color: const Color(0xFF4C42C7).withOpacity(0.3), width: 1)
                                                : null,
                                          ),
                                          child: Row(
                                            mainAxisSize: MainAxisSize.min,
                                            children: [
                                              menusListed.indexWhere((ele) => ele.title == elmKey) == -1
                                                  ? SvgPicture.asset(
                                                "assets/icons/dash.svg",
                                                color: controller.selectedModule == elmKey
                                                    ? const Color(0xFF4C42C7)
                                                    : const Color(0xFF757575),
                                                width: 20,
                                                height: 20,
                                              )
                                                  : Column(
                                                mainAxisAlignment: MainAxisAlignment.center,
                                                mainAxisSize: MainAxisSize.min,
                                                children: [
                                                  SvgPicture.asset(
                                                    "assets/icons/${menusListed[menusListed.indexWhere((ele) => ele.title == elmKey)].imagePath}.svg",
                                                    color: controller.selectedModule == elmKey
                                                        ? const Color(0xFF4C42C7)
                                                        : const Color(0xFF757575),
                                                    width: 20,
                                                    height: 20,
                                                  ),
                                                  if (controller.selectedModule == elmKey)
                                                    Padding(
                                                      padding: const EdgeInsets.only(top: 2),
                                                      child: Text(
                                                        '${elmKey}',
                                                        style: const TextStyle(
                                                          color: Color(0xFF4C42C7),
                                                          fontSize: 9,
                                                          fontWeight: FontWeight.w600,
                                                        ),
                                                      ),
                                                    ),
                                                ],
                                              )
                                            ],
                                          ),
                                        ),
                                      )
                                  )).toList(),

                                ],
                              ),
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                SizedBox(width: 10,),
                                Padding(
                                  padding: const EdgeInsets.symmetric(vertical: 10.0),
                                  child: VerticalDivider(
                                    thickness: 1,
                                    color: const Color(0xFFE0E0E0),
                                    width: 1,
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.symmetric(horizontal: 12),
                                  child: SvgPicture.asset(
                                    "assets/icons/personalcard.svg",
                                    color: const Color(0xFF424242),
                                    width: 20,
                                    height: 20,
                                  ),
                                ),
                              ],
                            )

                          ],
                        ),
                      ),
                    ),
                  );
                }),
          ),
        ],
      ),
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
                        physics: NeverScrollableScrollPhysics(),
                        controller: tabController,
                        children: modulesList.map((moduleKey) {
                          // For each module, display its content
                          Widget moduleWidgets = controller.mainModules[moduleKey]!;
                          Widget firstWidget = moduleWidgets;
                          return KeepPageAlive(child: firstWidget);
                        }).toList(),),
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
              color:Colors.blueGrey,
              width: 150,
              height: 50,
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  SizedBox(width: 5,),
                  SvgPicture.asset("assets/icons/${module.imagePath}.svg", width: 30,
                    height: 30,color: Colors.white,),
                  // module.icona,


                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text('${module.title}',style: TextStyle(color: Colors.white),),
                  ),
                ],
              ),
            ),
          )),
        ],
      ),
    );
  }
}


