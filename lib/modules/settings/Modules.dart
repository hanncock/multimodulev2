import 'package:flutter/material.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get.dart';
import '../../reusables/constants.dart';
import '../../reusables/controller.dart';

class Modules extends StatefulWidget {


  const Modules({super.key});

  @override
  State<Modules> createState() => _ModulesState();
}

class _ModulesState extends State<Modules> {


  Controller get controller => Get.find<Controller>(tag: "setup");

  List datalist = [];

  bool sideContent = false;

  Map<String,dynamic> row =  {};

  getCompanies()async{
    var resu = await auth.getvalues("api/setup/module/list");
    // print("values found are ${resu}");
    setState(() {
      datalist= resu;
    });
  }



  @override
  void initState(){

    super.initState();
    getCompanies();
    print("getting values");

  }



  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          Text('$datalist')
        ],
      ),
    );
  }
}
