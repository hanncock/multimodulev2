import 'package:flutter/material.dart';
import 'package:multimodule/Wrapper.dart';
import 'package:multimodule/reusables/loader.dart';

import '../../reusables/RoundedContainer.dart';
import '../../reusables/constants.dart';
import '../../reusables/formbuilder.dart';

class ChargesSetup extends StatefulWidget {

  final VoidCallback? onSaved; // Add this in the constructor
  Map<String, dynamic>? editingRow;

  ChargesSetup({this.editingRow, this.onSaved, super.key});

  @override
  State<ChargesSetup> createState() => _ChargesSetupState();
}

class _ChargesSetupState extends State<ChargesSetup> {

  Map<String, dynamic> _formData = {};
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();


  Map<String, dynamic> formSchema={};

  List dropdwnVals = [];

  List postingAcc = [];


  getFields()async{
    var resu = await auth.getvalues("apifields/finance/accpackage");
    print('gotten fields are');
    print(resu);
    setState(() {
      formSchema = resu;
    });
  }

  getPostingAcc()async{
    var resu = await auth.getvalues("api/finance/coa/list?Posting=YES&companyId=${companyId}");
    print('gotten posting fields are ');
    print(resu);

    // setState(() {
    //   postingAcc = resu.map((item) => {
    //     'label': "${item['acccode']} ${item['accTitle']}", // or whatever field you want to show
    //     'value': item['coa_id']    // or the value to save
    //   }).toList();
    // });

    setState(() {
      postingAcc = resu;
    });
  }

  getDrops()async{
    var resu = await auth.getvalues("apifields/finance/accpackage");
    print('gotten fields are');
    print(resu);
    setState(() {
      dropdwnVals = resu;
    });
  }


  @override
  void initState(){
    super.initState();
    if (widget.editingRow != null) {
      _formData = Map<String, dynamic>.from(widget.editingRow!);
    }
    getFields();
    getDrops();
    getPostingAcc();
  }


  @override
  Widget build(BuildContext context) {
    return formSchema.isEmpty ? LoadingSpinCircle() :SingleChildScrollView(
      scrollDirection: Axis.vertical,
      child: Form(
        key: _formKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Text('${formSchema}'),
            buildField("Acc Package Name", formSchema, _formData),
            buildField("Description", formSchema, _formData),
            buildField("Posting Acc", formSchema, _formData, postingAcc,['accTitle','grouping'],'coa_id'),
            buildField("amount", formSchema, _formData,),
            /*Row(
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
            ),*/


            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                InkWell(
                    onTap:()async{

                      //
                      // _formData.putIfAbsent("companyId", () => 1234);
                      //
                      // if (!_formData.containsKey("companyId")) {
                      //   _formData["companyId"] = 1234;
                      // }



                      if (_formKey.currentState!.validate()) {
                        // _formData['moduleName'] = "trial module";
                        print(_formData);
                        _formKey.currentState!.save();
                        _formData.putIfAbsent("companyId", () => companyId);
                        var resu = await auth.saveMany(_formData, "/api/finance/accpackage/add");
                        //
                        // if(resu['data']['success']){
                        //   _formData.clear();
                        //   _formKey.currentState!.reset();
                        //   // formSchema.clear();
                        //   // _formData.clear();
                        //   // print('data entered');
                        // }
                        print('Form Data: $_formData');
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(content: Text('Form submitted!',style: TextStyle(color: Colors.red),)),
                        );

                        if (widget.onSaved != null) {
                          widget.onSaved!();
                        }

                      }

                      print("FormData is ${_formData}");
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
