import 'package:flutter/material.dart';
import 'package:multimodule/reusables/loader.dart';

import '../../Wrapper.dart';
import '../../reusables/RoundedContainer.dart';
import '../../reusables/constants.dart';
import '../../reusables/formbuilder.dart';

class AccSetup extends StatefulWidget {

  final VoidCallback? onSaved; // Add this in the constructor
  Map<String, dynamic>? editingRow;

  AccSetup({this.editingRow, this.onSaved, super.key});

  @override
  State<AccSetup> createState() => _AccSetupState();
}

class _AccSetupState extends State<AccSetup> {

  Map<String, dynamic> _formData = {};
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();


  Map<String, dynamic> formSchema={};



  getFields()async{
    var resu = await auth.getvalues("apifields/finance/coa");
    print('gotten fields are');
    print(resu);
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
  @override
  Widget build(BuildContext context) {
    return formSchema.isEmpty
        ? LoadingSpinCircle()
        : Form(
      key: _formKey,
      child: Column(
        children: [
          Expanded(
            child: SingleChildScrollView(
              padding: EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Container(width: 100,
                        child: buildField("AccCode", formSchema, _formData),
                      ),
                      Expanded(child: buildField("Title", formSchema, _formData)),
                    ],
                  ),
                  Row(
                    children: [
                      Expanded(child: buildField("Type", formSchema, _formData, [
                        {"label": "Header", "value": "Headers"},
                        {"label": "SubHeader", "value": "SubHeaders"},
                        {"label": "Posting", "value": "Posting"},
                      ])),
                      Expanded(child: buildField("Posting", formSchema, _formData, [
                        {"label": "YES", "value": "YES"},
                        {"label": "NO", "value": "NO"},
                      ])),
                    ],
                  ),
                  buildField("Grouping", formSchema, _formData),
                  // ... Add more fields if needed
                ],
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 12.0),
            child: InkWell(
              onTap: () async {
                if (_formKey.currentState!.validate()) {
                  _formKey.currentState!.save();
                  _formData.putIfAbsent("companyId", () => companyId);
                  var resu = await auth.saveMany(_formData, "/api/finance/coa/add");

                  if (resu['data']['success']) {
                    _formData.clear();
                    _formKey.currentState!.reset();
                  }

                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text('Form submitted!', style: TextStyle(color: Colors.red))),
                  );

                  if (widget.onSaved != null) widget.onSaved!();
                }
              },
              child: SContainer(
                color: Colors.blueAccent,
                child: Padding(
                  padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 50),
                  child: Text('Save', style: TextStyle(color: Colors.white)),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

// Widget build(BuildContext context) {
  //   return formSchema.isEmpty ? LoadingSpinCircle() :SingleChildScrollView(
  //     scrollDirection: Axis.vertical,
  //     child: Form(
  //       key: _formKey,
  //       child: Column(
  //         crossAxisAlignment: CrossAxisAlignment.start,
  //         children: [
  //           // Text('${formSchema}'),
  //           buildField("Title", formSchema, _formData),
  //           Row(
  //             children: [
  //               Expanded(child: buildField("Type", formSchema, _formData, ['Header','SubHeader'])),
  //               Expanded(child: buildField("Posting", formSchema, _formData, ["YES","NO"])),
  //             ],
  //           ),
  //           buildField("Grouping", formSchema, _formData),
  //           /*Row(
  //             children: [
  //               Expanded(child: buildField("Reg No", formSchema, _formData)),
  //               Expanded(child: buildField("Tax Pin", formSchema, _formData)),
  //
  //             ],
  //           ),
  //           buildField("id", formSchema, _formData),
  //           buildField("NSSFNo", formSchema, _formData),
  //           Row(
  //             children: [
  //               Expanded(child: buildField("Postal Code", formSchema, _formData)),
  //               Expanded(child: buildField("Country", formSchema, _formData)),
  //
  //             ],
  //           ),
  //           Row(
  //             children: [
  //               Expanded(child: buildField("Town", formSchema, _formData)),
  //               Expanded(child: buildField("Road /Street", formSchema, _formData)),
  //             ],
  //           ),
  //           Row(
  //             children: [
  //               Expanded(child: buildField("Email", formSchema, _formData)),
  //               Expanded(child: buildField("Phone", formSchema, _formData)),
  //             ],
  //           ),
  //           buildField("Position", formSchema, _formData),
  //
  //           Row(
  //             children: [
  //               Divider(
  //                 thickness: 1,
  //                 color: Colors.red,
  //               ),
  //               Text('Modules'),
  //               Divider(
  //                 thickness: 1,
  //                 color: Colors.red,
  //               ),
  //             ],
  //           ),*/
  //
  //
  //           Row(
  //             mainAxisAlignment: MainAxisAlignment.center,
  //             children: [
  //               InkWell(
  //                   onTap:()async{
  //                     if (_formKey.currentState!.validate()) {
  //                       // _formData['moduleName'] = "trial module";
  //                       print(_formData);
  //                       _formKey.currentState!.save();
  //                       _formData.putIfAbsent("companyId", () => companyId);
  //                       var resu = await auth.saveMany(_formData, "/api/finance/coa/add");
  //
  //                       if(resu['data']['success']){
  //                         _formData.clear();
  //                         _formKey.currentState!.reset();
  //                         // formSchema.clear();
  //                         // _formData.clear();
  //                         // print('data entered');
  //                       }
  //                       print('Form Data: $_formData');
  //                       ScaffoldMessenger.of(context).showSnackBar(
  //                         SnackBar(content: Text('Form submitted!',style: TextStyle(color: Colors.red),)),
  //                       );
  //
  //                       if (widget.onSaved != null) {
  //                         widget.onSaved!();
  //                       }
  //
  //                     }
  //                   } ,
  //                   child: SContainer(
  //                     color: Colors.blueAccent,
  //                     child: Padding(
  //                       padding: const EdgeInsets.symmetric(vertical: 4.0,horizontal: 50),
  //                       child: Text('Save',style: TextStyle(color: Colors.white),),
  //                     ),))
  //               // ElevatedButton(
  //               //   onPressed: () async{
  //               //     if (_formKey.currentState!.validate()) {
  //               //       _formKey.currentState!.save();
  //               //       var resu = await auth.saveMany(_formData, "/api/setup/company/add");
  //               //       print(resu);
  //               //      /* print('Form Data: $_formData');
  //               //       ScaffoldMessenger.of(context).showSnackBar(
  //               //         SnackBar(content: Text('Form submitted!',style: TextStyle(color: Colors.red),)),
  //               //       );*/
  //               //     }
  //               //   },
  //               //   child: Text('Submit'),
  //               // ),
  //             ],
  //           ),
  //
  //         ],
  //       ),
  //     ),
  //
  //   );
  // }
}
