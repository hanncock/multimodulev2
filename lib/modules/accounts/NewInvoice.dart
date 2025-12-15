import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:get/get_utils/get_utils.dart';
import 'package:multimodule/reusables/loader.dart';
import 'package:printing/printing.dart';

import '../../Wrapper.dart';
import '../../reusables/RoundedContainer.dart';
import '../../reusables/constants.dart';
import '../../reusables/formbuilder.dart';
import '../../reusables/pdf_builder.dart';

class NewInvoice extends StatefulWidget {

  final VoidCallback? onSaved; // Add this in the constructor
  Map<String, dynamic>? editingRow;

  NewInvoice({this.editingRow, this.onSaved, super.key});

  @override
  State<NewInvoice> createState() => _NewInvoiceState();
}

class _NewInvoiceState extends State<NewInvoice> {

  Map<String, dynamic> _formData = {};
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  var invNo;

  bool sideContent = false;


  Map<String, dynamic> formSchema={};
  Map<String, dynamic> inv_line_formSchema={};
  List<Map<String, dynamic>> invoiceLines = [];

  List customers = [];

  List trxnDetails = [];

  List chargePackages = [];

  var overallTotal;


  getCustomers()async{
    var resu = await auth.getvalues("api/finance/customer/list");
    print("values found customers are ");
    setState(() {
      customers= resu;
    });
  }

  getInvNo()async{
    if(widget.editingRow != null){
      invNo = _formData["invNo"];
    }else {
      var resu = await auth.getvalues("invoiceNo");
      print("values found customers are ");
      setState(() {
        invNo = resu;
      });
    }

  }



  getFields()async{
    var resu = await auth.getvalues("apifields/finance/invoice");
    setState(() {
      formSchema = resu;
    });
  }

