import 'package:flutter/material.dart';
import 'package:multimodule/homepage.dart';
import 'package:multimodule/reusables/controller.dart';
import '../../commonLayout.dart';
import 'package:get/get.dart';
import '../../reusables/menu.dart';
import 'Charges.dart';
import 'coa.dart';

List<Menus> menus = [

  Menus(imagePath: "people.svg", title: 'C.O.A', widget: COA()),
  Menus(imagePath: "airdrop.svg", title: 'Charge Packages', widget: ChargePackages()),
  Menus(imagePath: "airdrop.svg", title: 'Payment Setup', widget: Text('Payment')),
  Menus(imagePath: "airdrop.svg", title: 'Invoices', widget: Text('Invoices')),



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
