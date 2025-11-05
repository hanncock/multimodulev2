import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:multimodule/modules/school/trialInput.dart';
import 'package:multimodule/reusables/controller.dart';

import '../../commonLayout.dart';
import '../../homepage.dart';
import '../../reusables/menu.dart';
import 'vehicles_list.dart';



List<Menus> menus = [

  Menus(imagePath: "people.svg", title: 'Vehicles', widget: Vehicles()),
  Menus(imagePath: "airdrop.svg", title: 'Customers', widget: Text('StudentsListr')),
  Menus(imagePath: "airdrop.svg", title: 'Bills Invoices', widget: Text('StudentsListr')),
  // Menus(imagePath: "exam.svg", title: 'Examination', widget: TrailInput()),
  // Menus(imagePath: "exam.svg", title: 'Grading System', widget: Text('StudentsListr')),
  // Menus(imagePath: "document.svg", title: 'Results', widget: Text('StudentsListr')),
  // Menus(imagePath: "book-saved.svg", title: 'Library', widget: Text('StudentsListr')),
  // Menus(imagePath: "book-saved.svg", title: 'Class / Year', widget: Text('StudentsListr')),
  // Menus(imagePath: "book-saved.svg", title: 'Stream', widget: Text('StudentsListr')),
  // Menus(imagePath: "book-saved.svg", title: 'Subjects / Units', widget: Text('StudentsListr')),
  // Menus(imagePath: "moneys.svg", title: 'Fees & Charges', widget: Text('StudentsListr')),
  // Menus(imagePath: "book-saved.svg", title: 'Boarding & Residency', widget: Text('StudentsListr')),
  // Menus(imagePath: "book-saved.svg", title: 'Boarding & Residency', widget: Text('StudentsListr')),



];


class VehicleDash extends StatefulWidget {
  const VehicleDash({super.key});

  @override
  State<VehicleDash> createState() => _VehicleDashState();
}

class _VehicleDashState extends State<VehicleDash>{


  Controller controller = Get.put(Controller("vehicle"), tag: "vehicle");
  late TabController tabController;


  @override
  void initState(){
    super.initState();
    controller.addModule("Dashboard", Text('Vehicle Dash'));
  }


  @override
  Widget build(BuildContext context) {
    return CommonLayout(modMenus: menus, tagline: 'vehicle',);
  }
}
