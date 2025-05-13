import 'package:flutter/material.dart';

import '../../commonLayout.dart';
import '../../reusables/constants.dart';

Map<String, Widget> menus ={
  // "Dash":Text('accounts Dashboard'),
  // "COA":Text('${sidebarController.selectedModule.value}, COA'),
  // "Invoices":Text('${sidebarController.selectedModule.value}, Invoices'),
};

class Accounting extends StatelessWidget {
  const Accounting({super.key});

  @override
  Widget build(BuildContext context) {
    return CommonLayout(modMenus: menus,tagline: 'Accounts',);
  }
}