  getInvLines()async{
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


  updateLineTotal(int index, String? values) {


    final selectedPackage = chargePackages.firstWhereOrNull(
          (pkg) => pkg['accpackage_id'].toString() == values.toString(),
    );
    print(selectedPackage);

    if (selectedPackage != null) {
      setState(() {
        invoiceLines[index]['accpackage_id'] = selectedPackage['accpackage_id'];
        invoiceLines[index]['invLineDescr'] = selectedPackage['description'];
        // invoiceLines[index]['quantity'] = selectedPackage['quantity'].toString() ?? '1';
        invoiceLines[index]['quantity'] = '1';
        invoiceLines[index]['unitAmnt'] =
            selectedPackage['amount']?.toString() ?? '0';
      });
    }

    _recalculateLineTotal(index);
    setState(() {});
  }

  // selectCustomer(int index, String? values){
  selectCustomer(String? values){
    final selectedPackage = customers.firstWhereOrNull(
          (pkg) => pkg['customer_id'].toString() == values.toString(),
    );

    print("the selected Package is $selectedPackage");

    if (selectedPackage != null) {
      setState(() {
        _formData['chargedToName'] = selectedPackage['Names'];
      });
    }

  }



  void _recalculateLineTotal(int index) {
    print('recalculate has been called');
    final line = invoiceLines[index];

    print('changing price to ');


    final qty =
        double.tryParse(line['quantity']?.toString() ?? '1') ?? 1.0;
    final unit =
        double.tryParse(line['unitAmnt']?.toString() ?? '0') ?? 0.0;

    print("will be summing $qty  and $unit");


    final total = unit * qty;

      invoiceLines[index]['totalAmnt'] = total.toStringAsFixed(2);
    setState(() {

    });

    overallTotal = invoiceLines.fold<double>(
      0.0,
          (sum, item) =>
      sum +
          (double.tryParse(item['totalAmnt']?.toString() ?? '0') ?? 0.0),
    );

    print('the total amount is ${invoiceLines[index]['totalAmnt']}');

    _formData['amount'] = overallTotal;


  }
  getInvlines(existingInvNo)async{

      var resu = await auth.getvalues(
          "api/finance/invoiceline/list?invoice_No=${existingInvNo}");
      setState(() {
        invoiceLines = resu;
      });

  }



  void addInvoiceLine() {
    setState(() {
      invoiceLines.add({
        'invoice_No':invNo,
        'accpackage_id': '',
        'invLineDescr': '',
        'unitAmnt': '0',
        'quantity': '1',
        'totalAmnt': '0',
      });
    });
  }

  void removeInvoiceLine(int index) {
    setState(() {
      invoiceLines.removeAt(index);
    });
  }


  @override
  void initState(){
    super.initState();

    if (widget.editingRow != null) {
      _formData = Map<String, dynamic>.from(widget.editingRow!);
      invNo = _formData['invNo'];
      // _formData['issueDate'] = DateTime.now();
      overallTotal = _formData['amount'];
      // getInvlines(_formData['invNo']);
      if (_formData.containsKey('invoicelines')) {
        invoiceLines = List<Map<String, dynamic>>.from(_formData['invoicelines']);
      }
    }

    getInvLines();

    getFields();
    getCustomers();

    getChargePackages();
    getInvNo();
  }

  Future<void> shareInvoicePdf(Uint8List pdfBytes) async {
    await Printing.sharePdf(bytes: pdfBytes, filename: "invoice.pdf");
  }


  @override
  Widget build(BuildContext context) {
    return formSchema.isEmpty
        ? LoadingSpinCircle()
        : Row(
      children: [
        /*Container(
          width: 550,
          child: Card(
            elevation: 8,
            child: Column(
              children: [
                Row(
                  mainAxisAlignment:MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      children: [
                        SContainer(
                          child: Icon(Icons.label),
                        ),
                        Text('$companyName')
                      ],
                    ),
                    Column(
                      children: [
                        Text('Issue Date'),
                        Text('Due Date: ${_formData['dueDate']}')
                      ],
                    )
                  ],
                ),
                Divider(thickness: 0.5,),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    const Text('BILL TO:'),
                    const SizedBox(height: 2),
                    Text(_formData['chargedToName']?.toString() ?? ""),
                  ],
                ),

                Text('Invoice Sample'),
                // Text('${_invlines_formData}'),
                // Text('${_formData}'),
                // Text('Invoice Lines: $invoiceLines'),
                ...invoiceLines.map((item)=>Text('${item}'))
              ],
            ),
          ),
        ),*/

      Container(
      width: 550,
      padding: const EdgeInsets.all(16),
      child: Card(
        elevation: 8,
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  ElevatedButton(
                    onPressed: () async {
                      Uint8List pdf = await buildInvoicePdf(
                        _formData,
                        invoiceLines,
                        companyName,
                      );

                      await shareInvoicePdf(pdf); // Share without saving
                    },
                    child: Text("Share Invoice"),
                  ),

                  ElevatedButton(
                    onPressed: () async {
                      Uint8List pdf = await buildInvoicePdf(_formData, invoiceLines, companyName);
                      await Printing.layoutPdf(onLayout: (_) async => pdf);
                    },
                    child: Text("Download / Print Invoice"),
                  ),

                  ElevatedButton(
                    onPressed: () async {
                      final pdfBytes = await buildInvoicePdf(
                        _formData,
                        invoiceLines,
                        companyName,
                      );

                      await Printing.layoutPdf(
                        onLayout: (_) async => pdfBytes,
                      );
                    },
                    child: Text("Download Invoice"),
                  ),



                ],
              ),

              // ---------- HEADER ----------
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [

                  // Company Info
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SContainer(child: Icon(Icons.label)),
                      const SizedBox(height: 4),
                      Text(
                        companyName,
                        style: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),

                  // Invoice Dates
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      const Text(
                        'Issue Date:',
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                      // Text(_formData['issueDate'] ?? ""),
                      // Text(formatDate(_formData['issueDate'] ?? '')),
                      const SizedBox(height: 8),

                      const Text(
                        'Due Date:',
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                      // Text(_formData['dueDate'] ?? ""),
                      // Text(formatDate(_formData['dueDate'] ?? '')),
                    ],
                  ),

                ],
              ),

              const SizedBox(height: 16),
              const Divider(thickness: 1),

              // ---------- BILL TO ----------
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'BILL TO:',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 4),
                  Text(_formData['chargedToName'] ?? ""),
                ],
              ),

