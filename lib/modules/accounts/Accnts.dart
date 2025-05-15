import 'package:flutter/material.dart';
import 'package:multimodule/homepage.dart';
import 'package:multimodule/reusables/controller.dart';
import '../../commonLayout.dart';
import 'package:get/get.dart';
import '../../reusables/constants.dart';
import '../../reusables/menu.dart';

// Map<String, Widget> menus ={
//   "Dash":HomePage(),
//   // "COA":Text('${sidebarController.selectedModule.value}, COA'),
//   // "Invoices":Text('${sidebarController.selectedModule.value}, Invoices'),
// };


List<Menus> menus = [

  Menus(imagePath: "people.svg", title: 'Student', widget: Text('StudentsListr')),
  Menus(imagePath: "airdrop.svg", title: 'Teachers', widget: Text('StudentsListr')),
  Menus(imagePath: "exam.svg", title: 'Examination', widget: Text('StudentsListr')),
  Menus(imagePath: "exam.svg", title: 'Grading System', widget: Text('StudentsListr')),
  Menus(imagePath: "document.svg", title: 'Results', widget: Text('StudentsListr')),
  Menus(imagePath: "book-saved.svg", title: 'Library', widget: Text('StudentsListr')),
  Menus(imagePath: "book-saved.svg", title: 'Class / Year', widget: Text('StudentsListr')),
  Menus(imagePath: "book-saved.svg", title: 'Stream', widget: Text('StudentsListr')),
  Menus(imagePath: "book-saved.svg", title: 'Subjects / Units', widget: Text('StudentsListr')),
  Menus(imagePath: "money.svg", title: 'Fees & Charges', widget: Text('StudentsListr')),
  Menus(imagePath: "book-saved.svg", title: 'Boarding & Residency', widget: Text('StudentsListr')),
  Menus(imagePath: "book-saved.svg", title: 'Boarding & Residency', widget: Text('StudentsListr')),



];

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
