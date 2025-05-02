import 'package:flutter/material.dart';

import '../../commonLayout.dart';

Map<String, Widget> menus ={
  "Dash":Text('School dash'),
  "Local":Text('school local'),
  "Welcome":Text('school welcome'),
};

class SchoolScreen extends StatelessWidget {
  const SchoolScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return CommonLayout(modMenus: menus,);
  }
}