              const SizedBox(height: 24),

              // ---------- INVOICE TITLE ----------
              const Text(
                "INVOICE",
                style: TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 16),

              // ---------- TABLE HEADER ----------
              Container(
                padding: const EdgeInsets.symmetric(vertical: 8),
                color: Colors.grey.shade200,
                child: Row(
                  children: const [
                    Expanded(flex: 4, child: Text("Description", style: TextStyle(fontWeight: FontWeight.bold))),
                    Expanded(flex: 1, child: Text("Qty", style: TextStyle(fontWeight: FontWeight.bold))),
                    Expanded(flex: 2, child: Text("Rate", style: TextStyle(fontWeight: FontWeight.bold))),
                    Expanded(flex: 2, child: Text("Amount", style: TextStyle(fontWeight: FontWeight.bold))),
                  ],
                ),
              ),

              const Divider(),

              // ---------- TABLE ROWS ----------
              ...invoiceLines.map((item) {
                return Padding(
                  padding: const EdgeInsets.symmetric(vertical: 4),
                  child: Row(
                    children: [
                      Expanded(flex: 4, child: Text(item['invLineDescr'] ?? "")),
                      Expanded(flex: 1, child: Text("${item['quantity']}")),
                      Expanded(flex: 2, child: Text("${item['unitAmnt']}")),
                      Expanded(flex: 2, child: Text("${item['totalAmnt']}")),
                    ],
                  ),
                );
              }).toList(),

              const Divider(),
              const SizedBox(height: 10),

