import 'package:flutter/material.dart';

import '../../commonLayout.dart';

Map<String, Widget> menus ={
  "Dash":Text('accounts Dashboard'),
  "Local":Text('accnts local'),
  "Welcome":Text('acc Welcome'),
};

class Accounting extends StatelessWidget {
  const Accounting({super.key});

  @override
  Widget build(BuildContext context) {
    return CommonLayout(modMenus: menus,);
  }
}
