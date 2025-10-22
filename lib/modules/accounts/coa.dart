import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:multimodule/Wrapper.dart';
import 'package:multimodule/modules/accounts/AccSetup.dart';
import '../../reusables/RoundedContainer.dart';
import '../../reusables/constants.dart';
import '../../reusables/controller.dart';
import '../../reusables/tablemaker.dart';


class COA extends StatefulWidget {
  const COA({super.key});

  @override
  State<COA> createState() => _COAState();
}

class _COAState extends State<COA>{
  late TabController tabController;

  Controller get controller => Get.find<Controller>(tag: "accounts");

  List accounts = [];

  bool sideContent = false;

  Map<String,dynamic> row =  {};

  getcoa()async{
    var resu = await auth.getvalues("api/finance/coa/list?companyId=${companyId}");
    // print("values found are ${resu}");
    setState(() {
      accounts= resu;
    });
  }



  @override
  void initState(){
    super.initState();
    getcoa();

  }

  @override

  Widget build(BuildContext context) {
    return SizedBox.expand(
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
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

              Expanded(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16.0),
                  child: TextField(
                    decoration: InputDecoration(
                      prefixIcon: Icon(Icons.search),
                      hintText: 'Search COA...',
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


          Expanded(
            child: Row(
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

                        "accTitle",
                        "accType",
                        "posting"

                      ],
                      formDataList: accounts,
                      onRowSelect: (selectedRow){

                        setState(() {
                          sideContent = !sideContent;
                          row = selectedRow;
                        });
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
                      SContainer(
                        color: Colors.blueAccent,
                        child: Center(child:  Text('Account Details',style: TextStyle(color: Colors.white,fontSize: 14),)),
                      ),
                      Expanded(
                        child: AccSetup(
                          editingRow: row,
                          onSaved: () {
                            getcoa(); // Refresh list
                            setState(() {
                              sideContent = false; // Optionally close the form after save
                            });
                          },
                        ),
                      ),
                    ],
                  ),
                ): SizedBox(child: Text(''),)
              ],
            ),
          )
        ],
      ),
    );
  }
}