              // ---------- TOTALS SECTION ----------
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Row(
                        children: [
                          const Text("Subtotal: ",
                              style: TextStyle(fontWeight: FontWeight.bold)),
                          Text("${_formData['overallTotal']}"),
                        ],
                      ),
                      Row(
                        children: [
                          const Text("Tax: ",
                              style: TextStyle(fontWeight: FontWeight.bold)),
                          Text("${_formData['tax']}"),
                        ],
                      ),
                      const SizedBox(height: 8),
                      Row(
                        children: [
                          const Text("TOTAL: ",
                              style: TextStyle(
                                  fontSize: 18, fontWeight: FontWeight.bold)),
                          Text("${_formData['amount']}",
                              style: const TextStyle(
                                  fontSize: 18, fontWeight: FontWeight.bold)),
                        ],
                      ),
                    ],
                  ),
                ],
              ),

              const SizedBox(height: 20),

              // ---------- NOTES ----------
              const Text(
                "Notes:",
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              Text(
                _formData["notes"] ?? "Thank you for your business!",
              ),

            ],
          ),
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
                    Text('${_formData['status']}'),

                    Row(
                      children: [
                        Container(
                            width: 300,
                            child: buildField("Custom Invoice No", formSchema, _formData)
                        ),
                        Expanded(child: buildField("Charged To", formSchema, _formData,customers,['Names','cust_accNo'],'customer_id',(selected) => selectCustomer(selected))),
                        // Expanded(child: buildField("Charged To", formSchema, _formData,customers,['Names','cust_accNo'],'customer_id')),
                      ],
                    ),
                    // buildField("Invoice No", formSchema, _formData),
                    // buildField("Charged To", formSchema, _formData),
                    buildField("Description", formSchema, _formData),
                    SizedBox(
                        width: 300,
                        child: buildField("Due Date", formSchema, _formData)
                    ),

                  ],
                ),
                Text('${invoiceLines}'),
                Container(
                    child: Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          // mainAxisSize: MainAxisSize.max,
                          children: [
                            Text('Items '),
                            ElevatedButton.icon(
                              onPressed: () {
                                print("formdata valuea are $_formData");
                                _formData.putIfAbsent("invoicelines", () => []);

                                addInvoiceLine();

                                // _formData['invoicelines'].add(_invlines_formData);
                                // sideContent = !sideContent;
                                // row.clear();
                                setState(() {});
                              },
                              icon: Icon(Icons.add, size: 18),
                              label: const Text("", style: TextStyle(fontSize: 13)),
                              style: ElevatedButton.styleFrom(
                                backgroundColor: primaryPurple,
                                foregroundColor: Colors.white,
                                elevation: 0,
                                padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
                                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                              ),
                            )
                          ],
                        ),
                        Divider(thickness: 0.5,),


                        /*Column(
                          children: invoiceLines.asMap().entries.map((entry) {
                            final index = entry.key;
                            final line = entry.value;

                            return Card(
                              margin:  EdgeInsets.symmetric(vertical: 4),
                              elevation: 2,
                              child: Padding(
                                padding:  EdgeInsets.all(8.0),
                                child: Row(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Expanded(
                                      flex: 3,
                                      child: buildField(
                                        "Charge Package",
                                        inv_line_formSchema,
                                        line,
                                        chargePackages,
                                        ['accpackageName', 'grouping'],
                                        'accpackage_id',
                                            (selected) => updateLineTotal(index, selected),
                                      ),
                                    ),
                                     SizedBox(width: 8),
                                    Expanded(
                                      flex: 3,
                                      // child: buildField("Description", inv_line_formSchema, line),
                                      // child: buildField("Description", inv_line_formSchema, line,[],(selected) => updateLineTotal(index, selected)),
                                      child: buildField("Description", inv_line_formSchema, line,[],(value) => line['invLineDescr'] = value),


                                    ),
                                     SizedBox(width: 8),
                                    Expanded(
                                      flex: 2,
                                      // child: buildField("Unit Amount", inv_line_formSchema, line,[],(selected)=> updateLineTotal(index, selected)),
                                      child: buildField("Unit Amount", inv_line_formSchema, line,[], (value) {
                                        setState((){
                                          line['unitAmnt'] = value;

                                        });

                                        _recalculateLineTotal(index);
                                      },),
                                    ),
                                     SizedBox(width: 8),
                                    Expanded(
                                      flex: 2,
                                      child: buildField("Quantity", inv_line_formSchema, line, [], (value) {
                                        line['quantity'] = value;
                                        print('changing quantity');
                                        setState(() {});
                                        _recalculateLineTotal(index);
                                      },
                                      ),
                                    ),

                                    Expanded(
                                      flex: 2,
                                      child: buildField("Total Unit Amount", inv_line_formSchema, line),//[], (value) {
                                        // line['totalAmnt'] = value;
                                        // _recalculateLineTotal(index);
                                      // },),
                                    ),
                                     SizedBox(width: 8),
                                    Column(
                                      children: [
                                        IconButton(
                                          icon:  Icon(Icons.delete, color: Colors.red),
                                          onPressed: () => removeInvoiceLine(index),
                                        ),
                                        (invoiceLines.isEmpty || _formData['status'] == 'DRAFT' || invoiceLines[index]['invoiceline_id'] == null) ?Text('') :IconButton(
                                          icon:  Icon(Icons.more_vert_outlined, color: Colors.blue),
                                          onPressed: ()async{
                                            var resu = await auth.getvalues('api/finance/journalentry/list?transaction_id=${invoiceLines[index]['invoiceline_id']}');
                                            print(resu);

                                            trxnDetails = resu;
                                            // onPressed: () {
                                              sideContent = !sideContent;
                                              // row.clear();
                                              setState(() {});
                                            // },

                                          },
                                          // onPressed: () => removeInvoiceLine(index),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            );
                          }).toList(),
                        ),*/

                        Column(
                          children: invoiceLines.asMap().entries.map((entry) {
                            final index = entry.key;
                            final line = entry.value;

                            return Card(
                              margin: EdgeInsets.symmetric(vertical: 4),
                              elevation: 2,
                              child: Padding(
                                padding: EdgeInsets.all(8.0),
                                child: Row(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    // ---------- Charge Package Dropdown ----------
                                    Expanded(
                                      flex: 3,
                                      child: buildField(
                                        "Charge Package",
                                        inv_line_formSchema,
                                        line,
                                        chargePackages,
                                        ['accpackageName', 'grouping'],
                                        'accpackage_id',
                                            (selected) => updateLineTotal(index, selected),
                                      ),
                                    ),
                                    SizedBox(width: 8),

                                    // ---------- Description ----------
                                    Expanded(
                                      flex: 3,
                                      child: buildField(
                                        "Description",
                                        inv_line_formSchema,
                                        line,
                                        [],
                                        null,
                                        null,
                                            (value) => line['invLineDescr'] = value,
                                      ),
                                    ),
                                    SizedBox(width: 8),

                                    // ---------- Unit Amount ----------
                                    Expanded(
                                      flex: 2,
                                      child: buildField(
                                        "Unit Amount",
                                        inv_line_formSchema,
                                        line,
                                        [],
                                        null,
                                        null,
                                            (value) {
                                          line['unitAmnt'] = value;
                                          _recalculateLineTotal(index);
                                        },
                                      ),
                                    ),
                                    SizedBox(width: 8),

                                    // ---------- Quantity ----------
                                    Expanded(
                                      flex: 2,
                                      child: buildField(
                                        "Quantity",
                                        inv_line_formSchema,
                                        line,
                                        [],
                                        null,
                                        null,
                                            (value) {
                                          line['quantity'] = value;
                                          _recalculateLineTotal(index);
                                        },
                                      ),
                                    ),
                                    SizedBox(width: 8),

                                    // ---------- Total Amount (read-only) ----------
                                    Expanded(
                                      flex: 2,
                                      child: buildField(
                                        "Total Unit Amount",
                                        inv_line_formSchema,
                                        line,
                                        [],
                                        null,
                                        null,
                                        null, // No callback; computed automatically
                                      ),
                                    ),
                                    SizedBox(width: 8),

                                    // ---------- Actions ----------
                                    Column(
                                      children: [
                                        IconButton(
                                          icon: Icon(Icons.delete, color: Colors.red),
                                          onPressed: () => removeInvoiceLine(index),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            );
                          }).toList(),
                        ),


                        // Column(
                        //   children: invoiceLines.asMap().entries.map((entry) {
                        //     final index = entry.key;
                        //     final line = entry.value;
                        //
                        //     return Card(
                        //       margin: EdgeInsets.symmetric(vertical: 4),
                        //       elevation: 2,
                        //       child: Padding(
                        //         padding: EdgeInsets.all(8.0),
                        //         child: Row(
                        //           crossAxisAlignment: CrossAxisAlignment.start,
                        //           children: [
                        //             // Charge Package Dropdown
                        //             Expanded(
                        //               flex: 3,
                        //               child: buildField(
                        //                 "Charge Package",
                        //                 inv_line_formSchema,
                        //                 line,
                        //                 chargePackages,
                        //                 ['accpackageName', 'grouping'],
                        //                 'accpackage_id',
                        //                     (selected) => updateLineTotal(index, selected),
                        //               ),
                        //             ),
                        //             SizedBox(width: 8),
                        //
                        //             // Description
                        //             Expanded(
                        //               flex: 3,
                        //               child: buildField(
                        //                 "Description",
                        //                 inv_line_formSchema,
                        //                 line,
                        //                 [],
                        //                 null,
                        //                 null,
                        //                     (value) => line['invLineDescr'] = value,
                        //               ),
                        //             ),
                        //             SizedBox(width: 8),
                        //
                        //             // Unit Amount
                        //             Expanded(
                        //               flex: 2,
                        //               child: buildField(
                        //                 "Unit Amount",
                        //                 inv_line_formSchema,
                        //                 line,
                        //                 [],
                        //                 null,
                        //                 null,
                        //                     (value) {
                        //                   line['unitAmnt'] = value;
                        //                   _recalculateLineTotal(index);
                        //                 },
                        //               ),
                        //             ),
                        //             SizedBox(width: 8),
                        //
                        //             // Quantity
                        //             Expanded(
                        //               flex: 2,
                        //               child: buildField(
                        //                 "Quantity",
                        //                 inv_line_formSchema,
                        //                 line,
                        //                 [],
                        //                 null,
                        //                 null,
                        //                     (value) {
                        //                   line['quantity'] = value;
                        //                   _recalculateLineTotal(index);
                        //                 },
                        //               ),
                        //             ),
                        //             SizedBox(width: 8),
                        //
                        //             // Total Amount (read-only)
                        //             Expanded(
                        //               flex: 2,
                        //               child: buildField(
                        //                 "Total Unit Amount",
                        //                 inv_line_formSchema,
                        //                 line,
                        //               ),
                        //             ),
                        //             SizedBox(width: 8),
                        //
                        //             // Action buttons
                        //             Column(
                        //               children: [
                        //                 IconButton(
                        //                   icon: Icon(Icons.delete, color: Colors.red),
                        //                   onPressed: () => removeInvoiceLine(index),
                        //                 ),
                        //               ],
                        //             ),
                        //           ],
                        //         ),
                        //       ),
                        //     );
                        //   }).toList(),
                        // ),

                      ],
                    )
                ),

                Text('total Amount $overallTotal'),
                Row(
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 12.0),
                      child: InkWell(
                        onTap: ()async{
                          _formKey.currentState!.save();

                          showDialog(
                            context: context,
                            barrierColor: Colors.black38,
                            builder: (_) => Center(child: LoadingSpinCircle()),
                            barrierDismissible: false,
                          );

                          _formData['invoicelines'] = invoiceLines;
                          _formData['invNo'] = invNo;
                          _formData['status'] = 'DRAFT';
                          _formData['trnxType'] = 'INV';
                          _formData.putIfAbsent("companyId", () => companyId);
                          print(_formData);

                          var resu = await auth.saveMany(_formData, "/api/finance/invoice/add");

                          if (resu['data']?['success'] == true) {
                            _formData.clear();
                            invoiceLines.clear();
                            // _formKey.currentState!.reset();
                          }

                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(content: Text('Invoice saved successfully!')),
                          );

                          setState(() {});
                          Navigator.pop(context, 'refresh');



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
                    invoiceLines.isEmpty? Text(''):Padding(
                      padding: const EdgeInsets.symmetric(vertical: 12.0),
                      child: InkWell(
                        onTap: ()async{
                          print('getting values for je');

                          _formKey.currentState!.save();

                          showDialog(
                            context: context,
                            barrierColor: Colors.black38,
                            builder: (_) => Center(child: LoadingSpinCircle()),
                            barrierDismissible: false,
                          );

                          _formData['invoicelines'] = invoiceLines;
                          _formData['invNo'] = invNo;
                          _formData['status'] = 'PENDING';
                          _formData['trnxType'] = 'INV';
                          _formData.putIfAbsent("companyId", () => companyId);
                          print(_formData);

                          for(var item in _formData['invoicelines'] ) {
                            print(item);
                            // var data =
                            var deb = await auth.getvalues(
                                "api/finance/accpackage/list?accpackage_id=${item['chargedPackage']}");
                            var tocheck = deb;
                            var debitacc = await auth.getvalues(
                                "api/finance/coa/list?coa_id=${tocheck[0]['postingaccId']}");

                            var creditacc = await auth.getvalues(
                                "api/finance/coa/list?coa_id=${tocheck[0]['otherAccId']}");

                            Map de = {
                              "transaction_id": "${item['invoiceline_id']}",
                              "account_id": "${debitacc[0]['coa_id']}",
                              "accountName": "${debitacc[0]['accTitle']}",
                              "journalDate": "",
                              "debit": "${item['totalAmnt']}",
                              "credit": "0.00",
                              "journalDate":DateTime.now().millisecondsSinceEpoch
                            };

                            Map cr = {
                              "transaction_id": "${item['invoiceline_id']}",
                              "account_id": "${creditacc[0]['coa_id']}",
                              "accountName": "${creditacc[0]['accTitle']}",
                              "journalDate": "",
                              "debit": "0.00",
                              "credit": "${item['totalAmnt']}",
                              "journalDate":DateTime.now().millisecondsSinceEpoch

                            };
                            // List tosend = [de, cr];

                            // List<Map<String, d>>> journalEntry = tosend;

                            // invoiceLines.add(journalEntry);

                            item['journalentries'] = [de, cr];

                            // print("to send is ${tosend}");

                            // tosent.add(cr)

                            // print(de);
                            // print(cr);

                            // var resu = await auth.saveMany(
                            //     tosend, "/api/finance/journalentry/add");
                            // print("result is $resu");
                            //
                            //
                            // // var resu2 = await auth.saveMany(cr, "/api/finance/journalentry/add");
                            //
                            // // if (resu2['data']?['success'] == true && resu['data']?['success'] == true) {
                            // if (resu['data']?['success'] == true) {
                            //   Map updateStatus = {
                            //     "status": "PENDING",
                            //     "invoice_id": "${item['invoice_id']}"
                            //   };
                            //   var up_inv_stus = await auth.saveMany(
                            //       updateStatus, "/api/finance/invoice/add");
                            //   print(up_inv_stus);
                            //
                            //   _formData.clear();
                            //   invoiceLines.clear();
                            //   _formKey.currentState!.reset();
                            // }
                            //
                            // ScaffoldMessenger.of(context).showSnackBar(
                            //   const SnackBar(
                            //       content: Text('Invoice saved successfully!')),
                            // );
                          }
                          print(_formData);
                          var resu = await auth.saveMany(_formData, "/api/finance/invoice/add");
                          print(resu);
                          print(resu['data']);
                          print(resu['data']['success']);
                          print(resu['data']['success'].runtimeType);

                          // if (resu2['data']?['success'] == true && resu['data']?['success'] == true) {
                          // if (resu['data']?['success'] == true) {
                          if (resu['data']['success'] == true) {
                            // Map updateStatus = {
                            //   "status": "PENDING",
                            //   "invoice_id": "${item['invoice_id']}"
                            // };
                            // var up_inv_stus = await auth.saveMany(
                            //     updateStatus, "/api/finance/invoice/add");
                            // print(up_inv_stus);

                            setState(() {
                              _formData.clear();
                              invoiceLines.clear();
                            });
                            Navigator.pop(context, 'refresh');


                            // _formKey.currentState!.reset();
                          }

                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                                content: Text('Invoice saved successfully!')),
                          );

                         /* if (resu['data']?['success'] == true) {
                          //   _formData.clear();
                          //   invoiceLines.clear();
                          //   _formKey.currentState!.reset();
                          // }
                          //

                          print(_formData['invoicelines']);
                          print(_formData['invoicelines'].length);

                          for(var item in _formData['invoicelines'] ) {
                            print(item);
                            // var data =
                            var deb = await auth.getvalues(
                                "api/finance/accpackage/list?accpackage_id=${item['chargedPackage']}");
                            var tocheck = deb;
                            var debitacc = await auth.getvalues(
                                "api/finance/coa/list?coa_id=${tocheck[0]['postingaccId']}");

                            var creditacc = await auth.getvalues(
                                "api/finance/coa/list?coa_id=${tocheck[0]['otherAccId']}");
                            // var postingacc = va

                            // print(debitacc);
                            // print(creditacc);


                            Map de = {
                              "transaction_id": "${item['invoiceline_id']}",
                              "account_id": "${debitacc[0]['coa_id']}",
                              "accountName": "${debitacc[0]['accTitle']}",
                              "journalDate": "",
                              "debit": "${item['totalAmnt']}",
                              "credit": "0.00"
                            };

                            Map cr = {
                              "transaction_id": "${item['invoiceline_id']}",
                              "account_id": "${creditacc[0]['coa_id']}",
                              "accountName": "${creditacc[0]['accTitle']}",
                              "journalDate": "",
                              "debit": "0.00",
                              "credit": "${item['totalAmnt']}"
                            };

                            List tosend = [de, cr];
                            print("to send is ${tosend}");

                            // tosent.add(cr)

                            // print(de);
                            // print(cr);

                            var resu = await auth.saveMany(
                                tosend, "/api/finance/journalentry/add");
                            print("result is $resu");


                            // var resu2 = await auth.saveMany(cr, "/api/finance/journalentry/add");

                            // if (resu2['data']?['success'] == true && resu['data']?['success'] == true) {
                            if (resu['data']?['success'] == true) {
                              Map updateStatus = {
                                "status": "PENDING",
                                "invoice_id": "${item['invoice_id']}"
                              };
                              var up_inv_stus = await auth.saveMany(
                                  updateStatus, "/api/finance/invoice/add");
                              print(up_inv_stus);

                              _formData.clear();
                              invoiceLines.clear();
                              _formKey.currentState!.reset();
                            }

                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                  content: Text('Invoice saved successfully!')),
                            );
                          }
                          }*/
                        },
                        /*onTap: () async {
                          print("Processing Journal Entries...");

                          List<Map<String, dynamic>> journalBatch = [];

                          for (var item in _formData['invoicelines']) {

                            print("Processing Line → $item");

                            // 1️⃣ Get the charge package details
                            var pkg = await auth.getvalues(
                                "api/finance/accpackage/list?accpackage_id=${item['chargedPackage']}"
                            );

                            var charge = pkg[0];

                            // 2️⃣ Identify correct accounts
                            var debitAcc = await auth.getvalues(
                                "api/finance/coa/list?coa_id=${charge['otherAccId']}"
                            );

                            var creditAcc = await auth.getvalues(
                                "api/finance/coa/list?coa_id=${charge['postingaccId']}"
                            );

                            print("DEBIT → ${debitAcc[0]['accTitle']}");
                            print("CREDIT → ${creditAcc[0]['accTitle']}");

                            // 3️⃣ Build DEBIT entry
                            journalBatch.add({
                              "transaction_id": item['invoiceline_id'],
                              "account_id": debitAcc[0]['coa_id'],
                              "accountName": debitAcc[0]['accTitle'],
                              "journalDate": item['date'] ?? "",
                              "debit": item['totalAmnt'].toString(),
                              "credit": "0.00"
                            });

                            // 4️⃣ Build CREDIT entry
                            journalBatch.add({
                              "transaction_id": item['invoiceline_id'],
                              "account_id": creditAcc[0]['coa_id'],
                              "accountName": creditAcc[0]['accTitle'],
                              "journalDate": item['date'] ?? "",
                              "debit": "0.00",
                              "credit": item['totalAmnt'].toString()
                            });
                          }

                          print("FINAL JOURNAL BATCH → $journalBatch");

                          // 5️⃣ Save all entries at once
                          var result = await auth.saveMany(
                              journalBatch,
                              "/api/finance/journalentry/addMany"
                          );

                          if (result['data']?['success'] == true) {
                            _formData.clear();
                            invoiceLines.clear();
                            _formKey.currentState!.reset();

                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(content: Text('Invoice & Journal Entries saved successfully!')),
                            );
                          } else {
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(content: Text('Failed to save journal entries!')),
                            );
                          }
                        },*/
                        child: SContainer(
                          color: Colors.blueAccent,
                          child: Padding(
                            padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 50),
                            child: Text('Save & Post', style: TextStyle(color: Colors.white)),
                          ),
                        ),
                      ),
                    )
                  ],
                ),
              ],
            ),
          ),
        ),

        sideContent ? SContainer(
          height: MediaQuery.of(context).size.height * 0.9,
          color: Colors.white,
          width: 550,
          // color: Colors.blueAccent,
          child: Expanded(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Expanded(child: SContainer(
                      color: Colors.blueAccent,
                      child: Center(child:  Text('Transaction Details',style: TextStyle(color: Colors.white,fontSize: 14),)),
                    ),)
                  ],
                ),
                Text('${trxnDetails}')
                // NewCustomer(
                //   editingRow: row,
                //   onSaved: () {
                //     getCustomers(); // Refresh list
                //     setState(() {
                //       sideContent = false; // Optionally close the form after save
                //     });
                //   },
                // )

              ],
            ),
          ),
        ): SizedBox(child: Text(''),)
      ],
    );
  }
}

