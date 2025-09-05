import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:multimodule/modules/settings/Modules.dart';
import 'package:multimodule/reusables/RoundedContainer.dart';
import 'package:multimodule/reusables/formbuilder.dart';

import '../../reusables/constants.dart';

class CompanySetup extends StatefulWidget {

  final VoidCallback? onSaved; // Add this in the constructor
  Map<String, dynamic>? editingRow;


  CompanySetup({this.editingRow, this.onSaved, super.key});

  // CompanySetup({this.editingRow,super.key});

  @override
  State<CompanySetup> createState() => _CompanySetupState();
}

class _CompanySetupState extends State<CompanySetup> {

  Map<String, dynamic> _formData = {};
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();


  Map<String, dynamic> formSchema={};

  List datalist = [];



  getFields()async{
    var resu = await auth.getvalues("apifields/setup/company");
    // print(resu);
    setState(() {
      formSchema = resu;
    });
  }

  getModules()async{
    var resu = await auth.getvalues("api/setup/module/list");
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
    getModules();
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
              buildField("CompanyName", formSchema, _formData),
              Row(
                children: [
                  Expanded(child: buildField("Reg No", formSchema, _formData)),
                  Expanded(child: buildField("Tax Pin", formSchema, _formData)),

                ],
              ),
              buildField("id", formSchema, _formData),
              buildField("NSSFNo", formSchema, _formData),
              Row(
                children: [
                  Expanded(child: buildField("Postal Code", formSchema, _formData)),
                  Expanded(child: buildField("Country", formSchema, _formData)),

                ],
              ),
              Row(
                children: [
                  Expanded(child: buildField("Town", formSchema, _formData)),
                  Expanded(child: buildField("Road /Street", formSchema, _formData)),
                ],
              ),
              Row(
                children: [
                  Expanded(child: buildField("Email", formSchema, _formData)),
                  Expanded(child: buildField("Phone", formSchema, _formData)),
                ],
              ),
              buildField("Position", formSchema, _formData),

              Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Divider(
                        thickness: 1,
                        color: Colors.red,
                      ),
                      Text('Modules'),
                      Divider(
                        thickness: 1,
                        color: Colors.red,
                      ),
                    ],
                  ),

                  Column(
                    children: [
                      Column(
                        children: List.generate(datalist.length, (index) {
                          final module = datalist[index];

                          // Check if the module is already in _formData['modules']
                          final isSelected = _formData['modules'].any((m) => m['module_id'] == module['module_id']);

                          return Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(module['moduleName']), // e.g., "Finance"

                              IconButton(
                                icon: Icon(
                                  isSelected ? Icons.toggle_on : Icons.toggle_off,
                                  color: isSelected ? Colors.green : Colors.grey,
                                  size: 36,
                                ),
                                onPressed: () {
                                  setState(() {
                                    if (isSelected) {
                                      // Remove the module if it's selected
                                      _formData['modules'].removeWhere(
                                            (m) => m['module_id'] == module['module_id'],
                                      );
                                    } else {
                                      // Add the module if it's not selected
                                      _formData['modules'].add({"company_id": "${_formData['company_id']}","module_id":"${module['module_id']}"});
                                    }
                                  });
                                },
                              ),
                              /*isSelected ? Icon(Icons.toggle_on_outlined,color: Colors.green,) :
                              Icon(Icons.toggle_off_outlined,color: Colors.grey,)*/
                              // If already selected, show ON switch (disabled)
                              /*if (isSelected)
                                const Switch(value: true, onChanged: null,activeColor: Colors.green,activeThumbImage: Colors.green,)  // disabled switch
                              else
                                Switch(
                                  value: false,
                                  onChanged: (value) {
                                    if (value) {
                                      // Add the module to _formData['modules']
                                      setState(() {
                                        _formData['modules'].add(module);
                                      });
                                    }
                                  },
                                ),*/
                            ],
                          );
                        }),
                      ),
                    ],
                  )


                  /*Column(
                    children: [
                      Text('${_formData['modules']}'),
                      Column(
                        children: List.generate(
                            datalist.length,(index){
                              return Container(
                                child: !_formData['modules'].isEmpty  ? Text('${_formData['modules'].indexWhere((elm)=> elm['module_id'] == datalist[index]['module_id'])}') :Text('is blank')  ,
                              );
                          // return _formData['modules'].contains(index)? Text('found') : Text('${datalist[index]}');
                        } ),
                      ),
                    ],
                  )*/

                  // Modules()

                ],
              ),


              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  InkWell(
                      onTap:()async{
                        if (_formKey.currentState!.validate()) {
                          // _formData['moduleName'] = "trial module";
                          print(_formData);
                          _formKey.currentState!.save();
                          var resu = await auth.saveMany(_formData, "/api/setup/company/add");
                          print("1 ${resu}");
                          print("2 ${resu['data']}");
                          print("3 ${resu['data']['success']}");
                          if(resu['data']['success'] == true){
                            _formData.clear();
                            _formKey.currentState!.reset();
                            // formSchema.clear();
                            // _formData.clear();
                            // print('data entered');
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

                ],
              ),

          ],
          ),
      ),
    );
  }
}


