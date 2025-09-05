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
                label: Text('Add User'),
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
                      hintText: 'Search Users...',
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
              ElevatedButton.icon(
                onPressed: () async{
                  print("${row}");
                  // Map<String, dynamic> cred = {
                  //   "id":
                  //   "username":,
                  //   "password":"",
                  //   "user_id":,
                  // };
                  //
                  // var resu = await auth.saveMany(cred, "/api/setup/auth/add");
                  // Add delete logic here
                },
                icon: Icon(Icons.settings),
                label: Text('Create Acc'),
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
              ): SizedBox(child: Text(''),)
            ],
          )
        ],
      ),
    );
  }
}