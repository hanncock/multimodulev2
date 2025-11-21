import 'package:flutter/material.dart';
import 'package:get/get_utils/get_utils.dart';
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


  // updateLineTotal([Map<String, dynamic>? values]) {
  // updateLineTotal(List? values) {
  updateLineTotal(String? values) {

    // _invlines_formData['unitAmount'] = values?[0]['unitAmount'];
    // _invlines_formData['invLineDescr'] = values?[0]['description'];


    final selectedPackage = chargePackages.firstWhereOrNull(
          (pkg) => pkg['accpackage_id'].toString() == values.toString(),
    );

    if (selectedPackage != null) {
      setState(() {
        _invlines_formData['accpackage_id'] = selectedPackage['accpackage_id'];
        // _invlines_formData['chargedPackage'] = selectedPackage['accpackageName'];
        _invlines_formData['invLineDescr'] = selectedPackage['description'];
        _invlines_formData['unitAmnt'] = selectedPackage['amount']?.toString() ?? '0';
      });
    }

    // final unitAmount = double.tryParse(_invlines_formData['unitAmount']?.toString() ?? '0') ?? 0;
    // final qty = double.tryParse(_invlines_formData['quantity']?.toString() ?? '0') ?? 0;
    //
    // _invlines_formData['lineTotal'] = (unitAmount * qty).toStringAsFixed(2);
    //
    //
    // _invlines_formData['lineTotal'] = (unitAmount * qty).toStringAsFixed(2);
    //
    // // Example: auto-fill description based on package
    // final packageId = _invlines_formData['accpackage_id'];
    // final selected = chargePackages.firstWhereOrNull((p) => p['accpackage_id'].toString() == packageId);
    //
    // if (selected != null) {
    //   _invlines_formData['description'] = selected['accpackageName'];
    // }

    // If you're using GetX or setState, update the UI here:
    setState(() {});
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
                Text('${_invlines_formData}'),
                Text('${_formData}')
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
                        inv_line_formSchema.isEmpty || chargePackages.isEmpty
                            ? LoadingSpinCircle()
                            :
                        /*Container(
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
                                        // Expanded(child: buildField("Charge Package", inv_line_formSchema, _invlines_formData,chargePackages,['accpackageName','grouping'],'accpackage_id',updateLineTotal(chargePackages))),
                                        Expanded(child: buildField("Charge Package", inv_line_formSchema, _invlines_formData,chargePackages,['accpackageName','grouping'],'accpackage_id',(selectedValue) => updateLineTotal(selectedValue))),
                                        Expanded(child: buildField("Description", inv_line_formSchema, _invlines_formData)),
                                        Expanded(child: buildField("Unit Amount", inv_line_formSchema, _invlines_formData,updateLineTotal(null))),
                                        Expanded(child: buildField("Quantity", inv_line_formSchema, _invlines_formData,)),
                                        // Expanded(child: buildField("Charge Package", inv_line_formSchema, _formData,['Names','cust_accNo'],'customer_id')),

                                        // Expanded(child: buildField("Contact Person Phone", formSchema, _formData)),
                                      ],
                                    ),
                                  ),
                                  ElevatedButton.icon(
                                    onPressed: () {
                                      print("formdata valuea are $_formData");

                                      _formData.putIfAbsent("invoicelines", () => []);
                                      _formData['invoicelines'].add(_invlines_formData);
                                      // sideContent = !sideContent;
                                      // row.clear();
                                      setState(() {});
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
                              Divider(thickness: 0.1,),
                              // _formData['invlines'] != null ? ..._formData['invlines'].map((line) => Text('${line}')) :[Text('Add invLInes')]

                              // _invlines_formData

                             *//* (_formData.containsKey('invoicelines') && _formData['invoicelines'] != null && _formData['invoicelines'].isNotEmpty)
                                  ? _formData['invoicelines'].map((linerr) => Text("${linerr}"))
                                  : [Text('Add invLines')],*//*

                              (_formData.containsKey('invoicelines') &&
                                  _formData['invoicelines'] != null &&
                                  _formData['invoicelines'].isNotEmpty)
                                  ?
                                  Column(
                                    children: _formData['invoicelines'].map<Widget>((line) =>Row(
                                      children: [
                                        Text('${line}')
                                      ],
                                    )).toList() ,
                                  )
                              *//* Column(
                                children: _formData['invoicelines']
                                    .map<Widget>((line) => ListTile(
                                  dense: true,
                                  title: Text(line['invLineDescr'] ?? '—'),
                                  subtitle: Text(
                                      'Qty: ${line['quantity'] ?? 0} × ${line['unitAmount'] ?? 0}'),
                                  trailing: Text(
                                    '${line['lineTotal'] ?? 0}',
                                    style: TextStyle(fontWeight: FontWeight.bold),
                                  ),
                                ))
                                    .toList(),
                              )*//*
                                  : Text('Add invLines'),


                              Text('${_formData}')


                              *//* ..._formData['invlines'].map((line) => ListTile(
                                  dense: true,
                                  contentPadding: EdgeInsets.zero,
                                  title: Text(line['description'] ?? ''),
                                  subtitle: Text(
                                      'Qty: ${line['quantity'] ?? '0'} × ${line['unitAmount'] ?? '0'}'),
                                  trailing:
                                  Text('= ${line['lineTotal'] ?? '0.00'}', style: const TextStyle(fontWeight: FontWeight.bold)),
                                )),*//*
                            ],
                          ),

                        )*/

                        (_formData.containsKey('invoicelines') &&
                            _formData['invoicelines'] != null &&
                            _formData['invoicelines'].isNotEmpty)
                            ?
                        Container(
                          height: 500,
                          width: MediaQuery.of(context).size.width * 0.6,
                          child: Row(
                            children: [
                              ElevatedButton.icon(
                                onPressed: () {
                                  print("formdata valuea are $_formData");

                                  _formData.putIfAbsent("invoicelines", () => []);
                                  _formData['invoicelines'].add(_invlines_formData);
                                  // sideContent = !sideContent;
                                  // row.clear();
                                  setState(() {});
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
                              Column(
                                children: _formData['invoicelines'].map<Widget>((line) =>Expanded(child:Row(
                                  children: [
                                    Container(
                                        height: 400,
                                        width: MediaQuery.of(context).size.width * 0.5,
                                        margin: EdgeInsets.all(4),
                                        padding: EdgeInsets.all(10),
                                        child: Expanded(
                                          child: Row(
                                            children: [
                                              // Text('${inv_line_formSchema}'),
                                              // Expanded(child: buildField("Charge Package", inv_line_formSchema, _invlines_formData,chargePackages,['accpackageName','grouping'],'accpackage_id',updateLineTotal(chargePackages))),
                                              Expanded(child: buildField("Charge Package", inv_line_formSchema, _invlines_formData,chargePackages,['accpackageName','grouping'],'accpackage_id',(selectedValue) => updateLineTotal(selectedValue))),
                                              Expanded(child: buildField("Description", inv_line_formSchema, _invlines_formData)),
                                              Expanded(child: buildField("Unit Amount", inv_line_formSchema, _invlines_formData,updateLineTotal(null))),
                                              Expanded(child: buildField("Quantity", inv_line_formSchema, _invlines_formData,)),
                                              // Expanded(child: buildField("Charge Package", inv_line_formSchema, _formData,['Names','cust_accNo'],'customer_id')),

                                              // Expanded(child: buildField("Contact Person Phone", formSchema, _formData)),
                                            ],
                                          ),
                                        ))
                                  ],
                                ))).toList() ,
                              ),
                            ],
                          ),
                        ):

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
                                            // Expanded(child: buildField("Charge Package", inv_line_formSchema, _invlines_formData,chargePackages,['accpackageName','grouping'],'accpackage_id',updateLineTotal(chargePackages))),
                                            Expanded(child: buildField("Charge Package", inv_line_formSchema, _invlines_formData,chargePackages,['accpackageName','grouping'],'accpackage_id',(selectedValue) => updateLineTotal(selectedValue))),
                                            Expanded(child: buildField("Description", inv_line_formSchema, _invlines_formData)),
                                            Expanded(child: buildField("Unit Amount", inv_line_formSchema, _invlines_formData,updateLineTotal(null))),
                                            Expanded(child: buildField("Quantity", inv_line_formSchema, _invlines_formData,)),
                                            // Expanded(child: buildField("Charge Package", inv_line_formSchema, _formData,['Names','cust_accNo'],'customer_id')),

                                            // Expanded(child: buildField("Contact Person Phone", formSchema, _formData)),
                                          ],
                                        ),
                                      ),
                                      ElevatedButton.icon(
                                        onPressed: () {
                                          print("formdata valuea are $_formData");

                                          _formData.putIfAbsent("invoicelines", () => []);
                                          _formData['invoicelines'].add(_invlines_formData);
                                          // sideContent = !sideContent;
                                          // row.clear();
                                          setState(() {});
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
                                ]
                            )
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
/*import 'package:flutter/material.dart';
import 'package:get/get_utils/get_utils.dart';
import '../../Wrapper.dart';
import '../../reusables/RoundedContainer.dart';
import '../../reusables/constants.dart';
import '../../reusables/formbuilder.dart';
import '../../reusables/loader.dart';

class NewInvoice extends StatefulWidget {
  final VoidCallback? onSaved;
  final Map<String, dynamic>? editingRow;

  const NewInvoice({this.editingRow, this.onSaved, super.key});

  @override
  State<NewInvoice> createState() => _NewInvoiceState();
}

class _NewInvoiceState extends State<NewInvoice> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  Map<String, dynamic> _formData = {};
  Map<String, dynamic> _invlines_formData = {};
  List<Map<String, dynamic>> _invoiceLines = [];

  Map<String, dynamic> formSchema = {};
  Map<String, dynamic> inv_line_formSchema = {};

  List customers = [];
  List chargePackages = [];

  // ───────────────────────────────────────────────────────────────
  // API DATA FETCHERS
  // ───────────────────────────────────────────────────────────────
  Future<void> getCustomers() async {
    var resu = await auth.getvalues("api/finance/customer/list");
    setState(() => customers = resu);
  }

  Future<void> getFields() async {
    var resu = await auth.getvalues("apifields/finance/invoice");
    setState(() => formSchema = resu);
  }

  Future<void> getInvLines() async {
    var resu = await auth.getvalues("apifields/finance/invoiceline");
    setState(() => inv_line_formSchema = resu);
  }

  Future<void> getChargePackages() async {
    var resu = await auth.getvalues("api/finance/accpackage/list");
    setState(() => chargePackages = resu);
  }

  // ───────────────────────────────────────────────────────────────
  // LOGIC: AUTO-UPDATE LINE TOTALS & DESCRIPTION
  // ───────────────────────────────────────────────────────────────
  void updateLineTotal() {
    final unitAmount =
        double.tryParse(_invlines_formData['unitAmount']?.toString() ?? '0') ?? 0;
    final qty =
        double.tryParse(_invlines_formData['quantity']?.toString() ?? '0') ?? 0;

    _invlines_formData['lineTotal'] = (unitAmount * qty).toStringAsFixed(2);

    final packageId = _invlines_formData['accpackage_id'];
    final selected = chargePackages.firstWhereOrNull(
            (p) => p['accpackage_id'].toString() == packageId);

    if (selected != null) {
      _invlines_formData['description'] = selected['accpackageName'];
    }

    setState(() {});
  }

  // ───────────────────────────────────────────────────────────────
  // INIT
  // ───────────────────────────────────────────────────────────────
  @override
  void initState() {
    super.initState();
    if (widget.editingRow != null) {
      _formData = Map<String, dynamic>.from(widget.editingRow!);
    }
    getFields();
    getInvLines();
    getCustomers();
    getChargePackages();
  }

  // ───────────────────────────────────────────────────────────────
  // UI: INVOICE PREVIEW PANEL (LEFT)
  // ───────────────────────────────────────────────────────────────
  Widget _buildInvoicePreview() {
    return Card(
      elevation: 8,
      margin: const EdgeInsets.all(8),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: _invoiceLines.isEmpty && _formData.isEmpty
            ? const Center(child: Text('Invoice Preview'))
            : Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'INVOICE',
              style: TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                  color: Colors.deepPurple),
            ),
            const Divider(),
            Text('Invoice No: ${_formData['invoiceNo'] ?? '—'}'),
            Text('Customer: ${_formData['customer_id'] ?? '—'}'),
            Text('Due Date: ${_formData['dueDate'] ?? '—'}'),
            const SizedBox(height: 10),
            const Text(
              'Invoice Lines:',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 5),
            ..._invoiceLines.map((line) => ListTile(
              dense: true,
              contentPadding: EdgeInsets.zero,
              title: Text(line['description'] ?? ''),
              subtitle: Text(
                  'Qty: ${line['quantity'] ?? '0'} × ${line['unitAmount'] ?? '0'}'),
              trailing:
              Text('= ${line['lineTotal'] ?? '0.00'}', style: const TextStyle(fontWeight: FontWeight.bold)),
            )),
            const Divider(),
            Align(
              alignment: Alignment.centerRight,
              child: Text(
                'Grand Total: ${_invoiceLines.fold<double>(0, (sum, l) => sum + double.tryParse(l['lineTotal'] ?? '0')!)}',
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                  color: Colors.green,
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  // ───────────────────────────────────────────────────────────────
  // UI: MAIN PAGE
  // ───────────────────────────────────────────────────────────────
  @override
  Widget build(BuildContext context) {
    if (formSchema.isEmpty || inv_line_formSchema.isEmpty) {
      return const LoadingSpinCircle();
    }

    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // LEFT SIDE — INVOICE PREVIEW
        SizedBox(width: 400, child: _buildInvoicePreview()),

        // RIGHT SIDE — FORM ENTRY
        Expanded(
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(8.0),
            child: Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text('Invoice Details',
                      style:
                      TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
                  const SizedBox(height: 10),

                  Row(
                    children: [
                      SizedBox(
                          width: 250,
                          child:
                          buildField("Invoice No", formSchema, _formData)),
                      const SizedBox(width: 8),
                      Expanded(
                        child: buildField("Charged To", formSchema, _formData,
                            customers, ['Names', 'cust_accNo'], 'customer_id'),
                      ),
                    ],
                  ),
                  buildField("Description", formSchema, _formData),
                  SizedBox(
                      width: 250,
                      child:
                      buildField("Due Date", formSchema, _formData)),

                  const Divider(height: 30, thickness: 0.8),
                  const Text('Invoice Lines',
                      style:
                      TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),

                  if (chargePackages.isEmpty)
                    const LoadingSpinCircle()
                  else
                    Container(
                      margin: const EdgeInsets.all(4),
                      padding: const EdgeInsets.all(8),
                      decoration: BoxDecoration(
                        color: Colors.grey.shade100,
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Column(
                        children: [
                          Row(
                            children: [
                              Expanded(
                                child: buildField(
                                    "Charge Package",
                                    inv_line_formSchema,
                                    _invlines_formData,
                                    chargePackages,
                                    ['accpackageName', 'grouping'],
                                    'accpackage_id',
                                    updateLineTotal),
                              ),
                              Expanded(
                                child: buildField("Description",
                                    inv_line_formSchema, _invlines_formData,
                                    null, null, null, updateLineTotal),
                              ),
                              Expanded(
                                child: buildField("Unit Amount",
                                    inv_line_formSchema, _invlines_formData,
                                    null, null, null, updateLineTotal),
                              ),
                              Expanded(
                                child: buildField("Quantity",
                                    inv_line_formSchema, _invlines_formData,
                                    null, null, null, updateLineTotal),
                              ),
                              Padding(
                                padding:
                                const EdgeInsets.symmetric(horizontal: 4.0),
                                child: ElevatedButton.icon(
                                  onPressed: () {
                                    setState(() {
                                      if (_invlines_formData.isNotEmpty) {
                                        _invoiceLines.add(Map<String, dynamic>.from(_invlines_formData));
                                        _invlines_formData.clear();
                                      }
                                    });
                                  },
                                  icon: const Icon(Icons.add, size: 18),
                                  label: const Text("Add Line",
                                      style: TextStyle(fontSize: 13)),
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor: primaryPurple,
                                    foregroundColor: Colors.white,
                                  ),
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 6),
                          Text(
                            "Line Total: ${_invlines_formData['lineTotal'] ?? '0.00'}",
                            style: const TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Colors.green),
                          ),
                        ],
                      ),
                    ),

                  // Display added lines
                  const SizedBox(height: 10),
                  ..._invoiceLines.map((line) => ListTile(
                    dense: true,
                    contentPadding: EdgeInsets.zero,
                    title: Text(line['description'] ?? ''),
                    subtitle: Text(
                        'Qty: ${line['quantity']} × ${line['unitAmount']}'),
                    trailing: Text(
                      line['lineTotal'] ?? '0.00',
                      style: const TextStyle(fontWeight: FontWeight.bold),
                    ),
                  )),

                  const SizedBox(height: 20),
                  Center(
                    child: InkWell(
                      onTap: () async {
                        if (_formKey.currentState!.validate()) {
                          _formKey.currentState!.save();
                          _formData['invlines'] = _invoiceLines;
                          _formData['companyId'] = companyId;

                          var resu = await auth.saveMany(
                              _formData, "/api/finance/invoice/add");

                          if (resu['data']?['success'] == true) {
                            setState(() {
                              _formData.clear();
                              _invoiceLines.clear();
                              _invlines_formData.clear();
                            });
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                content: Text('Invoice saved successfully!'),
                              ),
                            );
                            widget.onSaved?.call();
                          }
                        }
                      },
                      child: SContainer(
                        color: Colors.blueAccent,
                        child: const Padding(
                          padding: EdgeInsets.symmetric(
                              vertical: 8.0, horizontal: 50),
                          child: Text('Save Invoice',
                              style: TextStyle(color: Colors.white)),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }
}*/
