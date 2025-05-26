import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:multimodule/modules/settings/companySetup.dart';

import '../../commonLayout.dart';
import '../../reusables/controller.dart';
import '../../reusables/menu.dart';
import 'companys.dart';

List<Menus> menus = [
  Menus(imagePath: "people.svg", title: 'Companys', widget: Companies()),
  Menus(imagePath: "people.svg", title: 'Company Setup', widget: CompanySetup()),
  // Menus(imagePath: "airdrop.svg", title: 'Teachers', widget: Text('StudentsListr')),
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


class Settingdash extends StatefulWidget {
  const Settingdash({super.key});

  @override
  State<Settingdash> createState() => _SettingdashState();
}

class _SettingdashState extends State<Settingdash>{


  Controller controller = Get.put(Controller("setup"), tag: "setup");
  late TabController tabController;


  @override
  void initState(){
    super.initState();
    controller.addModule("Dashboard", Text('Setting Dash'));
  }


  @override
  Widget build(BuildContext context) {
    return CommonLayout(modMenus: menus, tagline: 'setup',);
  }
}
