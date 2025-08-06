import 'dart:convert';

import 'package:flutter/material.dart';
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



  getFields()async{
    var resu = await auth.getvalues("apifields/setup/company");
    // print(resu);
    setState(() {
      formSchema = resu;
    });
  }


  @override
  void initState(){
    super.initState();
    if (widget.editingRow != null) {
      _formData = Map<String, dynamic>.from(widget.editingRow!);
    }
    getFields();
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

                          if(resu['data'][0]['success']){
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
                  // ElevatedButton(
                  //   onPressed: () async{
                  //     if (_formKey.currentState!.validate()) {
                  //       _formKey.currentState!.save();
                  //       var resu = await auth.saveMany(_formData, "/api/setup/company/add");
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


