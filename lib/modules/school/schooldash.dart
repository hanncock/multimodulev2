import 'package:flutter/material.dart';
import 'package:multimodule/modules/school/trialInput.dart';
import 'package:multimodule/reusables/constants.dart';

import '../../commonLayout.dart';

Map<String, Widget> menus ={
  // "Dash":Text('School dash'),
  // "Students":Text('${sidebarController.selectedModule.value} Student'),
  "Students":TrailInput(),
  "Teachers":Text('${sidebarController.selectedModule.value} Teachers'),
};

class SchoolScreen extends StatelessWidget {
  const SchoolScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return CommonLayout(modMenus: menus,);
  }
}
