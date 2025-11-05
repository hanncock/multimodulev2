import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import '../../reusables/RoundedContainer.dart';
import '../../reusables/constants.dart';
import '../../reusables/controller.dart';
import '../../reusables/tablemaker.dart';
import 'Usersetup.dart';
import 'companySetup.dart';

class Users extends StatefulWidget {
  const Users({super.key});

  @override
  State<Users> createState() => _UsersState();
}

class _UsersState extends State<Users>{
  late TabController tabController;

  Controller get controller => Get.find<Controller>(tag: "setup");

  List Users = [];

  bool sideContent = false;

  String cnt = "";

  Map<String,dynamic> row =  {};

  getUsers()async{
    var resu = await auth.getvalues("api/setup/user/list");
    // print("values found are ${resu}");
    setState(() {
      Users= resu;
    });
  }



  @override
  void initState(){

    super.initState();
    getUsers();
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
                                hintText: 'User',
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
                      "user_id",
                      // "module_id",
                      "firstName",
                      "secondName",
                      "otherName",
                      "country",
                      "town",
                      "road",
                      "email",
                      "phone",
                      "company",
                    ],
                    formDataList: Users,
                    popupActions: [
                      // Show Popup Dialog
                      PopupMenuAction(
                        label: 'Create / Reset Credentials',
                        onTap: (rowData) async{

                          final Map<String, dynamic> data = {
                            "userName":"${rowData['email']}",
                            "password":"soke123",
                            // "company_id": module['company_id'],
                            "user_id":  rowData['user_id']
                          };

                          print(data);

                          var resu = await auth.saveMany(data, "/api/setup/auth/add");
                          print(resu);

                          /*showDialog(
                            context: context,
                            builder: (_) => AlertDialog(
                              title: Text("Hello"),
                              content: Text("You selected: ${rowData['Name']}"),
                              actions: [
                                TextButton(
                                  onPressed: () => Navigator.pop(context),
                                  child: Text("OK"),
                                ),
                              ],
                            ),
                          );*/
                        },
                      ),

                    ],
                    // callme: (rowData)async{
                    //   var resu = await auth.delMany("${rowData}", '/api/setup/users/del');
                    //   print(resu);
                    //   // print('Row data: $rowData');
                    //   // setState(() {
                    //   //   delcallback = "delting";
                    //   // });
                    // },
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
                child: Expanded(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Expanded(child: SContainer(
                            color: Colors.blueAccent,
                            child: Center(child:  Text('User Details',style: TextStyle(color: Colors.white,fontSize: 14),)),
                          ),)
                        ],
                      ),
                      UsersSetup(
                        editingRow: row,
                        onSaved: () {
                          getUsers(); // Refresh list
                          setState(() {
                            sideContent = false; // Optionally close the form after save
                          });
                        },
                      ),
                
                      // CompanySetup(editingRow: row,),
                    ],
                  ),
                ),
              ): SizedBox(child: Text(''),)
            ],
          )
        ],
      ),
    );
  }
}