import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:multimodule/modules/settings/companySetup.dart';

import '../../commonLayout.dart';
import '../../reusables/controller.dart';
import '../../reusables/menu.dart';
import '../../reusables/tablemaker.dart';
import 'companys.dart';

List<Menus> menus = [
  Menus(imagePath: "people.svg", title: 'Companys', widget: Companies()),
  Menus(imagePath: "people.svg", title: 'Company Setup', widget: CompanySetup()),
  // Menus(imagePath: "people.svg", title: 'Company AS', widget: MyTablePage()),
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


/*
import 'package:flutter/material.dart';

class CustomTable extends StatelessWidget {
  final List<String> headers;
  final List formDataList;
  final int fixedColumnCount;

  const CustomTable({
    required this.headers,
    required this.formDataList,
    this.fixedColumnCount = 1, // Number of fixed columns
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final fixedHeaders = headers.take(fixedColumnCount).toList();
    final scrollableHeaders = headers.skip(fixedColumnCount).toList();

    return Padding(
      padding: const EdgeInsets.all(4.0),
      child: Column(
        children: [
          // Header Row
          Container(
            padding: EdgeInsets.symmetric(horizontal: 4,vertical: 2),
            decoration: BoxDecoration(
                color: Colors.blueGrey[100],
                borderRadius:  BorderRadius.circular(10)
            ),
            // height: 400,
            child: Row(
              children: [
                // Fixed headers
                ...fixedHeaders.map((header) => Container(
                  width: 200,
                  padding: const EdgeInsets.all(12),
                  color: Colors.blueGrey[100],
                  child: Text(
                    header,
                    style: const TextStyle(
                        fontWeight: FontWeight.bold, fontSize: 16),
                  ),
                )),
                // Scrollable headers
                Expanded(
                  child: SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Row(
                      children: scrollableHeaders.map((header) {
                        return Container(
                          width: 200,
                          padding: const EdgeInsets.all(12),
                          color: Colors.blueGrey[100],
                          child: Text(
                            header,
                            style: const TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 16),
                          ),
                        );
                      }).toList(),
                    ),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 20),

          // Data Rows
          Expanded(
            child: ListView.builder(
              itemCount: formDataList.length,
              itemBuilder: (context, rowIndex) {
                final row = formDataList[rowIndex];
                return Row(
                  children: [
                    // Fixed columns
                    ...fixedHeaders.map((key) {
                      final value = row[key] ?? '';
                      return Container(
                        width: 200,
                        padding: const EdgeInsets.all(12),
                        decoration: BoxDecoration(
                          border: Border(
                            bottom: BorderSide(color: Colors.grey.shade300),
                          ),
                        ),
                        child: Text(value.toString()),
                      );
                    }),
                    // Scrollable columns
                    Expanded(
                      child: SingleChildScrollView(
                        scrollDirection: Axis.horizontal,
                        child: Row(
                          children: scrollableHeaders.map((key) {
                            final value = row[key] ?? '';
                            return Container(
                              width: 200,
                              padding: const EdgeInsets.all(12),
                              decoration: BoxDecoration(
                                border: Border(
                                  bottom:
                                  BorderSide(color: Colors.grey.shade300),
                                ),
                              ),
                              child: Text(value.toString()),
                            );
                          }).toList(),
                        ),
                      ),
                    ),
                  ],
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
*/

