import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:multimodule/modules/accounts/AccSetup.dart';
import 'package:multimodule/modules/accounts/ChargesSetup.dart';
import '../../reusables/RoundedContainer.dart';
import '../../reusables/constants.dart';
import '../../reusables/controller.dart';
import '../../reusables/tablemaker.dart';


class ChargePackages extends StatefulWidget {
  const ChargePackages({super.key});

  @override
  State<ChargePackages> createState() => _ChargePackagesState();
}

class _ChargePackagesState extends State<ChargePackages>{
  late TabController tabController;

  Controller get controller => Get.find<Controller>(tag: "accounts");

  List accounts = [];

  bool sideContent = false;

  Map<String,dynamic> row =  {};

  getChargePackages()async{
    var resu = await auth.getvalues("api/finance/accpackage/list");
    // print("values found are ${resu}");
    setState(() {
      accounts= resu;
    });
  }



  @override
  void initState(){
    super.initState();
    getChargePackages();

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
                label: Text('Add Package'),
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
                      hintText: 'Search ChargePackages...',
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
                      // "ChargePackages_id",
                      // "module_id",
                      "accpackage_id",
                      "accpackageName",
                      "description",
                      "amount",
                      // "regNo",
                      // "taxPin",
                      // "postalCode",
                      // "country",
                      // "town",
                      // "road",
                      // "email",
                      // "phone",
                      // "position",
                    ],
                    formDataList: accounts,
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
                          child: Center(child:  Text('Account Details',style: TextStyle(color: Colors.white,fontSize: 14),)),
                        ),)
                      ],
                    ),

                   ChargesSetup(
                     editingRow: row,
                     onSaved: () {
                       getChargePackages(); // Refresh list
                       setState(() {
                         sideContent = false; // Optionally close the form after save
                       });
                     },
                   )
                   /* AccSetup(
                      editingRow: row,
                      onSaved: () {
                        getChargePackages(); // Refresh list
                        setState(() {
                          sideContent = false; // Optionally close the form after save
                        });
                      },
                    ),*/

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