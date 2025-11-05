import 'package:flutter/material.dart';
import 'package:multimodule/reusables/loader.dart';

import '../../Wrapper.dart';
import '../../reusables/RoundedContainer.dart';
import '../../reusables/constants.dart';
import '../../reusables/formbuilder.dart';

class NewInvoice extends StatefulWidget {

  final VoidCallback? onSaved; // Add this in the constructor
  Map<String, dynamic>? editingRow;

  NewInvoice({this.editingRow, this.onSaved, super.key});

  @override
  State<NewInvoice> createState() => _NewInvoiceState();
}

class _NewInvoiceState extends State<NewInvoice> {

  Map<String, dynamic> _formData = {};
  Map<String, dynamic> _invlines_formData = {};
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();


  Map<String, dynamic> formSchema={};
  Map<String, dynamic> inv_line_formSchema={};

  List customers = [];

  List chargePackages = [];


  getCustomers()async{
    var resu = await auth.getvalues("api/finance/customer/list");
    print("values found customers are ");
    setState(() {
      customers= resu;
    });
  }



  getFields()async{
    var resu = await auth.getvalues("apifields/finance/invoice");
    setState(() {
      formSchema = resu;
    });
  }

  getInvLines()async{
    // var resu = await auth.getvalues("apifields/finance/invline");
    var resu = await auth.getvalues("apifields/finance/invoiceline");
    print("inbvlines are ");

    setState(() {
      inv_line_formSchema = resu;
    });
  }

  getChargePackages()async{
    var resu = await auth.getvalues("api/finance/accpackage/list");
    print("charges are ${resu}");
    setState(() {
      chargePackages= resu;
    });
  }



  @override
  void initState(){
    super.initState();
    if (widget.editingRow != null) {
      _formData = Map<String, dynamic>.from(widget.editingRow!);
    }
    getInvLines();

    getFields();
    getCustomers();

    getChargePackages();
  }


  @override
  @override
  Widget build(BuildContext context) {
    return formSchema.isEmpty
        ? LoadingSpinCircle()
        : Row(
          children: [
            Container(
              width: 550,
              child: Card(
                elevation: 8,
                child: Column(
                  children: [
                    Text('Invoice Sample'),
                    Text('${_invlines_formData}')
                  ],
                ),
              ),
            ),
            Expanded(
              child: Form(
                    key: _formKey,
                    child: Column(
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Container(
                            width: 300,
                            child: buildField("Invoice No", formSchema, _formData)
                        ),
                        Expanded(child: buildField("Charged To", formSchema, _formData,customers,['Names','cust_accNo'],'customer_id')),
                      ],
                    ),
                    // buildField("Invoice No", formSchema, _formData),
                    // buildField("Charged To", formSchema, _formData),
                    buildField("Description", formSchema, _formData),
                    SizedBox(
                        width: 300,
                        child: buildField("Due Date", formSchema, _formData)),
              
                    /*Row(
                      children: [
                        Expanded(child: buildField("email", formSchema, _formData)),
                        Expanded(child: buildField("phone", formSchema, _formData)),
                      ],
                    ),
                    Row(
                      children: [
                        Expanded(child: buildField("address", formSchema, _formData)),
                        Expanded(child: buildField("Country", formSchema, _formData)),
                      ],
                    ),
                    buildField("VAT/PIN No", formSchema, _formData),
              
                    Column(
                      children: [
                        Divider(thickness: 0.1,color: Colors.black,),
                        Row(
                          children: [
                            Expanded(child: buildField("Contact Person", formSchema, _formData)),
                            Expanded(child: buildField("Contact Person Phone", formSchema, _formData)),
                          ],
                        )
                      ],
                    )*/
                    // Row(
                    //   children: [
                    //     Expanded(child: buildField("Type", formSchema, _formData, [
                    //       {"label": "Header", "value": "Headers"},
                    //       {"label": "SubHeader", "value": "SubHeaders"},
                    //       {"label": "Posting", "value": "Posting"},
                    //     ])),
                    //     Expanded(child: buildField("Posting", formSchema, _formData, [
                    //       {"label": "YES", "value": "YES"},
                    //       {"label": "NO", "value": "NO"},
                    //     ])),
                    //   ],
                    // ),
                    // buildField("Grouping", formSchema, _formData),
                    // ... Add more fields if needed
                  ],
                ),
                Container(
                  child: Column(
                    children: [
                      Text('Invoice Lines'),
                      buildField("Invoice No", formSchema, _formData),
                      inv_line_formSchema.isEmpty || chargePackages.isEmpty
                          ? LoadingSpinCircle()
                          :
                          Container(
                            margin: EdgeInsets.all(4),
                            padding: EdgeInsets.all(10),
                            child: Column(
                              children: [
                                Row(
                                  children: [
                                    Expanded(
                                      child: Row(
                                        children: [
                                          // Text('${inv_line_formSchema}'),
                                          Expanded(child: buildField("Charge Package", inv_line_formSchema, _invlines_formData,chargePackages,['accpackageName','grouping'],'accpackage_id')),
                                          Expanded(child: buildField("Description", inv_line_formSchema, _invlines_formData)),
                                          Expanded(child: buildField("Unit Amount", inv_line_formSchema, _invlines_formData)),
                                          Expanded(child: buildField("Quantity", inv_line_formSchema, _invlines_formData,)),
                                          // Expanded(child: buildField("Charge Package", inv_line_formSchema, _formData,['Names','cust_accNo'],'customer_id')),
              
                                          // Expanded(child: buildField("Contact Person Phone", formSchema, _formData)),
                                        ],
                                      ),
                                    ),
                                    ElevatedButton.icon(
                                      onPressed: () {
                                        _formData['invlines'].add(_invlines_formData);
                                        // sideContent = !sideContent;
                                        // row.clear();
                                        // setState(() {});
                                      },
                                      icon: const Icon(Icons.add, size: 18),
                                      label: const Text("", style: TextStyle(fontSize: 13)),
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
                                Divider(thickness: 0.1,)
                              ],
                            ),
              
                          )
              
                    ],
                  )
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 12.0),
                  child: InkWell(
                    onTap: () async {
                      print(_formData);
                      if (_formKey.currentState!.validate()) {
                        _formKey.currentState!.save();
                        _formData.putIfAbsent("companyId", () => companyId);
                        var resu = await auth.saveMany(_formData, "/api/finance/invoice/add");
              
                        if (resu['data']?['success'] == true) {
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
                  ),
            ),
          ],
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
