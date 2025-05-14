import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:multimodule/modules/school/trialInput.dart';
import 'package:multimodule/reusables/controller.dart';

import '../../commonLayout.dart';
import '../../homepage.dart';

Map<String, Widget> menus ={
  "Students":Column(
    children: [
      Text('sturdnre'),
      TrailInput()
    ],
  ),
  "Students":TrailInput(),
  "Dashbbb":Dekstop(),
};

class SchoolScreen extends StatefulWidget {
  const SchoolScreen({super.key});

  @override
  State<SchoolScreen> createState() => _SchoolScreenState();
}

class _SchoolScreenState extends State<SchoolScreen>{


  Controller controller = Get.put(Controller("schools"), tag: "schools");
  late TabController tabController;


  @override
  void initState(){
    super.initState();
    controller.addModule("Dashboard", Text('School Dashboard'));
  }


  @override
  Widget build(BuildContext context) {
    return CommonLayout(modMenus: menus, tagline: 'schools',);
  }
}
