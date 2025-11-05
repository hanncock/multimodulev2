import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import '../../reusables/RoundedContainer.dart';
import '../../reusables/constants.dart';
import '../../reusables/controller.dart';
import '../../reusables/tablemaker.dart';
import 'companySetup.dart';

class Companies extends StatefulWidget {
  const Companies({super.key});

  @override
  State<Companies> createState() => _CompaniesState();
}

class _CompaniesState extends State<Companies>{
  late TabController tabController;

  Controller get controller => Get.find<Controller>(tag: "setup");

  List companies = [];

  bool sideContent = false;

  Map<String,dynamic> row =  {};

  getCompanies()async{
    var resu = await auth.getvalues("api/setup/company/list");
    // print("values found are ${resu}");
    setState(() {
      companies= resu;
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
      scrollDirection: Axis.vertical,
      child: Column(
        children: [

          Container(
            height: 50,
            color: Colors.white,
            padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 8),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                // Left side: Search and All dropdown (Placeholder)
                Row(
                  children: [
                    Container(
                      width: 250,
                      height: 35,
                      padding: const EdgeInsets.symmetric(horizontal: 10),
                      decoration: BoxDecoration(
                        color: const Color(0xFFF7F8FC),
                        borderRadius: BorderRadius.circular(8),
                        border: Border.all(color: const Color(0xFFE0E0E0)),
                      ),
                      child: const Row(
                        children: [
                          Icon(Icons.search, size: 18, color: Colors.black54),
                          SizedBox(width: 8),
                          Expanded(
                            child: TextField(
                              decoration: InputDecoration(
                                hintText: 'Search',
                                border: InputBorder.none,
                                isDense: true,
                                contentPadding: EdgeInsets.zero,
                                hintStyle: TextStyle(fontSize: 14, color: Colors.black54),
                              ),
                              style: TextStyle(fontSize: 14),
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(width: 15),
                    // 'All' Dropdown (Simplified)
                    Container(
                      height: 35,
                      padding: const EdgeInsets.symmetric(horizontal: 10),
                      decoration: BoxDecoration(
                        color: const Color(0xFFF7F8FC),
                        borderRadius: BorderRadius.circular(8),
                        border: Border.all(color: const Color(0xFFE0E0E0)),
                      ),
                      child: const Center(
                          child: Row(
                            children: [
                              Text('All', style: TextStyle(fontSize: 14)),
                              Icon(Icons.keyboard_arrow_down_sharp, size: 18),
                            ],
                          )),
                    ),
                  ],
                ),
                const Spacer(),
                ElevatedButton.icon(
                  onPressed: () {
                    sideContent = !sideContent;
                    row.clear();
                    setState(() {});
                  },
                  icon: const Icon(Icons.add, size: 18),
                  label: const Text("Company", style: TextStyle(fontSize: 13)),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: primaryPurple,
                    foregroundColor: Colors.white,
                    elevation: 0,
                    padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                  ),
                ),
              ],
            ),
          ),

          Row(
            children: [
              Expanded(
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    border: Border.all(width: 0.1)
                  ),
                  // padding: EdgeInsets.symmetric(vertical: 0,horizontal: 2),
                  width: MediaQuery.of(context).size.width,
                  height: MediaQuery.of(context).size.height * 0.9,
                  child: CustomTable(
                    headers: [
                      "company_id",
                      // "module_id",
                      "companyName",
                      "regNo",
                      "taxPin",
                      "postalCode",
                      "country",
                      "town",
                      "road",
                      "email",
                      "phone",
                      "position",
                    ],
                    formDataList: companies,
                    onRowSelect: (selectedRow){

                      setState(() {
                        sideContent = !sideContent;
                        row = selectedRow;
                        // CompanySetup(editingRow: row,);
                      });
                      // controller.addModule("Company Setup",CompanySetup(editingRow: selectedRow,));
                    },
                    fixedColumnCount: 2, ),
                ),
              ),
              sideContent ? SContainer(
                height: MediaQuery.of(context).size.height * 0.9,
                color: Colors.white,
                width: 550,
                // color: Colors.blueAccent,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Expanded(child: SContainer(
                          color: Colors.blueAccent,
                          child: Center(child:  Text('Company Details',style: TextStyle(color: Colors.white,fontSize: 14),)),
                        ),)
                      ],
                    ),
                    CompanySetup(
                      editingRow: row,
                      onSaved: () {
                        getCompanies(); // Refresh list
                        setState(() {
                          sideContent = false; // Optionally close the form after save
                        });
                      },
                    ),

                    // CompanySetup(editingRow: row,),
                  ],
                ),
              ): SizedBox(child: Text(''),)
            ],
          )
        ],
      ),
    );
  }
}

/*import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../reusables/constants.dart';
import '../../reusables/controller.dart';
import '../../reusables/tablemaker.dart';
import 'companySetup.dart';

class Companies extends StatefulWidget {
  const Companies({super.key});

  @override
  State<Companies> createState() => _CompaniesState();
}

class _CompaniesState extends State<Companies> {
  late TabController tabController;

  // Register and get the controller using the "Setup" tag
  Controller get controller => Get.find<Controller>(tag: "Setup");

  List companies = [];

  Future<void> getCompanies() async {
    var resu = await auth.getvalues("api/setup/company/list");
    setState(() {
      companies = resu;
    });
  }

  @override
  void initState() {
    super.initState();

    // ✅ Register the controller if not already registered
    if (!Get.isRegistered<Controller>(tag: "Setup")) {
      Get.put(Controller("Setup"), tag: "Setup");
    }

    getCompanies();
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: Axis.vertical,
      child: Column(
        children: [
          const Text('Another menu will go here'),
          Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              border: Border.all(width: 0.1),
            ),
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height * 0.9,
            child: CustomTable(
              headers: [
                "company_id",
                "module_id",
                "companyName",
                "regNo",
                "taxPin",
                "postalCode",
                "country",
                "town",
                "road",
                "email",
                "phone",
                "position",
              ],
              formDataList: companies,
              fixedColumnCount: 2,
              // ✅ Handle row selection and open form with data
              onRowSelect: (row) {
                print("Selected row: $row");
                controller.addModule(
                  "Edit Company",
                  CompanySetup(editingRow: row),
                  print(controller.moduleName.value)// Pass row to edit
                );
              },
            ),
          )
        ],
      ),
    );
  }
}*/
