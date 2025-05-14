import 'package:flutter/material.dart';
import 'package:multimodule/homepage.dart';
import 'package:multimodule/reusables/controller.dart';
import '../../commonLayout.dart';
import 'package:get/get.dart';
import '../../reusables/constants.dart';

Map<String, Widget> menus ={
  "Dash":HomePage(),
  // "COA":Text('${sidebarController.selectedModule.value}, COA'),
  // "Invoices":Text('${sidebarController.selectedModule.value}, Invoices'),
};

class Accounting extends StatefulWidget {
  const Accounting({super.key});

  @override
  State<Accounting> createState() => _AccountingState();
}

class _AccountingState extends State<Accounting> {
  Controller controller = Get.put(Controller("accounts"), tag: "accounts");

  late TabController tabController;

  @override
  void initState(){
    super.initState();
    controller.addModule("Dashboard", HomePage());
  }

  @override
  Widget build(BuildContext context) {
    return CommonLayout(modMenus: menus,tagline: 'accounts',);
  }
}
