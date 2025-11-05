/*
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

*/
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:multimodule/Wrapper.dart';
import 'package:multimodule/reusables/RoundedContainer.dart';
import 'package:multimodule/reusables/controller.dart';
import 'package:multimodule/reusables/keepAlive.dart';

import 'reusables/constants.dart';

// --- Placeholder for ModMenu and Header (Assume ModMenu is a class with title, imagePath, widget) ---
// Note: You must ensure 'controller.dart' or a similar file includes:
// 1. An observable property for side menu selection (e.g., RxString selectedSideMenu).
// 2. A method to update it (e.g., void switchToSideMenu(String title)).
// 3. A method to get the controller (e.g., Get.find<Controller>(tag: tagline)).

class HeaderWidget extends StatelessWidget {
  const HeaderWidget({super.key});

  @override
  Widget build(BuildContext context) {
    // Primary brand purple color from the image

    return Container(
      height: 60,
      color: Colors.white,
      padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 8),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          // Left side: Search and All dropdown (Placeholder)
          Row(
            children: [
              Container(
                width: 250,
                height: 35,
                padding: const EdgeInsets.symmetric(horizontal: 10),
                decoration: BoxDecoration(
                  color: const Color(0xFFF7F8FC),
                  borderRadius: BorderRadius.circular(8),
                  border: Border.all(color: const Color(0xFFE0E0E0)),
                ),
                child: const Row(
                  children: [
                    Icon(Icons.search, size: 18, color: Colors.black54),
                    SizedBox(width: 8),
                    Expanded(
                      child: TextField(
                        decoration: InputDecoration(
                          hintText: 'Search',
                          border: InputBorder.none,
                          isDense: true,
                          contentPadding: EdgeInsets.zero,
                          hintStyle: TextStyle(fontSize: 14, color: Colors.black54),
                        ),
                        style: TextStyle(fontSize: 14),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(width: 15),
              // 'All' Dropdown (Simplified)
              Container(
                height: 35,
                padding: const EdgeInsets.symmetric(horizontal: 10),
                decoration: BoxDecoration(
                  color: const Color(0xFFF7F8FC),
                  borderRadius: BorderRadius.circular(8),
                  border: Border.all(color: const Color(0xFFE0E0E0)),
                ),
                child: const Center(
                    child: Row(
                      children: [
                        Text('All', style: TextStyle(fontSize: 14)),
                        Icon(Icons.keyboard_arrow_down_sharp, size: 18),
                      ],
                    )),
              ),
            ],
          ),

          // const Spacer(), // Pushes elements to the corners
          //
          // // Right side: Icons and User/Button
          // const Icon(Icons.notifications_none, color: Colors.black54, size: 22),
          // const SizedBox(width: 15),
          // const Icon(Icons.person_outline, color: Colors.black54, size: 22),
          // const SizedBox(width: 20),
          // const Text("Washim Chowdhury", style: TextStyle(fontWeight: FontWeight.w600, fontSize: 14)),
          // const SizedBox(width: 20),

          // Add Vehicle Button
          ElevatedButton.icon(
            onPressed: () {},
            icon: const Icon(Icons.add, size: 18),
            label: const Text("Add Vehicle", style: TextStyle(fontSize: 13)),
            style: ElevatedButton.styleFrom(
              backgroundColor: primaryPurple,
              foregroundColor: Colors.white,
              elevation: 0,
              padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
            ),
          ),
        ],
      ),
    );
  }
}

class CommonLayout extends StatefulWidget  {
  final String tagline;
  final List modMenus; // Assume modMenus items have .title, .imagePath, .widget
  CommonLayout({super.key, required this.modMenus, required this.tagline});

  @override
  State<CommonLayout> createState() => _CommonLayoutState();
}

class _CommonLayoutState extends State<CommonLayout> with TickerProviderStateMixin{
  late TabController tabController;

  // Use a softer, subtle background color
  final Color scaffoldBackgroundColor = const Color(0xFFF7F8FC);
  // The primary brand color
  final Color primaryPurple = const Color(0xFF4C42C7);

  Controller get controller => Get.find<Controller>(tag: widget.tagline);


  @override
  void initState(){
    super.initState();
    // Initialize with Dashboard and set the side menu selection
    controller.addModule("Dashboard", const Text('School Dashboard'));
    // NOTE: You need to implement 'switchToSideMenu' in your Controller
    // controller.switchToSideMenu("Dashboard");

    tabController = TabController(
        length: controller.mainModules.keys.length,
        vsync: this
    );
  }

  @override
  void dispose() {
    tabController.dispose();
    super.dispose();
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: scaffoldBackgroundColor,
      body: Row(
        children: [

          // --- 1. Sidebar (Full Height, White Background, Rounded Selection) ---
          Container(
            height: MediaQuery.of(context).size.height,
            width: 240,
            color: Colors.white,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Logo/Title Area
                Padding(
                  padding: const EdgeInsets.only(left: 20, top: 10, bottom: 30),
                  child: Text(
                    "$companyName",
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: primaryPurple,
                    ),
                  ),
                ),

                // Scrollable menu section
                Obx( ()=>Expanded(
                  child: SingleChildScrollView(
                    scrollDirection: Axis.vertical,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: widget.modMenus.map((item) {
                        // final bool isSelected = item.title == controller.selectedSubScreen.value;
                        final bool isSelected = item.title.toString().toLowerCase() == controller.selectedModule.value.toString().toLowerCase();
                        return Padding(
                          padding: const EdgeInsets.only(right: 15, bottom: 5, left: 15),
                          child: Container(
                            decoration: BoxDecoration(
                              color: controller.selectedModule.value == item.title
                                  ? primaryPurple.withOpacity(0.1) // Subtle background highlight
                                  : Colors.transparent, // Background color for inactive tabs
                              borderRadius: BorderRadius.circular(8),
                              border: Border.all(
                                color: controller.selectedModule.value == item.title
                                    ? primaryPurple.withOpacity(0.5) // Subtle border on active tab
                                    : Colors.transparent,
                                width: 1,
                              ),
                            ),
                            child: ListTile(
                              onTap: () {
                                controller.addModule(item.title, item.widget);
                              },
                              contentPadding: const EdgeInsets.symmetric(horizontal: 10, vertical: 0),
                              selected: isSelected,
                              selectedTileColor: primaryPurple.withOpacity(0.1),
                              selectedColor: primaryPurple,
                              tileColor: Colors.white,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(8),
                              ),
                              leading: SvgPicture.asset(
                                "assets/icons/${item.imagePath}",
                                colorFilter: ColorFilter.mode(
                                  isSelected ? primaryPurple : Colors.black54,
                                  BlendMode.srcIn,
                                ),
                                height: 18,
                              ),
                              title: Text(
                                "${item.title}",
                                style: TextStyle(
                                  color: isSelected ? primaryPurple : Colors.black87,
                                  fontSize: 14,
                                  fontWeight: isSelected ? FontWeight.w600 : FontWeight.w500,
                                ),
                              ),
                            ),
                          ),
                        );
                      }).toList(),
                    ),
                  ),
                )),

                // Bottom section (profile/settings)
                Padding(
                  padding: const EdgeInsets.all(15.0),
                  child: Row(
                    children: [
                      const Icon(Icons.notifications_none, color: Colors.black54, size: 22),
                      const SizedBox(width: 15),
                      const Icon(Icons.person_outline, color: Colors.black54, size: 22),
                      const SizedBox(width: 10),
                      Text(
                        "${Userdata[0]['firstName']}",
                        style: TextStyle(fontWeight: FontWeight.w600, fontSize: 12),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),

    // Separator
          const SizedBox(width: 5),

          // --- 2. Main Content (Header, Tabs, View) ---
          GetBuilder<Controller>(
              tag: "${widget.tagline}",
              builder: (controller) {

                // --- Tab Controller Sync Logic (Kept as is) ---
                if (tabController.length != controller.mainModules.keys.length) {
                  int newLength = controller.mainModules.keys.length;
                  int previousLength = tabController.length;

                  tabController.dispose();
                  tabController = TabController(
                    length: newLength,
                    vsync: this,
                    initialIndex: newLength > previousLength ? newLength - 1 : 0,
                  );

                  if (newLength > previousLength) {
                    WidgetsBinding.instance.addPostFrameCallback((_) {
                      tabController.animateTo(newLength - 1);
                    });
                  }
                }

                if (!tabController.hasListeners) {
                  tabController.addListener(() {
                    if (!tabController.indexIsChanging) {
                      // Logic to handle tab change
                    }
                  });
                }

                final List<String> modulesList = controller.mainModules.keys.toList();
                final int selectedIndex = modulesList.indexOf(controller.selectedModule.value);

                if (selectedIndex >= 0 && tabController.index != selectedIndex && !tabController.indexIsChanging) {
                  WidgetsBinding.instance.addPostFrameCallback((_) {
                    tabController.animateTo(selectedIndex);
                  });
                }
                // --- End Tab Controller Sync Logic ---


                return Expanded(
                  child: Column(children: [

                    // --- 2a. Top Header (New component) ---
                    // const HeaderWidget(),

                    // --- 2b. Module Tabs (Reworked to look like a filter bar) ---
                    Padding(
                      padding: const EdgeInsets.only(top: 8.0, left: 15, right: 15, bottom: 8.0),
                      child: SContainer(
                        color: Colors.white, // Container for the tabs is white in the image area
                        // padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 10.0),
                        child: SingleChildScrollView(
                          scrollDirection: Axis.horizontal,
                          child: Row(
                            children: [
                              // Tab Items
                              ...controller.mainModules.keys.map((elmKey) => Container(
                                margin: const EdgeInsets.only(right: 8),
                                padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                                decoration: BoxDecoration(
                                  color: controller.selectedModule.value == elmKey
                                      ? primaryPurple.withOpacity(0.1) // Subtle background highlight
                                      : scaffoldBackgroundColor, // Background color for inactive tabs
                                  borderRadius: BorderRadius.circular(8),
                                  border: Border.all(
                                    color: controller.selectedModule.value == elmKey
                                        ? primaryPurple.withOpacity(0.5) // Subtle border on active tab
                                        : Colors.transparent,
                                    width: 1,
                                  ),
                                ),
                                child: Row(
                                  children: [
                                    InkWell(
                                      onTap: (){
                                        controller.switchTo(elmKey);
                                      },
                                      child: Text(
                                          elmKey,
                                          style: TextStyle(
                                            fontSize: 11,
                                            fontWeight: FontWeight.w600,
                                            color: controller.selectedModule.value == elmKey ? primaryPurple : Colors.black87,
                                          )
                                      ),
                                    ),
                                    // Close Icon (Standard placement)
                                    if (elmKey != 'Dashboard') ...[
                                      const SizedBox(width: 8),
                                      GestureDetector(
                                        onTap: () {
                                          controller.removeTab(elmKey);
                                        },
                                        child: const Icon(
                                          Icons.close,
                                          size: 14,
                                          color: Colors.black54,
                                        ),
                                      ),
                                    ],
                                  ],
                                ),
                              )).toList(),
                            ],
                          ),
                        ),
                      ),
                    ),


                    // --- 2c. Tab View Content ---
                    Expanded(
                        child: TabBarView(
                          physics: const NeverScrollableScrollPhysics(), // Prevent manual swiping
                          controller: tabController,
                          children: modulesList.map((moduleKey) {
                            Widget moduleWidgets = controller.mainModules[moduleKey]!;
                            return KeepPageAlive(child: moduleWidgets);
                          }).toList(),
                        )
                    )
                  ],),
                );
              }),
        ],
      ),

    );
  }
}