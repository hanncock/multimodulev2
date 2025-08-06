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

  // Controller get controller => Get.find<Controller>(tag: controller.selectedModule.value);

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

    // if (Get.isRegistered<Controller>(tag: "setup")) {
    //   final controller = Get.find<Controller>(tag: "setup");
    //   print("Controller found: ${controller}");
    // } else {
    //   print("Controller with tag 'Setup' not found!");
    // }


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

          /*Row(
            children: [
              InkWell(
                  onTap: (){
                    sideContent =! sideContent;
                    row.clear();
                    setState(() {});
                  },
                  child: Text('Add Company'))
            ],
          ),*/

          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              // Add Company Button
              ElevatedButton.icon(
                onPressed: () {
                  sideContent = !sideContent;
                  row.clear();
                  setState(() {});
                },
                icon: Icon(Icons.add_business),
                label: Text('Add Company'),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.blue,
                  foregroundColor: Colors.white,
                ),
              ),

              // Search Field
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16.0),
                  child: TextField(
                    decoration: InputDecoration(
                      prefixIcon: Icon(Icons.search),
                      hintText: 'Search companies...',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8.0),
                      ),
                      contentPadding: EdgeInsets.symmetric(vertical: 0, horizontal: 12),
                    ),
                    onChanged: (value) {
                      // Update search filter logic
                    },
                  ),
                ),
              ),

              // Delete Company Button
              ElevatedButton.icon(
                onPressed: () {
                  // Add delete logic here
                },
                icon: Icon(Icons.delete),
                label: Text('Delete'),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.red,
                  foregroundColor: Colors.white,
                ),
              ),
            ],
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
