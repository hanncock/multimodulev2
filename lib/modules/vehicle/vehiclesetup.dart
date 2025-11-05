import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:multimodule/modules/settings/Modules.dart';
import 'package:multimodule/reusables/RoundedContainer.dart';
import 'package:multimodule/reusables/formbuilder.dart';

import '../../reusables/constants.dart';
import '../../reusables/loader.dart';

class VehicleSetup extends StatefulWidget {

  final VoidCallback? onSaved; // Add this in the constructor
  Map<String, dynamic>? editingRow;


  VehicleSetup({this.editingRow, this.onSaved, super.key});

  // VehicleSetup({this.editingRow,super.key});

  @override
  State<VehicleSetup> createState() => _VehicleSetupState();
}

class _VehicleSetupState extends State<VehicleSetup> {

  Map<String, dynamic> _formData = {};
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();


  Map<String, dynamic> formSchema={};

  List datalist = [];



  getFields()async{
    var resu = await auth.getvalues("apifields/automotive/vehicle");
    // print(resu);
    setState(() {
      formSchema = resu;
    });
  }

  // getModules()async{
  //   var resu = await auth.getvalues("api/setup/module/list");
  //   // print("values found are ${resu}");
  //   setState(() {
  //     datalist= resu;
  //   });
  // }



  List fuelTypes = [
    {"value":"Petrol","label":"Petrol"},
    {"value":"Diesel","label":"Diesel"},
    {"value":"Electric","label":"Electric"},
    {"value":"Hybrid","label":"Hybrid"},
  ];

  List engineType = [
    {"value":"Manual","label":"Manual"},
    {"value":"Automatic","label":"Automatic"},
    {"value":"CVT","label":"CVT"},
    // {"value":"Hybrid","label":"Hybrid"},
  ];
  List manufactures = [
    {"value":"Toyota","label":"Toyota"},
    {"value":"Mazda","label":"Mazda"},
    {"value":"Rolls Royce","label":"Rolls Royce"},
    {"value":"Nissan","label":"Nissan"},
    {"value":"Mitsubishi","label":"Mitsubishi"},
    // {"value":"Hybrid","label":"Hybrid"},
  ];
  List bodyTypes = [
    {"value":"Saloon","label":"Saloon"},
    {"value":"Cedan","label":"Cedan"},
    {"value":"SUV","label":"SUV"},

    // {"value":"Hybrid","label":"Hybrid"},
  ];




  @override
  void initState(){
    super.initState();
    if (widget.editingRow != null) {
      _formData = Map<String, dynamic>.from(widget.editingRow!);
    }
    getFields();
    // getModules();
  }

  @override
  Widget build(BuildContext context) {
    return formSchema.isEmpty ? LoadingSpinCircle() :Container(
      height: MediaQuery.of(context).size.height * 0.82,
      child: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start, // recommended for alignment
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: const Text(
                      'Vehicle Information',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 14,
                      ),
                    ),
                  ),
                  const SizedBox(height: 8), // spacing between title and card

                  Card(
                    elevation: 8,
                    color: Colors.white,
                    child: Padding(
                      padding: const EdgeInsets.all(12.0), // gives breathing room inside card
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          buildField("Name", formSchema, _formData),
                          const SizedBox(height: 10),
                          Row(
                            children: [
                              Expanded(
                                child: buildField("VIN", formSchema, _formData),
                              ),
                              const SizedBox(width: 10), // space between the two fields
                              Expanded(
                                child: buildField("Chasis No", formSchema, _formData),
                              ),
                            ],
                          ),
                          Row(
                            children: [
                              Expanded(
                                child: buildField("Color", formSchema, _formData),
                              ),
                              const SizedBox(width: 10), // space between the two fields
                              Expanded(
                                child: buildField("Milleage", formSchema, _formData),
                              ),
                            ],
                          ),

                        ],
                      ),
                    ),
                  ),
                ],
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start, // recommended for alignment
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: const Text(
                      'Vehicle Classification',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 14,
                      ),
                    ),
                  ),
                  const SizedBox(height: 8), // spacing between title and card

                  Card(
                    elevation: 8,
                    color: Colors.white,
                    child: Padding(
                      padding: const EdgeInsets.all(12.0), // gives breathing room inside card
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [

                          Row(
                            children: [
                              Expanded(child: buildField("Transmissions", formSchema, _formData, engineType)),
                              Expanded(child: buildField("Fuel Type", formSchema, _formData, fuelTypes,'label','value')),
                            ],
                          ),


                          const SizedBox(height: 10),
                          Row(
                            children: [
                              Expanded(child: buildField("Body Type", formSchema, _formData, bodyTypes)),

                              // const SizedBox(width: 10), // space between the two fields
                              // Expanded(
                              //   child: buildField("Man. Year", formSchema, _formData),
                              // ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start, // recommended for alignment
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: const Text(
                      'Manufacturing Details',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 14,
                      ),
                    ),
                  ),
                  const SizedBox(height: 8), // spacing between title and card

                  Card(
                    elevation: 8,
                    color: Colors.white,
                    child: Padding(
                      padding: const EdgeInsets.all(12.0), // gives breathing room inside card
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const SizedBox(height: 10),
                          Row(
                            children: [
                              Expanded(child: buildField("Model", formSchema, _formData, manufactures)),

                              const SizedBox(width: 10), // space between the two fields
                              Expanded(
                                child: buildField("Man. Year", formSchema, _formData),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 10,),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  InkWell(
                      onTap:()async{
                        if (_formKey.currentState!.validate()) {
                          // _formData['moduleName'] = "trial module";
                          print(_formData);
                          _formKey.currentState!.save();
                          var resu = await auth.saveMany(_formData, "/api/automotive/vehicle/add");
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
      ),
    );
  }
}


