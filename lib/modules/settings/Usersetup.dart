import 'package:flutter/material.dart';
import 'package:multimodule/reusables/RoundedContainer.dart';
import 'package:multimodule/reusables/formbuilder.dart';
import 'package:multimodule/reusables/loader.dart';

import '../../reusables/constants.dart';

class UsersSetup extends StatefulWidget {

  final VoidCallback? onSaved;
  Map<String, dynamic>? editingRow;


  UsersSetup({this.editingRow, this.onSaved, super.key});


  @override
  State<UsersSetup> createState() => _UsersSetupState();
}

class _UsersSetupState extends State<UsersSetup> {

  Map<String, dynamic> _formData = {};
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();


  Map<String, dynamic> formSchema={};

  List datalist = [];



  getFields()async{
    var resu = await auth.getvalues("apifields/setup/user");
    // print(resu);
    setState(() {
      formSchema = resu;
    });
  }

  getCompanys()async{
    var resu = await auth.getvalues("api/setup/company/list");
    // print("values found are ${resu}");
    setState(() {
      datalist= resu;
    });
  }




  @override
  void initState(){
    super.initState();
    if (widget.editingRow != null) {
      _formData = Map<String, dynamic>.from(widget.editingRow!);
    }
    getFields();
    getCompanys();
  }

  @override
  Widget build(BuildContext context) {
    return formSchema.isEmpty ? Text('loading') :SingleChildScrollView(
      scrollDirection: Axis.vertical,
      child: Form(
        key: _formKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Text('${formSchema}'),
            // buildField("user", formSchema, _formData),
            Row(
              children: [
                Expanded(child: buildField("First Name", formSchema, _formData)),
                Expanded(child: buildField("Second Name", formSchema, _formData)),
                Expanded(child: buildField("Other NameS", formSchema, _formData)),

              ],
            ),
            Row(
              children: [
                Expanded(child: buildField("Gender", formSchema, _formData, ["Male", "Female"])),
                Expanded(child: buildField("IDNo/ PPTNo", formSchema, _formData)),

              ],
            ),
            Row(
              children: [
                Expanded(child: buildField("Town", formSchema, _formData)),
                Expanded(child: buildField("Country", formSchema, _formData)),
              ],
            ),
            Row(
              children: [
                Expanded(child: buildField("Email", formSchema, _formData)),
                Expanded(child: buildField("Phone", formSchema, _formData)),
              ],
            ),
            Row(
              children: [
                Expanded(child: buildField("Tax Pin", formSchema, _formData)),
                Expanded(child: buildField("Address", formSchema, _formData)),
              ],
            ),


            Container(
              height: 300,
              child: Column(
                children: [
                  Text('Companys'),
                  datalist.isEmpty ? LoadingSpinCircle():Expanded(
                    child: SingleChildScrollView(
                      child: Column(
                        children: List.generate(
                            growable:true,
                            datalist.length, (index) {
                          final module = datalist[index];
                      
                          // Check if the module is already in _formData['modules']
                          // final isSelected = _formData['companys'].any((m) => m['company_id'] == module['company_id']);

                          final isSelected = (_formData['companys'] as List?)?.any((m) => m['company_id'] == module['company_id']) ?? false;

                          return Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text("${index}, ${module['companyName'] ?? '-'}"), // e.g., "Finance"
                      
                              IconButton(
                                icon: Icon(
                                  // Icons.toggle_on,
                                  isSelected ? Icons.toggle_on : Icons.toggle_off,
                                  color: isSelected ? Colors.green : Colors.grey,
                                  size: 36,
                                ),
                                onPressed: () {
                                  setState(() {
                                    if (isSelected) {
                                      print('removing the module');

                                      // Remove the module if it's selected
                                      _formData['companys'].removeWhere(
                                            (m) => m['company_id'] == module['company_id'],
                                      );
                                    } else {
/*
                                      (_formData['companys'] ??= []).add({
                                        "company_id": "${ module['company_id'] ?? _formData['company_id']}",
                                        "user_id": "${_formData['user_id'] ?? }"
                                      });
                                      setState(() {});*/
                                      setState(() {
                                        _formData['companys'] ??= [];

                                        // Build map manually
                                        final Map<String, dynamic> entry = {
                                          "company_id": module['company_id'],
                                          "user_id":  _formData['user_id']
                                        };

                                        // Conditionally add user_id if not null
                                        // if (module['user_id'] != null) {
                                        //   entry["user_id"] = _formData['user_id'];
                                        // }

                                        _formData['companys'].add(entry);

                                        print("current fields are ${_formData['companys']}");
                                      });


                                    }
                                  });
                                },
                              ),
                            ],
                          );
                        }),
                      ),
                    ),
                  ),
                ],
              ),
            ),


            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                InkWell(
                    onTap:()async{
                      if (_formKey.currentState!.validate()) {
                        _formKey.currentState!.save();
                        print("form data is ${_formData}");
                        var resu = await auth.saveMany(_formData, "/api/setup/user/add");
                        print(resu);
                        if(resu['data']['success']){
                          _formData.clear();
                          _formKey.currentState!.reset();
                        }
                        print('Form Data: $_formData');
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(content: Text('Form submitted!',style: TextStyle(color: Colors.red),)),
                        );

                        if (widget.onSaved != null) {
                          widget.onSaved!();
                        }

                      }
                    } ,
                    child: SContainer(
                      color: Colors.blueAccent,
                      child: Padding(
                        padding: const EdgeInsets.symmetric(vertical: 4.0,horizontal: 50),
                        child: Text('Save',style: TextStyle(color: Colors.white),),
                      ),))
                // ElevatedButton(
                //   onPressed: () async{
                //     if (_formKey.currentState!.validate()) {
                //       _formKey.currentState!.save();
                //       var resu = await auth.saveMany(_formData, "/api/setup/Users/add");
                //       print(resu);
                //      /* print('Form Data: $_formData');
                //       ScaffoldMessenger.of(context).showSnackBar(
                //         SnackBar(content: Text('Form submitted!',style: TextStyle(color: Colors.red),)),
                //       );*/
                //     }
                //   },
                //   child: Text('Submit'),
                // ),
              ],
            ),

          ],
        ),
      ),
    );
  }
}


