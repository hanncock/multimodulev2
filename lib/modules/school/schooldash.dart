import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:multimodule/modules/school/trialInput.dart';
import 'package:multimodule/reusables/controller.dart';

import '../../commonLayout.dart';
import '../../homepage.dart';
import '../../reusables/menu.dart';

// Map<String, Widget> menus ={
//   // "Students":Column(
//   //   children: [
//   //     Text('sturdnre'),
//   //     TrailInput()
//   //   ],
//   // ),
//   // "Teachers":TrailInput(),
//   "Examinations":TrailInput(),
//   "Grading System":TrailInput(),
//   "Results":TrailInput(),
//   "Library":TrailInput(),
//   "Class/Year":TrailInput(),
//   "Stream":TrailInput(),
//   "Subjects / Units":TrailInput(),
//   "Fees & Charges":TrailInput(),
//   "Boarding & Residency":TrailInput(),
//   "Scholarly Sessions":TrailInput(),
// };


List<Menus> menus = [

  Menus(imagePath: "people.svg", title: 'Student', widget: TrailInput()),
  Menus(imagePath: "airdrop.svg", title: 'Teachers', widget: Text('StudentsListr')),
  Menus(imagePath: "exam.svg", title: 'Examination', widget: TrailInput()),
  Menus(imagePath: "exam.svg", title: 'Grading System', widget: Text('StudentsListr')),
  Menus(imagePath: "document.svg", title: 'Results', widget: Text('StudentsListr')),
  Menus(imagePath: "book-saved.svg", title: 'Library', widget: Text('StudentsListr')),
  Menus(imagePath: "book-saved.svg", title: 'Class / Year', widget: Text('StudentsListr')),
  Menus(imagePath: "book-saved.svg", title: 'Stream', widget: Text('StudentsListr')),
  Menus(imagePath: "book-saved.svg", title: 'Subjects / Units', widget: Text('StudentsListr')),
  Menus(imagePath: "moneys.svg", title: 'Fees & Charges', widget: Text('StudentsListr')),
  Menus(imagePath: "book-saved.svg", title: 'Boarding & Residency', widget: Text('StudentsListr')),
  Menus(imagePath: "book-saved.svg", title: 'Boarding & Residency', widget: Text('StudentsListr')),



];


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
